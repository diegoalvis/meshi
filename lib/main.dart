/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meshi/di/app_module.dart';
import 'package:meshi/pages/chat/chat_page.dart';
import 'package:meshi/pages/contact/contact_page.dart';
import 'package:meshi/pages/home/home_page.dart';
import 'package:meshi/pages/home/rewards/brands_page.dart';
import 'package:meshi/pages/home/rewards/select_partner_page.dart';
import 'package:meshi/pages/home/settings/settings_page.dart';
import 'package:meshi/pages/interes_profile_page/interests_profile_page.dart';
import 'package:meshi/pages/login/login_page.dart';
import 'package:meshi/pages/register/advance/advanced_register_container_page.dart';
import 'package:meshi/pages/register/basic/basic_info_container_page.dart';
import 'package:meshi/pages/terms_and_condition_page.dart';
import 'package:meshi/pages/register/welcome/welcome_page.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/managers/notification_manager.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
  runApp(new App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InjectorWidget.bind(
        bindFunc: (binder) {
          binder.install(AppModule());
        },
        child: AppContainer());
  }
}

class AppContainer extends StatelessWidget with InjectorWidgetMixin {
  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();
    final notificationManager = InjectorWidget.of(context).get<NotificationManager>();
    notificationManager.navigatorKey = globalNavigatorKey;
    notificationManager.setFcmListener();
    notificationManager.subscribeToTopics();
    return OverlaySupport(
      child: MaterialApp(
        title: 'Meshi',
        debugShowCheckedModeBanner: false,
        navigatorKey: globalNavigatorKey,
        localizationsDelegates: [
          const MyLocalizationsDelegate(),
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
//          const Locale('en', ''),
          const Locale('es', ''),
        ],
        theme: buildTheme(),
        initialRoute: LOGIN_ROUTE,
        routes: <String, WidgetBuilder>{
          LOGIN_ROUTE: (BuildContext context) => LoginPage(),
          HOME_ROUTE: (BuildContext context) => HomePage(),
          BASIC_REGISTER_ROUTE: (BuildContext context) => BasicInfoContainerPage(),
          ADVANCED_REGISTER_ROUTE: (BuildContext context) => AdvancedRegisterContainerPage(),
          WELCOME_ROUTE: (BuildContext context) => WelcomePage(),
          BRANDS_ROUTE: (BuildContext context) => BrandsPage(),
          SELECT_PARTNER_ROUTE: (BuildContext context) => SelectPartnerPage(),
          INTERESTS_PROFILE_ROUTE: (BuildContext context) => InterestsProfilePage(),
          CHAT_ROUTE: (BuildContext context) => ChatPage(),
          SETTINGS_ROUTE: (BuildContext context) => SettingsPage(),
          CONTACT_ROUTE: (BuildContext context) => ContactPage(),
          TERM_AND_CONDITIONS: (BuildContext context) => TermsAndConditionsPage(),
        },
      ),
    );
  }
}

// Route names
const String LOGIN_ROUTE = '/';
const String HOME_ROUTE = '/home';
const String BASIC_REGISTER_ROUTE = '/basic_register';
const String ADVANCED_REGISTER_ROUTE = '/advanced_register';
const String WELCOME_ROUTE = "/welcome";
const String BRANDS_ROUTE = "/brands";
const String SELECT_PARTNER_ROUTE = "/select_partner";
const String INTERESTS_MAIN_ROUTE = "/interests";
const String INTERESTS_PROFILE_ROUTE = "/interests-profile";
const String CHAT_ROUTE = "/chat";
const String RECOMMENDATIONS_ROUTE = "/recommendations";
const String PROFILE_ROUTE = "/profile";
const String SETTINGS_ROUTE = "/settings";
const String CONTACT_ROUTE = "/contact";
const String TERM_AND_CONDITIONS = "/term";
const String PREMIUM = "/premium";

// Themes
ThemeData buildTheme() => ThemeData(
      primaryColor: Color(0xFF5E2531),
      primaryColorDark: Color(0xFF4B1822),
      primaryColorLight: Color(0xFF672836),
      accentColor: Color(0xFF80065E),
      dividerColor: Color(0xFFCCCCCC),
      appBarTheme: AppBarTheme(brightness: Brightness.dark),
      primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white)),
      colorScheme: ColorScheme(
          primary: Color(0xFF5E2531),
          primaryVariant: Color(0xFF672836),
          secondary: Color(0xFF80065E),
          secondaryVariant: Color(0xFF4f0034),
          surface: Colors.white,
          background: Colors.white,
          error: Color(0xFFBA0000),
          onPrimary: Color(0xFFCDB5AA),
          onSecondary: Colors.white,
          onSurface: Color(0xFF505050),
          onBackground: Color(0xFF303030),
          onError: Colors.white,
          brightness: Brightness.dark),
      fontFamily: "Poppins",
      textTheme: TextTheme(
        headline: TextStyle(fontSize: 72.0, fontFamily: 'BettyLavea'),
        title: TextStyle(fontSize: 36.0, fontFamily: 'BettyLavea'),
        subhead: TextStyle(fontSize: 14.0, fontFamily: 'Poppins'),
        subtitle: TextStyle(fontSize: 36.0, fontFamily: 'Poppins'),
      ),
    );
