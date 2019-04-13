/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:meshi/data/repository/UserRepository.dart';
import 'package:meshi/data/repository/UserRepositoryImp.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final _fbTokenSubject = PublishSubject<String>();

  final UserRepository userRepository = UserRepositoryImp();

  // stream outputs
  Stream<String> get fbToken => _fbTokenSubject.stream;

  initFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult = await facebookLogin.logInWithReadPermissions(['email', 'user_birthday']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        //TODO: Handle error
        print("Error");
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        break;
      case FacebookLoginStatus.loggedIn:
        // TODO: we could persits this token using preferences
        _fbTokenSubject.sink.add(facebookLoginResult.accessToken.token);
        break;
    }
  }

  dispose() {
    _fbTokenSubject.close();
  }
}
