/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshi/bloc/interests_profile_bloc.dart';
import 'package:meshi/data/models/my_likes.dart';
import 'package:meshi/data/models/recomendation.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/utils/app_icons.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:meshi/utils/custom_widgets/compatibility_indicator.dart';
import 'package:meshi/utils/custom_widgets/interests_profile_image.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/widget_util.dart';
import 'package:speech_bubble/speech_bubble.dart';

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
          binder.bindSingleton(InterestsProfileBloc(userDetails.id, InjectorWidget.of(context).get()));
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
    bool isPremium = false;
    final strings = MyLocalizations.of(context);
    final _bloc = InjectorWidget.of(context).get<InterestsProfileBloc>();
    return BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is InitialState) {
            _bloc.dispatch(InterestsProfileEvents.getUserInfo);
          }
          if(state is PremiumState){
            isPremium = state.data;
          }
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
              Scaffold.of(context).showSnackBar(SnackBar(content: Text(strings.anErrorOccurred)));
            });
          }
          return user == null
              ? Center(child: Text(strings.noInformationAvailable))
              : Column(
                  children: <Widget>[
                    Expanded(
                      child: InterestsProfileImage(
                        user: user,
                        widget1: Padding(
                          padding: const EdgeInsets.only(top: 18.0, left: 8.0, right: 8.0),
                          child: CompatibilityIndicator(compatibility: user.score, similarities: user.similarities),
                        ),
                        widget2: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Row(
                                  children: <Widget>[
                                    Text(strings.aboutMe, style: TextStyle(fontWeight: FontWeight.bold)),
                                    Spacer(),
                                    user.type == TYPE_PREMIUM
                                        ? Row(
                                            children: <Widget>[
                                              isPremium ? premiumSpeechBubble(context): SizedBox(),
                                              GestureDetector(
                                                onTap: () {
                                                  _bloc.dispatch(InterestsProfileEvents.premium);
                                                  /*isPremium ? showDialog(context: context, builder: (context){
                                                    return premiumSpeechBubble(context);
                                                  }
                                                  ): SizedBox();*/
                                                },
                                                child: Icon(AppIcons.crown, color: Theme.of(context).accentColor, size: 15),
                                              ),
                                            ],
                                          )
                                        : SizedBox(),
                                  ],
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
                      ),
                    ),
                    buildSection(context)
                  ],
                );
        });
  }

  Widget premiumSpeechBubble(BuildContext context){
    return GestureDetector(
      onTap: () {/* TODO show premium dialog */},
      child: SpeechBubble(
        child: Text("Usuario premium", style: TextStyle(color: Theme.of(context).accentColor)),
        color: Colors.white,
        nipLocation: NipLocation.RIGHT,
      ),
    );
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
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    _bloc.dispatch(InterestsProfileEvents.AddMatch);
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  color: Theme.of(context).accentColor,
                  child: Row(
                    children: <Widget>[
                      Icon(AppIcons.curve, color: Colors.white, size: 30),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(strings.iAmInterested),
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
                          style: TextStyle(color: Theme.of(context).primaryColor),
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
