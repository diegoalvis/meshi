/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/blocs/login_bloc.dart';
import 'package:meshi/pages/register/register_page.dart';
import 'package:meshi/utils/localiztions.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState(LoginBloc());
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final LoginBloc _bloc;
  final logged = false;

  _LoginPageState(this._bloc);

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    _bloc.fbToken.takeWhile((token) => token.isNotEmpty).listen((token) =>
        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(fbToken: token))));
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(children: [
          Expanded(
              flex: 3,
              child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    'res/icons/logo.png',
                    scale: 2.0,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ))),
          Expanded(
            child: Text(
              'meshi',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 45,
                  fontFamily: 'BettyLavea'),
            ),
          ),
          Expanded(
            child: FadeTransition(
              opacity: animation,
              child: Text(
                strings.findPerfectDate,
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 20),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: FadeTransition(
                opacity: animation,
                child: Text(strings.logInWith,
                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
              ),
            ),
          ),
          Expanded(
            child: FadeTransition(
              opacity: animation,
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
                    )),
              ),
            ),
          )
        ]));
  }
}
