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
import 'package:meshi/data/models/user.dart';
import 'package:meshi/pages/bloc/base_bloc.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/pages/recommendations/recommendations_bloc.dart';
import 'package:meshi/pages/register/advance/advanced_register_container_page.dart';
import 'package:meshi/utils/app_icons.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:meshi/utils/custom_widgets/compatibility_indicator.dart';
import 'package:meshi/utils/custom_widgets/premium_page.dart';
import 'package:meshi/utils/custom_widgets/premium_speech_bubble.dart';
import 'package:meshi/utils/custom_widgets/view_more_recommendations.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/widget_util.dart';

class RecommendationsPage extends StatefulWidget with HomeSection {
  @override
  _RecommendationsPageState createState() => _RecommendationsPageState();
}

class _RecommendationsPageState extends State<RecommendationsPage> {
  RecommendationsBloc _bloc;
  bool _dialogShown = false;

  @override
  Widget build(BuildContext context) {
    final injector = InjectorWidget.of(context);
    _bloc = RecommendationsBloc(injector.get(), injector.get(), injector.get());
    _bloc.sendLocation(context);
    bool isMaxComplete = false;
    List<Recomendation> users = [];
    int idRecommendationAdded = -1;
    final strings = MyLocalizations.of(context);
    return BlocListener(
        listener: (context, state) {
          if (state is SuccessState<List<Recomendation>> && state.data.isEmpty && !_dialogShown) {
            setState(() {
              _dialogShown = true;
            });
            Future.delayed(Duration(milliseconds: 1500), () {
              showCompleteProfileAlert(context);
            });
          }
        },
        bloc: _bloc,
        child: Scaffold(
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
                    if (state is TriesCompleteState) {
                      users = state.looked;
                      isMaxComplete = state.isMaxComplete;
                    }
                    if (state is ErrorState) {
                      onWidgetDidBuild(() {
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text(strings.anErrorOccurred)));
                      });
                    }
                    if (state is InitialState) {
                      _bloc.add(GetRecommendationsEvent());
                    }
                    if (state is AddingMatchState) {
                      idRecommendationAdded = state.idMatch;
                    }
                    return Flexible(
                      child: Container(
                          color: Theme.of(context).primaryColor,
                          child: users.length > 0
                              ? Container(child: recommendationsCarousel(context, users, idRecommendationAdded, isMaxComplete))
                              : Center(child: Text(strings.noUsersAvailable, style: TextStyle(color: Colors.white)))),
                    );
                  }),
            ],
          ),
        ));
  }

  void showCompleteProfileAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (cxt) {
          final strings = MyLocalizations.of(context);
          return SimpleDialog(
            contentPadding: const EdgeInsets.all(16.0),
            children: [
              Text(
                strings.completeYourProfile,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              ListTile(
                title: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdvancedRegisterContainerPage(doWhenFinish: BaseBloc.ACTION_POP_PAGE)));
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    color: Theme.of(context).accentColor,
                    child: Text(strings.completeProfileButton)),
              ),
            ],
          );
        });
  }

  Widget recommendationsCarousel(BuildContext context, List<Recomendation> users, int itemLoadingIndex, bool isMaxComplete) {
    return CarouselSlider(
      viewportFraction: 0.9,
      enableInfiniteScroll: false,
      autoPlayCurve: Curves.bounceInOut,
      height: MediaQuery.of(context).size.height,
      autoPlay: false,
      items: generateRecommendationList(users, context, itemLoadingIndex, isMaxComplete),
    );
  }

  List<Widget> generateRecommendationList(
      List<Recomendation> recommendations, BuildContext context, int itemLoadingIndex, bool isMaxComplete) {
    final items = recommendations.map(
      (user) {
        return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 4.0, right: 4.0),
            child: Card(elevation: 8, child: carouselWidget(context, user, itemLoadingIndex)));
      },
    ).toList();
    items.add(ViewMoreRecommendations(() {
      isMaxComplete
          ? showDialog(barrierDismissible: true, context: context, builder: (BuildContext context) => PremiumPage(true))
          : _bloc.add(GetRecommendationsEvent(looked: recommendations));
    }));
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
                      alignment: FractionalOffset.topCenter,
                    )),
                  ),
                ),
                buildGradientContainer(context, height: 100),
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
            child: Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CompatibilityIndicator(
                        isPremium: _bloc.session?.user?.type == TYPE_PREMIUM,
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
//                buildGradientContainer(context, height: 25),
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
                          if (_bloc.session.user.state != User.ADVANCED_USER) {
                            showCompleteProfileAlert(context);
                          } else {
                            _bloc.add(DeleteInterestEvent(user));
                          }
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
                          if (_bloc.session.user.state != User.ADVANCED_USER) {
                            showCompleteProfileAlert(context);
                          } else {
                            _bloc.add(AddMatchEvent(user));
                          }
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
