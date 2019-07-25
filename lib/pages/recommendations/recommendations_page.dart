/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshi/data/api/base_api.dart';
import 'package:meshi/data/models/my_likes.dart';
import 'package:meshi/data/models/recomendation.dart';
import 'package:meshi/managers/location_manager.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/pages/recommendations/recommendations_bloc.dart';
import 'package:meshi/utils/app_icons.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:meshi/utils/custom_widgets/compatibility_indicator.dart';
import 'package:meshi/utils/custom_widgets/premium_speech_bubble.dart';
import 'package:meshi/utils/custom_widgets/view_more_recommendations.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/widget_util.dart';

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

class RecommendationsPage extends StatelessWidget with HomeSection, InjectorWidgetMixin {
  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    return InjectorWidget.bind(
        bindFunc: (binder) {
          binder.bindLazySingleton((inject, params) => RecommendationsBloc(injector.get(), injector.get()));
        },
        child: RecommendationsList());
  }
}

class RecommendationsList extends StatelessWidget with InjectorWidgetMixin {
  RecommendationsBloc _bloc;

  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    _bloc = injector.get<RecommendationsBloc>();
    _bloc.sendLocation(context);
    List<Recomendation> users = [];
    int idRecommendationAdded = -1;
    final strings = MyLocalizations.of(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          BlocBuilder(
              bloc: _bloc,
              builder: (context, state) {
                if (state is LoadingState) {
                  return Flexible(
                    child: Container(
                        color: Theme.of(context).primaryColor,
                        child: Center(
                            child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.onPrimary),
                        ))),
                  );
                }
                if (state is SuccessState<List<Recomendation>>) {
                  users = state.data;
                }
                if (state is ErrorState) {
                  onWidgetDidBuild(() {
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text(strings.anErrorOccurred)));
                  });
                }
                if (state is InitialState) {
                  _bloc.dispatch(GetRecommendationsEvent());
                }
                if (state is AddingMatchState) {
                  idRecommendationAdded = state.idMatch;
                }
                return Flexible(
                  child: Container(
                      color: Theme.of(context).primaryColor,
                      child: users.length > 0
                          ? Container(child: recommendationsCarousel(context, users, idRecommendationAdded))
                          : Center(child: Text(strings.noUsersAvailable, style: TextStyle(color: Colors.white)))),
                );
              }),
        ],
      ),
    );
  }

  Widget recommendationsCarousel(BuildContext context, List<Recomendation> users, int itemLoadingIndex) {
    return CarouselSlider(
      viewportFraction: 0.9,
//      enableInfiniteScroll: false,
      autoPlayCurve: Curves.bounceInOut,
      height: MediaQuery.of(context).size.height,
      autoPlay: false,
      items: generateRecommendationList(users, context, itemLoadingIndex),
    );
  }

  List<Widget> generateRecommendationList(List<Recomendation> recommendations, BuildContext context, int itemLoadingIndex) {
    final items = recommendations.map(
      (user) {
        return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 4.0, right: 4.0),
            child: Card(
                elevation: 8,
                child: carouselWidget(context, user, itemLoadingIndex)));
      },
    ).toList();
    items.add(ViewMoreRecommendations(() => _bloc.dispatch(GetRecommendationsEvent(looked: recommendations))));
    return items;
  }

  Widget carouselWidget(BuildContext context, Recomendation user, int itemLoadingIndex) {
    final strings = MyLocalizations.of(context);
    RecommendationsBloc _bloc;
    _bloc = InjectorWidget.of(context).get<RecommendationsBloc>();
    return Material(
      color: Color.fromARGB(255, 245, 245, 245),
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.54,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(BaseApi.IMAGES_URL_DEV + user.images[0]),
                      fit: BoxFit.cover,
                    )),
                  ),
                ),
                Container(
                    //height: 250,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
                  Colors.transparent.withOpacity(0),
                  Colors.transparent.withOpacity(0.15),
                ]))),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(user.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CompatibilityIndicator(
                    similarities: user.similarities,
                    compatibility: user.score,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: Container(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: ListTile(
                          title: Container(
                            height: 40,
                            child: Row(
                              children: <Widget>[
                                Text(strings.aboutMe, style: TextStyle(fontWeight: FontWeight.bold)),
                                Spacer(),
                                user.type == TYPE_PREMIUM ? PremiumSpeechBubble(isRecommendation: true) : SizedBox(),
                              ],
                            ),
                          ),
                          subtitle: Text(user?.description ?? ""),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: Container(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: ListTile(
                          title: Text(strings.myFreeTime, style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(user?.freeTime ?? ""),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: Container(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: ListTile(
                          title: Text(strings.myDedication, style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(user?.occupation ?? ""),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: Container(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: ListTile(
                          title: Text(strings.myInterestsDes, style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(user?.interests ?? ""),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          user.id == itemLoadingIndex
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          // _bloc.dispatch(DeleteInterestEvent(user));
                        },
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                strings.imNotInterested,
                                style: TextStyle(fontSize: 11, color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          _bloc.dispatch(AddMatchEvent(user));
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        color: Theme.of(context).accentColor,
                        child: Row(
                          children: <Widget>[
                            Icon(AppIcons.curve, size: 11, color: Colors.white),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                strings.myInterests,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
