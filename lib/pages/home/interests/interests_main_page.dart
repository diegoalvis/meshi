/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/blocs/interests_bloc.dart';
import 'package:meshi/pages/forms/form_page.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/pages/register/welcome_page.dart';
import 'package:meshi/utils/localiztions.dart';

class InterestsBlocProvider extends InheritedWidget {
  final InterestsBloc bloc;
  final Widget child;

  InterestsBlocProvider({Key key, @required this.bloc, this.child}) : super(key: key, child: child);

  static InterestsBlocProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(InterestsBlocProvider) as InterestsBlocProvider);
  }

  @override
  bool updateShouldNotify(InterestsBlocProvider oldWidget) => true;
}

class InterestsMainPage extends HomeSection {
  @override
  Widget get title {
    return Text("Intereses");
  }

  @override
  InterestsMainPageState createState() => new InterestsMainPageState(InterestsBloc());

  @override
  bool showFloatingButton() {
    return true;
  }

  @override
  onFloatingButtonPressed(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage()));
  }
}

class InterestsMainPageState extends State<InterestsMainPage> {
  final InterestsBloc _bloc;

  InterestsMainPageState(this._bloc);

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    return InterestsBlocProvider(
        bloc: _bloc,
        child: Center(
          child: Text(
            "Estamos trabajando en algo increible.",
            textAlign: TextAlign.center,
          ),
        ));
  }
}
