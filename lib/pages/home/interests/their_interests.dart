/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/utils/custom_widgets/interests_image_item.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/pages/interests_profile_page.dart';

class TheirInterestsPage extends StatelessWidget {
  List<User> users = <User>[
    User(
        name: 'Emma',
        images: [
          'https://m.media-amazon.com/images/M/MV5BMTQ3ODE2NTMxMV5BMl5BanBnXkFtZTgwOTIzOTQzMjE@._V1_UY317_CR21,0,214,317_AL_.jpg',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ5-M01ThvhCUtzqHbzw8doZBsxaxsLc2BFDwbWXo5sOaq_NWE'
        ],
        description: 'djfkfnnvre jhfuowfirhf ajdhbnreidncd jfuwfnfhuh'),
    User(
        name: 'Taylor',
        images: [
          'https://www.cheatsheet.com/wp-content/uploads/2019/05/Taylor-Swift-9.jpg',
          'https://www.periodistadigital.com/imagenes/2019/03/08/taylor-swift_560x280.jpg'
        ],
        description: 'djfkfnnvre jhfuowfirhf ajdhbnreidncd jfuwfnfhuh'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            alignment: Alignment.centerRight,
            child: Text('Personas que les intereso',
                textAlign: TextAlign.end,
                style: TextStyle(color: ThemeData.light().colorScheme.onSurface)),
          ),
        ),
        Flexible(
          child: GridView.builder(
            itemCount: users.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return InterestsItemPage(
                  user: users[index],
                  onUserTap: (user) {
                    Navigator.pushNamed(context, '/interests-profile',
                        arguments: UserDetail(users[index]));
                  });
            },
          ),
        ),
      ],
    );
  }
}
