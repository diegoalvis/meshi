import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meshi/pages/forms/form_page.dart';
import 'package:meshi/pages/home/home_page.dart';
import 'package:meshi/pages/login/login_page.dart';
import 'package:meshi/utils/localiztions.dart';

void main() {
  runApp(new App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
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
      theme: new ThemeData(
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
      ),
      home: FormPage(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginPage(),
        '/home': (BuildContext context) => HomePage(title: 'Home'),
      },
    );
  }
}
