/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/api/base_api.dart';
import 'package:meshi/data/models/my_likes.dart';

class InterestsItemPage extends StatelessWidget {
  int index;
  MyLikes myLikes;
  Function(String likeId) onUserTap;

  InterestsItemPage({this.myLikes, this.onUserTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(BaseApi.IMAGES_URL_DEV + myLikes.images.first),
                fit: BoxFit.cover,
              )),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Wrap(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  color: Colors.transparent.withOpacity(0.20),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    myLikes.name,
                    style: TextStyle(color: Colors.white),
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
