/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/utils/custom_widgets/interests_profile_image.dart';
import 'package:meshi/utils/custom_widgets/compatibility_indicator.dart';
import 'package:meshi/utils/icon_utils.dart';

class InterestsProfilePage extends StatelessWidget {
  final String url = "https://i.pinimg.com/736x/80/19/23/8019236d731d30f451493fc884f685d6.jpg";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 245, 245, 245),
      child: Column(
        children: <Widget>[
          Container(
              height: 600,
              child: InterestsProfileImage(
                widget1: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CompatibilityIndicator(),
                ),
                widget2: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Card(
                    child: ListTile(
                      title: Text('Acerca de mi', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          'Lorem ipsum dolor sit amet consectetur adipiscing elit hendrerit ullamcorper mauris, posuere nisi imperdiet convallis suspendisse dapibus'),
                    ),
                  ),
                ),
              )),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Image.asset(IconUtils.heartBroken,
                          scale: 8.0, color: Theme.of(context).primaryColor),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'NO ME INTERESA',
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  color: Theme.of(context).accentColor,
                  child: Row(
                    children: <Widget>[
                      Image.asset(IconUtils.heart, scale: 8.0, color: Colors.white),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('ME INTERESA'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
