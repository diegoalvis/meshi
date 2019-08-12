/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/managers/notification_manager.dart';
import 'package:meshi/pages/bloc/base_bloc.dart';
import 'package:meshi/pages/home/home_bloc.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/pages/home/interests/interests_main_page.dart';
import 'package:meshi/pages/home/profile/profile_page.dart';
import 'package:meshi/pages/home/rewards/reward_page.dart';
import 'package:meshi/pages/home/settings/settings_page.dart';
import 'package:meshi/pages/menu/backdrop_menu.dart';
import 'package:meshi/pages/menu/menu_page.dart';
import 'package:meshi/pages/recommendations/recommendations_page.dart';
import 'package:meshi/pages/register/advance/advanced_register_page.dart';
import 'package:meshi/utils/app_icons.dart';
import 'package:meshi/utils/custom_widgets/premium_page.dart';
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
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with InjectorWidgetMixin {
  HomeBloc _bloc;
  String _currentCategory;
  String _previousCategory;
  HomeSection _previousPage;
  NotificationManager foregroundNotification;

  List<HomeSection> homePages = [
    RecommendationsPage(),
    InterestsMainPage(),
    RewardPage(),
    PremiumPage(false),
    ProfilePage(),
    SettingsPage(),
  ];

  HomeSection _currentPage = RecommendationsPage();

  Text title = Text("meshi", style: TextStyle(color: Colors.white, fontSize: 28, fontFamily: 'BettyLavea'));

  @override
  void initState() {
    super.initState();
    _previousCategory = _currentCategory;
    _previousPage = _currentPage;
    setCompleteProfileAlert();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    setState(() {
      foregroundNotification = InjectorWidget.of(context).get<NotificationManager>();
      foregroundNotification.onChangePageSubject.listen((pagePos) {
        setCurrentHomePage(pagePos, MyLocalizations.of(context).homeSections.elementAt(pagePos), context);
      });
    });
    _bloc = HomeBloc(injector.get(), injector.get());
    final strings = MyLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: HomeBlocProvider(
        bloc: _bloc,
        child: BackdropMenu(
          bloc: _bloc,
          menuTitle: title,
          // This trailing comma makes auto-formatting nicer for build methods.,
          backLayer: MenuPage(
            currentCategory: _currentCategory ?? strings.homeSections[0],
            onCategoryTap: (category, pos) => setCurrentHomePage(pos, category, context),
            categories: strings.homeSections,
          ),
          backTitle: Text(strings.menu),
          frontTitle: _currentPage.getTitle(context),
          frontLayer: OfflineBuilder(
            connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
              final bool connected = connectivity != ConnectivityResult.none;
              return Stack(
                fit: StackFit.expand,
                children: [
                  child,
                  connected
                      ? SizedBox()
                      : Positioned(
                          left: 0.0,
                          right: 0.0,
                          bottom: 0.0,
                          child: Wrap(
                            children: <Widget>[
                              Container(
                                color: Color(0xFF303030),
                                padding: EdgeInsets.all(8),
                                child: Center(
                                    child: Text(strings.noInternetConnection,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ))),
                              ),
                            ],
                          ),
                        ),
                ],
              );
            },
            child: GestureDetector(onTap: () => _bloc.category = _currentCategory, child: _currentPage as Widget),
          ),
        ),
      ),
      floatingActionButton: _currentPage.showFloatingButton()
          ? Container(
              width: 65,
              height: 65,
              child: FloatingActionButton(
                  shape: DiamondBorder(),
                  onPressed: () => setCurrentHomePage(0, MyLocalizations.of(context).homeSections.elementAt(0), context),
                  tooltip: 'Increment',
                  child: Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(
                      AppIcons.logo,
                      color: Colors.white,
                      size: 18,
                    ),
                  )),
            )
          : null,
    );
  }

  void setCurrentHomePage(int pos, String category, BuildContext context) {
    setState(() {
      if (pos < 2) {
        title = Text("meshi", style: TextStyle(color: Colors.white, fontSize: 28, fontFamily: 'BettyLavea'));
      } else if (pos != 3) {
        title = Text(category, style: TextStyle(color: Colors.white, fontSize: 17));
      }

      if (pos != 3) {
        _previousPage = homePages[pos];
        _previousCategory = category;
        _currentCategory = category;
        _bloc.category = category;
        _currentPage = homePages[pos];
      } else {
        _currentCategory = _previousCategory;
        _bloc.category = _previousCategory;
        _currentPage = _previousPage;
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) {
              return PremiumPage(false);
            });
      }
    });
  }

  void setCompleteProfileAlert() {
    Future.delayed(Duration(seconds: 1), () {
      if (_bloc.session.user.state != User.ADVANCED_USER) {
        showDialog(
            context: context,
            builder: (cxt) {
              final strings = MyLocalizations.of(context);
              return SimpleDialog(
                contentPadding: const EdgeInsets.all(16.0),
                children: [
                  Text(
                    strings.completeYourProfile,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0),
                  ListTile(
                    title: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdvancedRegisterPage(doWhenFinish: BaseBloc.ACTION_POP_PAGE)));
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        color: Theme.of(context).accentColor,
                        child: Text(strings.completeProfileButton)),
                  ),
                ],
              );
            });
      }
    });
  }
}
