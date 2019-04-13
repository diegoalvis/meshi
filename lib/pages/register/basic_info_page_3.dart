/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/pages/register/register_page.dart';
import 'package:meshi/pages/register/register_section.dart';
import 'package:meshi/utils/localiztions.dart';

class BasicInfoPageThree extends StatelessWidget with RegisterSection {
  @override
  bool isInfoComplete() {
    // TODO implement
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = RegisterBlocProvider.of(context).bloc;
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            strings.tellUsAboutYou,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: strings.howDescribeYourself,
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: strings.hobbiesCaption,
            ),
          ),
          SizedBox(height: 25),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: strings.whatYouDo,
            ),
          ),
          SizedBox(height: 25),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: strings.whatYouLookingFor,
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
