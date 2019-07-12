/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:url_launcher/url_launcher.dart';

class ListPremium extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => ListPremiumState();

}

class ListPremiumState extends State<ListPremium> {
  int _index = 0;
  SessionManager _sessionManager;

  @override
  void initState() {
    _index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    _sessionManager = InjectorWidget.of(context).get();

    List<Widget> listTiles = [
      premiumListTile(context, "1", "Un mes", "\$\ 19.000", "", 0),
      premiumListTile(context, "6", "Seis meses\n15% OFF", "\$\ 16.000", "por mes", 1),
      premiumListTile(context, "12", "Doce meses\n25% OFF", "\$\ 14.000", "por mes", 2),
    ];

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey), borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      child: Column(
        children: <Widget>[
          listTiles[0],
          listTiles[1],
          listTiles[2],
          SizedBox(height: 16),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: _lunchUrlPay,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                color: Theme.of(context).accentColor,
                child: Text(
                  "CONTINUAR",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget premiumListTile(BuildContext context, String number, String month, String price, String save, int index) {
    return ListTile(
        leading: CircleAvatar(
          backgroundColor: _index == index ? Color(0xff6FCF97) : Color(0xffc4c4c4),
          child: Text(number, style: TextStyle(color: Theme.of(context).accentColor)),
        ),
        title: Text(month),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Text(price),
            ),
            Text(
              save,
              style: TextStyle(color: Color(0xff6E6E6E), fontSize: 11),
            )
          ],
        ),
        onTap: () {
          setState(() {
            _index = index;
          });
        });
  }

  _lunchUrlPay() async {
    int id = await _sessionManager.userId;
    String url = 'https://meshi-app.herokuapp.com/payment/$id/$_index';
    await launch(url);
  }
}
