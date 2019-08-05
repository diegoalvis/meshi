/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshi/bloc/interests_bloc.dart';
import 'package:meshi/data/models/my_likes.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/pages/interests_profile_page.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:meshi/utils/custom_widgets/interests_image_item.dart';
import 'package:meshi/utils/custom_widgets/premium_page.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/widget_util.dart';

import '../../../main.dart';

class BaseInterestsPage extends StatelessWidget {
  final String title;
  final InterestsEventType eventType;
  final InterestsEventType refreshEventType;
  final int isMyLike;

  InterestsBloc _bloc;
  List<MyLikes> myLikes;

  BaseInterestsPage({Key key, this.title, this.eventType, this.refreshEventType, this.isMyLike}) : super(key: key);

  Future<Null> _refreshInterestsData() async {
    _bloc.dispatch(InterestsEvent(refreshEventType));
  }

  @override
  Widget build(BuildContext context) {
    _bloc = InjectorWidget.of(context).get<InterestsBloc>();
    final strings = MyLocalizations.of(context);
    if (myLikes == null) {
      _bloc.dispatch(InterestsEvent(eventType));
    }
    return BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is InitialState) {
            _bloc.dispatch(InterestsEvent(eventType));
          }
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is LikesFetchedState && eventType == state.eventGenerator) {
            myLikes = state.myLikes;
          }
          if (state is ErrorState) {
            onWidgetDidBuild(() {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text(strings.anErrorOccurred)));
            });
          }

          return RefreshIndicator(
              onRefresh: _refreshInterestsData,
              child: myLikes == null || myLikes.length == 0
                  ? ListView(children: <Widget>[
                      SizedBox(height: 100),
                      Center(
                          child: Text(
                        strings.noData,
                      ))
                    ])
                  : Column(
                      children: <Widget>[
                        Flexible(
                          child: GridView.builder(
                            itemCount: myLikes.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    validatePremiumAndPerformAction(context, _bloc.session, index);
                                  },
                                  child: InterestsItemPage(myLikes: myLikes[index], isPremium: _bloc.session?.user?.type == TYPE_PREMIUM, isMyLike: isMyLike));
                            },
                          ),
                        ),
                      ],
                    ));
        });
  }

  void validatePremiumAndPerformAction(BuildContext context, SessionManager session, int index) {
    if (isMyLike == 2 && session?.user?.type != TYPE_PREMIUM) {
      showDialog(barrierDismissible: true, context: context, builder: (BuildContext context) => PremiumPage(false));
    } else {
      Navigator.pushNamed(context, INTERESTS_PROFILE_ROUTE,
          arguments: UserDetail(id: myLikes[index].id, isMyLike: isMyLike));
    }
  }
}
