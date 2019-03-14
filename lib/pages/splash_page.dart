import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meshi/utils/navigation.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final logged = false; // TODO obetener este valor usando un manager de session o con preferences

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      if (logged) {
        Navigation.goToHome(context);
      } else {
        Navigation.goToLogin(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        'res/icons/logo.png',
                        scale: 2.0,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ))),
              Expanded(
                  child: Container(
                child: Text(
                  'meshi',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 45,
                    fontFamily: 'BettyLavea',
                  ),
                ),
              )),
            ],
          ),
        ));
  }
}
