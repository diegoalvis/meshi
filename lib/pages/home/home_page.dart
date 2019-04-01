import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.title, this.fbToken}) : super(key: key);

  final String title, fbToken;

  @override
  HomePageState createState() => new HomePageState(fbToken);
}

class HomePageState extends State<HomePage> {
  var _profile;
  final String _fbToken;

  HomePageState(this._fbToken);

  @override
  void initState() {
    super.initState();
//    loadFacebookProfile();
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
