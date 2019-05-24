/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/suggestion.dart';
import 'package:meshi/pages/home/home_page.dart';
import 'package:meta/meta.dart';


class InterestProfile extends StatelessWidget {

  final Suggestion suggestion;

  const InterestProfile({Key key, this.suggestion}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.network(suggestion.user.images.elementAt(0)),

      ],
    );
  }





}

