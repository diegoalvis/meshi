import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meshi/utils/navigation.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  void initiateFacebookLogin() {
    // TODO implement login with facebook here
    Navigation.goToHome(context);
  }

  @override
  Widget build(BuildContext context) {
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
                  'Encuentra tu pareja ideal',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text('Ingresa con',
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
                          onPressed: initiateFacebookLogin,
                          child: new Text("Facebook"),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        ))),
              )
            ])));
  }
}
