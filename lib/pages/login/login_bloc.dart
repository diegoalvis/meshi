/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/pages/bloc/base_bloc.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class LoginBloc extends BaseBloc {
  final _userSubject = PublishSubject<User>();

  Stream<User> get userStream => _userSubject.stream;

  UserRepository repository;

  LoginBloc(this.repository, SessionManager session) : super(session: session) {
    session.initUser().then((user) => _userSubject.sink.add(user));
  }

  void initLoginTest(String facebookId) async {
    progressSubject.sink.add(true);
    repository.loginUser(facebookId).catchError((error) {
      errorSubject.sink.add(error.toString());
    }).whenComplete(() {
      progressSubject.sink.add(false);
    }).then((success) {
      //session.user.state = User.NEW_USER;
      session.setLogged(true);
      _userSubject.sink.add(session.user);
    });
  }

  void initFacebookLogin() async {
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
        final String fbId = facebookLoginResult.accessToken.userId;
        session.setFbToken(facebookLoginResult.accessToken.token);
        session.setFbUserId(facebookLoginResult.accessToken.userId);
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
