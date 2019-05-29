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

import '../../interests_profile_page.dart';

class BaseInterestsPage extends StatelessWidget {
  final String title;
  final InterestsEventType eventType;
  final bool isMyLike;

  InterestsBloc _bloc;
  List<MyLikes> myLikes;

  BaseInterestsPage({Key key, this.title, this.eventType, this.isMyLike}) : super(key: key);

  Future<Null> _fetchRewardData() async {
    _bloc.dispatch(eventType);
  }

  @override
  Widget build(BuildContext context) {
    _bloc = InjectorWidget.of(context).get<InterestsBloc>();
    final strings = MyLocalizations.of(context);
    return BlocListener(
      bloc: _bloc,
      listener: (context, state) {
        if (state is InitialState<InterestsEventType>) {
          _bloc.dispatch(state.initialData);
        }
      },
      child: BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is LikesFetchedState) {
              myLikes = state.myLikes;
            }
            if (state is ErrorState) {
              onWidgetDidBuild(() {
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Ocurrio un error")));
              });
            }

            return RefreshIndicator(
                onRefresh: _fetchRewardData,
                child: myLikes == null
                    ? ListView(children: <Widget>[SizedBox(height: 100), Center(child: Text("No se encontrar datos"))])
                    : Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(title ?? "",
                                  textAlign: TextAlign.end, style: TextStyle(color: ThemeData.light().colorScheme.onSurface)),
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
                                          arguments: UserDetail(id: myLikes[index].id, isMyLike: isMyLike));
                                    },
                                    child: InterestsItemPage(
                                      myLikes: myLikes[index],
                                    ));
                              },
                            ),
                          ),
                        ],
                      ));
          }),
    );
  }
}
