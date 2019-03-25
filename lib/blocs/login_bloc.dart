import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final _fbTokenSubject = PublishSubject<String>();

  // stream outputs
  Stream<String> get fbToken => _fbTokenSubject.stream;

  void initFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult = await facebookLogin.logInWithReadPermissions(['email']);
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
