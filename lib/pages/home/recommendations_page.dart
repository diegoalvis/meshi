/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/utils/icon_utils.dart';
import 'package:meshi/data/models/user.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:meshi/utils/custom_widgets/compatibility_indicator.dart';

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
  User(
      name: 'Juana',
      images: [
        'https://www.24horas.cl/tendencias/espectaculosycultura/article869018.ece/ALTERNATES/BASE_LANDSCAPE/Katy%20Perry%20revela%20que%20pens%C3%B3%20en%20suicidarse%20tras%20quiebre%20matrimonial',
      ],
      description: 'djfkfnnvre jhfuowfirhf ajdhbnreidncd jfuwfnfhuh'),
];

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

class RecommendationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Recomendaciones', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(color: Theme.of(context).primaryColor, child: recommendationsCarousel(context, 0)),
    );
  }

  CarouselSlider recommendationsCarousel(BuildContext context, int index) {
    return CarouselSlider(
      viewportFraction: 0.85,
      autoPlayCurve: Curves.easeIn,
      height: MediaQuery.of(context).size.height,
      autoPlay: false,
      items: users.map(
        (user) {
          return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
              child: carouselWidget(context, index));
        },
      ).toList(),
    );
  }

  Widget carouselWidget(BuildContext context, int index) {
    return Container(
      color: Color.fromARGB(255, 245, 245, 245),
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.54,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(users[0].images[0]),
                      fit: BoxFit.cover,
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(users[0].name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CompatibilityIndicator(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Card(
              child: ListTile(
                title: Text('Acerca de mi', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('jsdshduihdui ucdhuhuif ducbdsbdsiufhd'),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Spacer(),
                RaisedButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  color: Theme.of(context).accentColor,
                  child: Row(
                    children: <Widget>[
                      Image.asset(IconUtils.heart, scale: 8.0, color: Colors.white),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'ME INTERESA',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
