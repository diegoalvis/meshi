/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/blocs/home_bloc.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/pages/home/interests/interests_main_page.dart';
import 'package:meshi/pages/home/menu_page.dart';
import 'package:meshi/pages/home/rewards/reward_page.dart';
import 'package:meshi/utils/custom_widgets/backdrop_menu.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/view_utils/diamond_border.dart';

class HomeBlocProvider extends InheritedWidget {
  final HomeBloc bloc;
  final Widget child;

  HomeBlocProvider({Key key, @required this.bloc, this.child}) : super(key: key, child: child);

  static HomeBlocProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(HomeBlocProvider) as HomeBlocProvider);
  }

  @override
  bool updateShouldNotify(HomeBlocProvider oldWidget) => true;
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState(HomeBloc());
}

class HomePageState extends State<HomePage> {
  final HomeBloc _bloc;
  String _currentCategory;

  // TODO test purposes
  List<HomeSection> homePages = [InterestsMainPage(), RewardPage()];
  HomeSection _currentPage = InterestsMainPage();

  HomePageState(this._bloc);

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: HomeBlocProvider(
        bloc: _bloc,
        child: BackdropMenu(
          backLayer: MenuPage(
            currentCategory: _currentCategory ?? strings.homeSections[0],
            onCategoryTap: (category, pos) => setState(() {
                  _currentCategory = category;
                  _bloc.category = category;
                  _currentPage = homePages[pos];
                }),
            categories: strings.homeSections,
          ),
          backTitle: Text('MENU'),
          frontTitle: _currentPage.title,
          frontLayer: SafeArea(
            child: _currentPage,
          ),
        ),
      ),
      floatingActionButton: _currentPage.showFloatingButton()
          ? FloatingActionButton(
              shape: DiamondBorder(),
              onPressed: () => _currentPage.onFloatingButtonPressed(context),
              tooltip: 'Increment',
              child: Image.asset(
                'res/icons/logo.png',
                scale: 5.5,
                color: Colors.white,
              ),
            )
          : null, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
