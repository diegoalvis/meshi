/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshi/bloc/interests_bloc.dart';
import 'package:meshi/data/models/my_likes.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:meshi/utils/custom_widgets/interests_image_item.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/widget_util.dart';
import 'package:meshi/pages/interests_profile_page.dart';

class BaseInterestsPage extends StatelessWidget {
  final String title;
  final InterestsEventType eventType;
  final InterestsEventType refreshEventType;
  final int isMyLike;

  InterestsBloc _bloc;
  List<MyLikes> myLikes;

  BaseInterestsPage({Key key, this.title, this.eventType, this.refreshEventType, this.isMyLike})
      : super(key: key);

  Future<Null> _refreshInterestsData() async {
    _bloc.dispatch(InterestsEvent(refreshEventType));
  }

  @override
  Widget build(BuildContext context) {
    _bloc = InjectorWidget.of(context).get<InterestsBloc>();
    if (myLikes == null) {
      _bloc.dispatch(InterestsEvent(eventType));
    }

    final strings = MyLocalizations.of(context);
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
              child: myLikes == null //|| myLikes.length == 0
                  ? ListView(children: <Widget>[
                      SizedBox(height: 100),
                      Center(
                          child: Text(
                        strings.noData,
                      ))
                    ])
                  : Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(title ?? "",
                                textAlign: TextAlign.end,
                                style: TextStyle(color: ThemeData.light().colorScheme.onSurface)),
                          ),
                        ),
                        Flexible(
                          child: GridView.builder(
                            itemCount: myLikes.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/interests-profile',
                                        arguments:
                                            UserDetail(id: myLikes[index].id, isMyLike: isMyLike));
                                  },
                                  child: InterestsItemPage(
                                    myLikes: myLikes[index],
                                  ));
                            },
                          ),
                        ),
                      ],
                    ));
        });
  }
}
