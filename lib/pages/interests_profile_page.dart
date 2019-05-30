/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/utils/custom_widgets/interests_profile_image.dart';
import 'package:meshi/utils/custom_widgets/compatibility_indicator.dart';
import 'package:meshi/utils/icon_utils.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/data/models/user.dart';

class InterestsProfilePage extends StatelessWidget with HomeSection {
  @override
  Widget build(BuildContext context) {
    UserDetail user = ModalRoute.of(context).settings.arguments;
    return Container(
      color: Color.fromARGB(255, 245, 245, 245),
      child: Column(
        children: <Widget>[
          Container(
              height: 724,
              child: InterestsProfileImage(
                user: user.user,
                widget1: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CompatibilityIndicator(),
                ),
                widget2: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Card(
                    child: ListTile(
                      title: Text('Acerca de mi', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(user.user.description),
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

  @override
  Widget get title {
    return Text("Perfil de intereses");
  }
}

class UserDetail {
  final User user;
  final int id;
  final bool isMyLike;
  UserDetail({this.user, this.id, this.isMyLike});
}
