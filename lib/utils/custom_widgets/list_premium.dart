/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/main.dart';

class ListPremium extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListPremiumState();
}

class ListPremiumState extends State<ListPremium> {
  int _index;

  @override
  void initState() {
    _index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);

    List<Widget> listTiles = [
      premiumListTile(context, "1", "Un mes", "9.000", "", 0),
      premiumListTile(context, "6", "Seis meses", "48.000", "Ahorra 6.000", 1),
      premiumListTile(context, "12", "Un año", "84.000", "Ahorra 24.000", 2),
    ];

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      child: Column(
        children: <Widget>[
          listTiles[0],
          listTiles[1],
          listTiles[2],
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                onPressed: (null),
                child: Text(
                  "PROBAR MES GRATIS",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              ),
              RaisedButton(
                onPressed: () {},
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
            ],
          ),
        ],
      ),
    );
  }

  Widget premiumListTile(
      BuildContext context, String number, String month, String price, String save, int index) {
    return ListTile(
        leading: CircleAvatar(
          backgroundColor: _index == index ? Color(0xff6FCF97) : Color(0xffc4c4c4),
          child: Text(number),
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
}
