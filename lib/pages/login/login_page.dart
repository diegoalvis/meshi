import 'package:flutter/material.dart';
import 'package:meshi/blocs/login_bloc.dart';
import 'package:meshi/pages/register/register_page.dart';
import 'package:meshi/utils/localiztions.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _bloc = LoginBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    _bloc.fbToken.takeWhile((token) => token.isNotEmpty).listen((token) =>
        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(fbToken: token))));
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: const AssetImage("res/images/couple.png"),
              ),
            ),
            child: Column(children: [
              Expanded(
                  flex: 3,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        'res/icons/logo.png',
                        scale: 2.0,
                        color: Colors.white,
                      ))),
              Expanded(
                  child: Text('meshi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontFamily: 'BettyLavea',
                      ))),
              Expanded(
                child: Text(
                  strings.findPerfectDate,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(strings.logInWith,
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
              Expanded(
                child: Container(
                    alignment: Alignment.topCenter,
                    child: ButtonTheme(
                        minWidth: 180.0,
                        child: FlatButton(
                          padding: const EdgeInsets.all(8.0),
                          textColor: Colors.white,
                          color: Color(0xFF4267B2),
                          onPressed: _bloc.initFacebookLogin,
                          child: Text("Facebook"),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        ))),
              )
            ])));
  }
}
