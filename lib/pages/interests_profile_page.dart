/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshi/bloc/interests_profile_bloc.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:meshi/utils/custom_widgets/compatibility_indicator.dart';
import 'package:meshi/utils/custom_widgets/interests_profile_image.dart';
import 'package:meshi/utils/icon_utils.dart';
import 'package:meshi/utils/widget_util.dart';

class InterestsProfilePage extends StatelessWidget with HomeSection {
  @override
  Widget get title {
    return Text("Perfil de intereses");
  }

  @override
  Widget build(BuildContext context) {
    UserDetail userDetails = ModalRoute.of(context).settings.arguments;
    final inject = InjectorWidget.of(context);
    return InjectorWidget.bind(
        bindFunc: (binder) {
          binder.bindSingleton(InterestsProfileBloc(
              userDetails.id, InjectorWidget.of(context).get(), InjectorWidget.of(context).get()));
        },
        child: Scaffold(body: InterestsProfileBody(userDetails)));
  }
}

class InterestsProfileBody extends StatelessWidget {
  UserDetail userDetail;
  int success;

  InterestsProfileBody(this.userDetail);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.85;

    User user;
    final _bloc = InjectorWidget.of(context).get<InterestsProfileBloc>();
    return BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is InitialState) {
            _bloc.dispatch(InterestsProfileEvents.getUserInfo);
          }
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is SuccessState<User>) {
            user = state.data;
          }
          if (state is SuccessState<int>) {
            success = state.data;
            Navigator.pop(context);
          }
          if (state is ErrorState) {
            onWidgetDidBuild(() {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Ocurrió un error")));
            });
          }
          return user == null
              ? Center(child: Text("No hay información disponible"))
              : Column(
                  children: <Widget>[
                    Container(
                      height: height,
                      child: InterestsProfileImage(
                        user: user,
                        widget1: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CompatibilityIndicator(),
                        ),
                        widget2: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Card(
                            child: ListTile(
                              title: Text('Acerca de mi', style: TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text(user?.description ?? ""),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    userDetail.isMyLike ? isMyLike(context) : likesMe(context),
                  ],
                );
        });
  }

  Widget likesMe(BuildContext context) {
    final _bloc = InjectorWidget.of(context).get<InterestsProfileBloc>();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          success == 0
              ? CircularProgressIndicator()
              : FlatButton(
                  onPressed: () {
                    _bloc.dispatch(InterestsProfileEvents.DisLike);
                  },
                  child: Row(
                    children: <Widget>[
                      //Image.asset(IconUtils.heartBroken, scale: 8.0, color: Theme.of(context).primaryColor),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'NO ME INTERESA',
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
          success == 0
              ? CircularProgressIndicator()
              : RaisedButton(
                  onPressed: () {
                    _bloc.dispatch(InterestsProfileEvents.AddMatch);
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  color: Theme.of(context).accentColor,
                  child: Row(
                    children: <Widget>[
                      Image.asset(IconUtils.wave, scale: 3.5, color: Colors.white),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('ME INTERESA'),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }

  Widget isMyLike(BuildContext context) {
    final _bloc = InjectorWidget.of(context).get<InterestsProfileBloc>();
    return Padding(
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
                  child: success == 0
                      ? CircularProgressIndicator()
                      : Text(
                          'YA NO ME INTERESA',
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
  final bool isMyLike;

  UserDetail({this.id, this.isMyLike});
}
