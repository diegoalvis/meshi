/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';

class ViewMoreRecommendations extends Container {
  final Function onShowMore;

  ViewMoreRecommendations(this.onShowMore);

  @override
  Widget build(BuildContext context) {
    final fontColor = Theme.of(context).colorScheme.onPrimary;
    return GestureDetector(
      onTap: onShowMore,
      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Spacer(),
              Icon(Icons.navigate_next, size: 48, color: fontColor),
              Text("Ver mas", style: TextStyle(color: fontColor)),
              Spacer(),
            ],
          )),
    );
  }
}
