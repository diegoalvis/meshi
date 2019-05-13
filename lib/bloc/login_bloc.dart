/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class LoginBloc extends BaseBloc {
  final _userSubject = PublishSubject<User>();

  Stream<User> get userStream => _userSubject.stream;

  UserRepository repository;

  LoginBloc(this.repository, session) : super(session) {
    session.initUser().then((user) => _userSubject.sink.add(user));
  }

  void initFacebookLogin() async {
    /*
    var diegoId = "10219787681781369";
    progressSubject.sink.add(true);
    repository.loginUser(diegoId).catchError((error) {
      errorSubject.sink.add(error.toString());
    }).whenComplete(() {
      progressSubject.sink.add(false);
    }).then((success) {
      //TODO remover esto
      //session.user.state = User.NEW_USER;
      _userSubject.sink.add(session.user);
    });
    */

    progressSubject.sink.add(true);

    var facebookLogin = FacebookLogin();
    var facebookLoginResult = await facebookLogin.logInWithReadPermissions(['email', 'user_birthday']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        errorSubject.sink.add("Error trying to log in in facebook");
        progressSubject.sink.add(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        progressSubject.sink.add(false);
        break;
      case FacebookLoginStatus.loggedIn:
        // TODO: we must save this token using the user preferences
        final String fbId = facebookLoginResult.accessToken.userId;
        session.fbToken = facebookLoginResult.accessToken.token;
        session.fbUserId = facebookLoginResult.accessToken.userId;
        repository.loginUser(fbId).catchError((error) {
          errorSubject.sink.add(error.toString());
        }).whenComplete(() {
          progressSubject.sink.add(false);
        }).then((success) {
          _userSubject.sink.add(session.user);
        });
        break;
    }
  }

  @override
  dispose() {
    super.dispose();
    _userSubject.close();
  }
}
