/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'dart:convert';
import 'dart:io';

import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:meshi/bloc/home_bloc.dart';
import 'package:meshi/data/models/user_match.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/pages/home/interests/interests_main_page.dart';
import 'package:meshi/utils/custom_widgets/premium_page.dart';
import 'package:meshi/pages/home/profile/profile_page.dart';
import 'package:meshi/pages/home/rewards/reward_page.dart';
import 'package:meshi/pages/home/settings/settings_page.dart';
import 'package:meshi/pages/menu/backdrop_menu.dart';
import 'package:meshi/pages/menu/menu_page.dart';
import 'package:meshi/utils/app_icons.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/notification_utils.dart';
import 'package:meshi/utils/view_utils/diamond_border.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../main.dart';

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
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  // TODO test purposes
  List<HomeSection> homePages = [
    InterestsMainPage(),
    RewardPage(),
    PremiumPage(),
    ProfilePage(),
    SettingsPage(),
  ];

  HomeSection _currentPage = InterestsMainPage();

  @override
  void initState() {
    super.initState();
    fcmListener();
    _previousCategory = _currentCategory;
    _previousPage = _currentPage;

    var android = AndroidInitializationSettings("drawable/ic_logo");
    var iOS = IOSInitializationSettings();
    var platform = InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(platform, onSelectNotification: onSelectedNotification);
  }

  void fcmListener() {
    FirebaseMessaging _fcm = FirebaseMessaging();
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));

      _fcm.onIosSettingsRegistered.listen((settings) {
        print("Settings registered: $settings");
      });
    }
    _fcm.configure(onMessage: (Map<String, dynamic> message) async {
      final match = UserMatch.fromMessage(message);
      foregroundNotification.notificationSubject.sink.add(match);
      switch (message["data"]["typeMessage"]) {
        case NOTIFICATION_CHAT:
          showNotification(0, match.name, match.lastMessage, message);
          break;
        case NOTIFICATION_REWARD:
          showNotification(1, "Nueva cita", "Tenemos una nueva cita por la cual puedes participar", message);
          break;
        default:
          showNotification(2, "Eres ganador", "Ganaste la cita en juego", message);
          break;
      }
    }, onResume: (Map<String, dynamic> message) async {
      switch (message["data"]["typeMessage"]) {
        case NOTIFICATION_CHAT:
          final match = UserMatch.fromMessage(message);
          Navigator.pushNamed(context, CHAT_ROUTE, arguments: match);
          break;
        case NOTIFICATION_REWARD:
          setCurrentHomePage(1, MyLocalizations.of(context).homeSections.elementAt(1), context);
          break;
        case NOTIFICATION_WINNER:
          setCurrentHomePage(1, MyLocalizations.of(context).homeSections.elementAt(1), context);
          break;
        default:
          Navigator.pushReplacementNamed(context, HOME_ROUTE);
          break;
      }
    }, onLaunch: (Map<String, dynamic> message) async {
      switch (message["data"]["typeMessage"]) {
        case NOTIFICATION_CHAT:
          final match = UserMatch.fromMessage(message);
          Navigator.pushNamed(context, CHAT_ROUTE, arguments: match);
          break;
        case NOTIFICATION_REWARD:
          setCurrentHomePage(1, MyLocalizations.of(context).homeSections.elementAt(1), context);
          break;
        case NOTIFICATION_WINNER:
          setCurrentHomePage(1, MyLocalizations.of(context).homeSections.elementAt(1), context);
          break;
        default:
          Navigator.pushReplacementNamed(context, HOME_ROUTE);
          break;
      }});

    _fcm.getToken().then((token) {
      print('TOKEEEEEN');
      print(token);
      _bloc.updateToken(token);
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    UserRepository repo = InjectorWidget.of(context).get();
    setState(() {
      foregroundNotification = InjectorWidget.of(context).get<NotificationManager>();
    });
    _bloc = HomeBloc(repo);
    final strings = MyLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: HomeBlocProvider(
        bloc: _bloc,
        child: BackdropMenu(
          backLayer: MenuPage(
            currentCategory: _currentCategory ?? strings.homeSections[0],
            onCategoryTap: (category, pos) => setCurrentHomePage(pos, category, context),
            categories: strings.homeSections,
          ),
          backTitle: Text(strings.menu),
          frontTitle: _currentPage.getTitle(context),
          frontLayer: SafeArea(
            child: _currentPage as Widget,
          ),
        ),
      ),
      floatingActionButton: _currentPage.showFloatingButton() ?
          Container(
            width: 65,
            height: 65,
            child: FloatingActionButton(
                shape: DiamondBorder(),
                onPressed: () => _currentPage.onFloatingButtonPressed(context),
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
          : null, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void setCurrentHomePage(int pos, String category, BuildContext context) {
    setState(() {
      if (pos != 2) {
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
              return PremiumPage();
            });
      }
    });
  }

  Future showNotification(int id, String title, String body, dynamic message) async {
    final data = jsonEncode(message);
    var android = AndroidNotificationDetails("channel_id", "channel_name", "channel_description", priority: Priority.High, importance: Importance.Max);
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(0, title, body, platform, payload: data);
  }

  Future onSelectedNotification(String payload) async{
    dynamic message = jsonDecode(payload);
    switch (message["data"]["typeMessage"]) {
      case NOTIFICATION_CHAT:
        final match = UserMatch.fromMessage(message);
        Navigator.pushNamed(context, CHAT_ROUTE, arguments: match);
        break;
      case NOTIFICATION_REWARD:
        setCurrentHomePage(1, MyLocalizations.of(context).homeSections.elementAt(1), context);
        break;
      case NOTIFICATION_WINNER:
        setCurrentHomePage(1, MyLocalizations.of(context).homeSections.elementAt(1), context);
        break;
      default:
        Navigator.pushReplacementNamed(context, HOME_ROUTE);
        break;
    }
  }
}
