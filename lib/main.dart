import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:meshi/pages/basic_form_page.dart';
import 'package:meshi/pages/login_page.dart';
import 'package:meshi/pages/splash_page.dart';
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
      home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginPage(),
        '/home': (BuildContext context) => MyHomePage(title: 'Home'),
      },
    );
  }
}

// TODO: Testing class
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title, this.fbToken}) : super(key: key);

  final String title, fbToken;

  @override
  _MyHomePageState createState() => new _MyHomePageState(fbToken);
}

class _MyHomePageState extends State<MyHomePage> {
  var _profile;
  final String _fbToken;

  _MyHomePageState(this._fbToken);

  @override
  void initState() {
    super.initState();
    loadFacebookProfile();
  }

  void loadFacebookProfile() async {
    var graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=$_fbToken');

    setState(() {
      _profile = json.decode(graphResponse.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Meshi"),
      ),
      body: new Center(
          child: _profile != null
              ? Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        _profile['picture']['data']['url'],
                      ),
                    ),
                  ),
                )
              : null),
      floatingActionButton: new FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
