/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meshi/di/app_module.dart';
import 'package:meshi/pages/chat/chat_page.dart';
import 'package:meshi/pages/home/home_page.dart';
import 'package:meshi/pages/home/interests/interests_main_page.dart';
import 'package:meshi/pages/home/interests/my_insterests_page.dart';
import 'package:meshi/pages/home/rewards/brands_page.dart';
import 'package:meshi/pages/home/rewards/select_partner_page.dart';
import 'package:meshi/pages/interests_profile_page.dart';
import 'package:meshi/pages/login_page.dart';
import 'package:meshi/pages/register/advance/advanced_register_page.dart';
import 'package:meshi/pages/register/basic/basic_register_page.dart';
import 'package:meshi/pages/welcome_page.dart';
import 'package:meshi/utils/localiztions.dart';

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
        child: MaterialApp(
          title: 'Meshi',
          localizationsDelegates: [
            const MyLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', ''),
            const Locale('es', ''),
          ],
          theme: buildTheme(),
          home: LoginPage(),
          initialRoute: HOME_ROUTE,
          routes: <String, WidgetBuilder>{
            LOGIN_ROUTE: (BuildContext context) => LoginPage(),
            HOME_ROUTE: (BuildContext context) => HomePage(),
            REGISTER_ROUTE: (BuildContext context) => BasicRegisterPage(),
            FORM_ROUTE: (BuildContext context) => AdvancedRegisterPage(),
            WELCOME_ROUTE: (BuildContext context) => WelcomePage(),
            BRANDS_ROUTE: (BuildContext context) => BrandsPage(),
            SELECT_PARTNER_ROUTE: (BuildContext context) => SelectPartnerPage(),
            MY_INTERESTS_ROUTE: (BuildContext context) => MyInterestsPage(),
            INTERESTS_MAIN_ROUTE: (BuildContext context) => InterestsMainPage(),
            INTERESTS_PROFILE_ROUTE: (BuildContext context) => InterestsProfilePage(),
            CHAT_ROUTE: (BuildContext context)=> ChatPage(),
          },
        ));
  }
}

// Route names
const String LOGIN_ROUTE = '/login';
const String HOME_ROUTE = '/home';
const String REGISTER_ROUTE = '/register';
const String FORM_ROUTE = '/form';
const String WELCOME_ROUTE = "/welcome";
const String BRANDS_ROUTE = "/brands";
const String SELECT_PARTNER_ROUTE = "/select_partner";
const String MY_INTERESTS_ROUTE = "/my-interests";
const String INTERESTS_MAIN_ROUTE = "/interests";
const String INTERESTS_PROFILE_ROUTE = "/interests-profile";
const String CHAT_ROUTE = "/chat";

// Themes
ThemeData buildTheme() => ThemeData(
      primaryColor: Color(0xFF5E2531),
      primaryColorDark: Color(0xFF4B1822),
      primaryColorLight: Color(0xFF672836),
      accentColor: Color(0xFF80065E),
      dividerColor: Color(0xFFCCCCCC),
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
        subhead: TextStyle(fontSize: 14.0, fontFamily: 'BettyLavea'),
        subtitle: TextStyle(fontSize: 36.0, fontFamily: 'BettyLavea'),
      ),
    );
