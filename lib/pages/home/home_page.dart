import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meshi/pages/home/menu_page.dart';
import 'package:meshi/utils/custom_widgets/BackdropMenu.dart';

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
  String _currentCategory = "all";

  void _onCategoryTap(String category) {
    setState(() {
      _currentCategory = category;
    });
  }

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
//  Container(color: Theme.of(context).primaryColor),

  @override
  Widget build(BuildContext context) {
    return BackdropMenu(
      backLayer: MenuPage(
        currentCategory: _currentCategory,
        onCategoryTap: _onCategoryTap,
      ),
      frontTitle: Text('MESHI'),
      backTitle: Text('MENU'),
      frontLayer: SizedBox(),
      floatingActionButton: new FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
