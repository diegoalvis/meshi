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

  initFacebookLogin() async {
//    var diegoId = "10219787681781369";
//    repository.loginUser(diegoId).then((user) {
//      SessionManager.instance.user = user;
//      _userSubject.sink.add(user);
//    });

    var facebookLogin = FacebookLogin();
    var facebookLoginResult = await facebookLogin.logInWithReadPermissions(['email', 'user_birthday']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        errorSubject.sink.add("Error trying to log in in facebook");
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        break;
      case FacebookLoginStatus.loggedIn:
        // TODO: we must save this token using the user preferences
        SessionManager.instance.fbToken = facebookLoginResult.accessToken.token;
        _userSubject.sink.addStream(Stream.fromFuture(repository
            .loginUser(facebookLoginResult.accessToken.userId)
            .then((user) => SessionManager.instance.user = user)));
        break;
    }
  }

  @override
  dispose() {
    super.dispose();
    _userSubject.close();
  }
}
