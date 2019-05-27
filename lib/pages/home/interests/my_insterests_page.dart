/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */
import 'package:flutter/material.dart';
import 'package:meshi/utils/custom_widgets/interests_image_item.dart';
import 'package:meshi/data/models/user.dart';

class MyInterestsPage extends StatelessWidget {
  List<User> users = <User>[
    User(name: 'Paco', images: [
      'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13002253/GettyImages-521536928-_1_.jpg'
    ]),
    User(name: 'Ana', images: [
      'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13002253/GettyImages-521536928-_1_.jpg'
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            alignment: Alignment.centerRight,
            child: Text('Personas que me interesan',
                textAlign: TextAlign.end,
                style: TextStyle(color: ThemeData.light().colorScheme.onSurface)),
          ),
        ),
        Flexible(
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: users.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return InterestsItemPage(users[index]);
            },
          ),
        ),
      ],
    );
  }
}
