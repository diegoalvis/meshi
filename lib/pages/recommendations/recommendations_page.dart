/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshi/data/api/base_api.dart';
import 'package:meshi/data/models/my_likes.dart';
import 'package:meshi/data/models/recomendation.dart';
import 'package:meshi/pages/recommendations/recommendations_bloc.dart';
import 'package:meshi/utils/app_icons.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:meshi/utils/custom_widgets/compatibility_indicator.dart';
import 'package:meshi/utils/custom_widgets/premium_speech_bubble.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/widget_util.dart';

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

class RecommendationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InjectorWidget.bind(
        bindFunc: (binder) {
          binder.bindSingleton(RecommendationsBloc(InjectorWidget.of(context).get()));
        },
        child: RecommendationsList());
  }
}

class RecommendationsList extends StatelessWidget {
  List<Recomendation> users = [];
  RecommendationsBloc _bloc;
  bool loading = false;
  bool isUser;

  @override
  Widget build(BuildContext context) {
    _bloc = InjectorWidget.of(context).get<RecommendationsBloc>();
    final strings = MyLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(strings.recommendations, style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: <Widget>[
          BlocBuilder(
              bloc: _bloc,
              builder: (context, state) {
                if (state is PerformingRequestState) {
                  loading = true;
                }
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
                  loading = false;
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
                return Flexible(
                  child: Container(
                      color: Theme.of(context).primaryColor,
                      child: users.length > 0
                          ? Container(child: recommendationsCarousel(context))
                          : Center(child: Text(strings.noUsersAvailable, style: TextStyle(color: Colors.white)))),
                );
              }),
        ],
      ),
    );
  }

  Widget recommendationsCarousel(BuildContext context) {
    return CarouselSlider(
      viewportFraction: 0.85,
      autoPlayCurve: Curves.easeIn,
      height: MediaQuery.of(context).size.height,
      autoPlay: false,
      items: users.map(
        (user) {
          return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
              child: carouselWidget(context, user));
        },
      ).toList(),
    );
  }

  Widget carouselWidget(BuildContext context, Recomendation user) {
    final strings = MyLocalizations.of(context);
    RecommendationsBloc _bloc;
    _bloc = InjectorWidget.of(context).get<RecommendationsBloc>();
    return Container(
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
                                user.type == TYPE_PREMIUM ? PremiumSpeechBubble() : SizedBox(),
                              ],
                            ),
                          ),

//                          Text('Acerca de mi', style: TextStyle(fontWeight: FontWeight.bold)),
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
          loading
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: <Widget>[
                      Spacer(),
                      RaisedButton(
                        onPressed: () {
                          _bloc.dispatch(AddMatchEvent(user));
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        color: Theme.of(context).accentColor,
                        child: Row(
                          children: <Widget>[
                            Icon(AppIcons.curve, size: 18, color: Colors.white),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                strings.myInterests,
                                textAlign: TextAlign.center,
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
