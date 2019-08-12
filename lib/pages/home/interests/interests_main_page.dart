/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/pages/home/interests/interests_bloc.dart';
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
        final inj = InjectorWidget.of(context);
        binder.bindLazySingleton((injector, params) => InterestsBloc(inj.get(), inj.get(), inj.get(), inj.get()));
      },
      child: InterestsMainPageContainer(),
    );
  }

  @override
  bool showFloatingButton() => true;

  @override
  onFloatingButtonPressed(BuildContext context) {
    Navigator.pushNamed(context, RECOMMENDATIONS_ROUTE);
  }
}

class InterestsMainPageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context = context;
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
                  Tab(text: strings.myInterests),
                  Tab(text: strings.interestedOnMe),
                ],
                isScrollable: false,
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              MutualPage(),
              BaseInterestsPage(
                  title: strings.myInterestTab,
                  eventType: InterestsEventType.getMyLikes,
                  refreshEventType: InterestsEventType.refreshMyLikes,
                  isMyLike: 1),
              BaseInterestsPage(
                  title: strings.likesMeTab,
                  eventType: InterestsEventType.getLikesMe,
                  refreshEventType: InterestsEventType.refreshLikesMe,
                  isMyLike: 2),
            ],
          )),
    );
  }
}
