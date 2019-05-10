/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meshi/bloc/login_bloc.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/main.dart';
import 'package:meshi/utils/localiztions.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InjectorWidget.bind(
      bindFunc: (binder) {
        binder.bindSingleton(LoginBloc(InjectorWidget.of(context).get(), InjectorWidget.of(context).get()));
      },
      child: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginForm> with TickerProviderStateMixin {
  final logged = false;
  bool loading = false;
  BuildContext buildContext;

  LoginBloc _bloc;

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
    controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = InjectorWidget.of(context).get<LoginBloc>();
    _bloc.userStream?.listen((user) {
      switch (user.state) {
        case User.new_user:
          Navigator.of(context).pushReplacementNamed(REGISTER_ROUTE);
          break;
        case User.basic_user:
          Navigator.of(context).pushReplacementNamed(FORM_ROUTE);

          break;
        case User.advanced_user:
          Navigator.of(context).pushReplacementNamed(HOME_ROUTE);
          break;
      }
    });
    _bloc.progressSubject.listen((show) => setState(() => loading = show));
    _bloc.errorSubject.listen((error) {
      Scaffold.of(buildContext).showSnackBar(SnackBar(content: Text("Ocurrio un error intentalo mas tarde.")));
    });
    final strings = MyLocalizations.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Builder(builder: (context) {
        buildContext = context;
        return Column(children: [
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
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 45, fontFamily: 'BettyLavea'),
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
                child: Text(strings.logInWith, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
              ),
            ),
          ),
          Expanded(
            child: FadeTransition(
              opacity: animation,
              child: Container(
                alignment: loading ? Alignment.center : Alignment.topCenter,
                child: loading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.onPrimary))
                    : ButtonTheme(
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
        ]);
      }),
    );
  }
}
