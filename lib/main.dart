import 'package:flutter/material.dart';
import 'package:meshi/pages/login.dart';
import 'package:meshi/pages/splash.dart';

void main() {
  runApp(new App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Meshi',
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
//        primarySwatch: Colors.blue,

        fontFamily: "Poppins",
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontFamily: 'BettyLavea'),
//          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
//          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: new SplashPage(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginPage(),
        '/home': (BuildContext context) => MyHomePage(title: 'Home'),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
