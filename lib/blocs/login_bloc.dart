/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:meshi/blocs/base_bloc.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/data/repository/UserRepository.dart';
import 'package:meshi/data/repository/UserRepositoryImp.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BaseBloc {
  final UserRepository repository = UserRepositoryImp();

  final _userSubject = PublishSubject<User>();

  // stream outputs
  Stream<User> get userStream => _userSubject.stream;

  void initFacebookLogin() async {
    var diegoId = "10219787681781369";
    progressSubject.sink.add(true);
    repository.loginUser(diegoId)
        .handleError((error) {
      errorSubject.sink.add(error.toString());
    }).doOnEach((data) {
      progressSubject.sink.add(false);
    }).listen((user) {
      SessionManager.instance.user = user;
      _userSubject.sink.add(user);
    });

    /*
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
        SessionManager.instance.fbToken = facebookLoginResult.accessToken.token;
        SessionManager.instance.fbUserId = facebookLoginResult.accessToken.userId;
        repository.loginUser(diegoId).handleError((error) {
      errorSubject.sink.add(error.toString());
    }).doOnEach((data) {
      progressSubject.sink.add(false);
    }).listen((user) {
      SessionManager.instance.user = user;
      _userSubject.sink.add(user);
    });
        break;
    }
    */
  }

  @override
  dispose() {
    super.dispose();
    _userSubject.close();
  }
}
