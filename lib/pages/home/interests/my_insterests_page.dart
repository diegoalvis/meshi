/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */
import 'package:flutter/material.dart';
import 'package:meshi/utils/custom_widgets/interests_image_item.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/pages/interests_profile_page.dart';

class MyInterestsPage extends StatelessWidget {
  List<User> users = <User>[
    User(
        name: 'Juana',
        images: [
          'https://www.24horas.cl/tendencias/espectaculosycultura/article869018.ece/ALTERNATES/BASE_LANDSCAPE/Katy%20Perry%20revela%20que%20pens%C3%B3%20en%20suicidarse%20tras%20quiebre%20matrimonial',
        ],
        description: 'djfkfnnvre jhfuowfirhf ajdhbnreidncd jfuwfnfhuh'),
    User(
        name: 'Ana',
        images: ['http://es.web.img3.acsta.net/pictures/15/05/15/16/30/134942.jpg'],
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
            child: Text('Personas que me interesan',
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
