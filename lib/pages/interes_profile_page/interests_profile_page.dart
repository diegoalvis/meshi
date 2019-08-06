/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshi/data/models/my_likes.dart';
import 'package:meshi/data/models/recomendation.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/pages/interes_profile_page/interests_profile_bloc.dart';
import 'package:meshi/utils/app_icons.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:meshi/utils/custom_widgets/compatibility_indicator.dart';
import 'package:meshi/utils/custom_widgets/interests_profile_image.dart';
import 'package:meshi/utils/custom_widgets/premium_speech_bubble.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/widget_util.dart';

class InterestsProfilePage extends StatelessWidget with HomeSection {
  @override
  Widget getTitle(BuildContext context) {
    final strings = MyLocalizations.of(context);
    return Text("Perfil de intereses");
  }

  @override
  Widget build(BuildContext context) {
    UserDetail userDetails = ModalRoute.of(context).settings.arguments;
    return InjectorWidget.bind(
        bindFunc: (binder) {
          binder.bindSingleton(InterestsProfileBloc(
              userDetails.id, InjectorWidget.of(context).get()));
        },
        child: Scaffold(body: InterestsProfileBody(userDetails)));
  }
}

class InterestsProfileBody extends StatelessWidget {
  UserDetail userDetail;
  bool loading = false;
  double height;

  InterestsProfileBody(this.userDetail);

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    Recomendation user;
    final strings = MyLocalizations.of(context);
    final _bloc = InjectorWidget.of(context).get<InterestsProfileBloc>();
    return BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is InitialState) {
            _bloc.dispatch(InterestsProfileEvents.getUserInfo);
          }
          /*if(state is PremiumState){
            isPremium = state.data;
          }*/
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is PerformingRequestState) {
            loading = true;
          }
          if (state is SuccessState<Recomendation>) {
            user = state.data;
          }
          if (state is ExitState) {
            Navigator.pop(context);
          }
          if (state is ErrorState) {
            onWidgetDidBuild(() {
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text(strings.anErrorOccurred)));
            });
          }
          return user == null
              ? Center(child: Text(strings.noInformationAvailable))
              : InterestsProfileImage(
                  user: user,
                  content: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0.0, left: 8.0, right: 8.0),
                      child: CompatibilityIndicator(
                          compatibility: user.score,
                          similarities: user.similarities),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Container(
                              height: 40,
                              child: Row(
                                children: <Widget>[
                                  Text(strings.aboutMe,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Spacer(),
                                  user.type == TYPE_PREMIUM
                                      ? PremiumSpeechBubble(isRecommendation: false)
                                      : SizedBox(),
                                ],
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                user?.description ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8.0),
                      child: Container(
                        child: Card(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: ListTile(
                              title: Text(strings.myFreeTime,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text(user?.freeTime ?? ""),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8.0),
                      child: Container(
                        child: Card(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: ListTile(
                              title: Text(strings.myDedication,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text(user?.occupation ?? ""),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8.0),
                      child: Container(
                        child: Card(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: ListTile(
                              title: Text(strings.myInterestsDes,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text(user?.interests ?? ""),
                            ),
                          ),
                        ),
                      ),
                    ),
                    buildSection(context)
                  ],
                );
        });
  }

  Widget buildSection(BuildContext context) {
    if (userDetail.isMyLike == 1) {
      return buildIsMyLikeBottomSection(context);
    } else if (userDetail.isMyLike == 2) {
      return buildLikesMeBottomSection(context);
    } else {
      return SizedBox();
    }
  }

  Widget buildLikesMeBottomSection(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final _bloc = InjectorWidget.of(context).get<InterestsProfileBloc>();
    return loading
        ? Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    _bloc.dispatch(InterestsProfileEvents.DisLike);
                  },
                  child: Row(
                    children: <Widget>[
                      //Image.asset(IconUtils.heartBroken, scale: 8.0, color: Theme.of(context).primaryColor),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          strings.imNotInterested,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    _bloc.dispatch(InterestsProfileEvents.AddMatch);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: Theme.of(context).accentColor,
                  child: Row(
                    children: <Widget>[
                      Icon(AppIcons.curve, color: Colors.white, size: 18),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(strings.myInterests),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }

  Widget buildIsMyLikeBottomSection(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final _bloc = InjectorWidget.of(context).get<InterestsProfileBloc>();
    return loading
        ? Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                FlatButton(
                  onPressed: () {
                    _bloc.dispatch(InterestsProfileEvents.DisLike);
                  },
                  child: Row(
                    children: <Widget>[
                      //Image.asset(IconUtils.heartBroken, scale: 8.0, color: Theme.of(context).primaryColor),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          strings.imNotInterestedNow,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
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

class UserDetail {
  final int id;
  final int isMyLike;

  UserDetail({this.id, this.isMyLike});
}
