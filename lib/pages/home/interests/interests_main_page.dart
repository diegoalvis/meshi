/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meshi/bloc/interests_bloc.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/pages/home/interests/mutual_page.dart';
import 'package:meshi/utils/localiztions.dart';

import '../../../main.dart';
import 'base_insterests_page.dart';
import 'mutual_page.dart';

class InterestsMainPage extends StatelessWidget with HomeSection {
  @override
  Widget build(BuildContext context) {
    return InjectorWidget.bind(
      bindFunc: (binder) {
        binder.bindLazySingleton((injector, params) =>
            InterestsBloc(InjectorWidget.of(context).get(), InjectorWidget.of(context).get()));
      },
      child: InterestsMainPageContainer(),
    );
  }

  @override
  Widget get title => null;

  @override
  bool showFloatingButton() => true;

  @override
  onFloatingButtonPressed(BuildContext context) {
    Navigator.pushNamed(context, RECOMMENDATIONS_ROUTE);
  }
}

class InterestsMainPageContainer extends StatelessWidget {
  final List<Widget> interestSPages = [
    MutualPage(),
    BaseInterestsPage(
        title: "??Personas que me interesan", eventType: InterestsEventType.getMyLikes, isMyLike: true),
    BaseInterestsPage(
        title: "??Personas que les intereso", eventType: InterestsEventType.getLikesMe, isMyLike: false),
  ];

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              color: Theme.of(context).primaryColor,
              height: 50,
              child: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(text: strings.mutual),
                  Tab(text: strings.iAmInterested),
                  Tab(text: strings.iInterested),
                ],
                isScrollable: false,
              ),
            ),
          ),
          body: TabBarView(children: interestSPages)),
    );
  }
}
