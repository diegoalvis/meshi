/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/utils/gender.dart';

class GenderSelector extends StatelessWidget {
  final Function(String gender) onGenderSelected;
  final Set<String> data;

  const GenderSelector({Key key, this.onGenderSelected, this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color maleIconColor = data?.contains(Gender.male.name) == true
        ? Color(Gender.male.color)
        : Color.fromARGB(255, 210, 210, 210);
    Color femaleIconColor = data?.contains(Gender.female.name) == true
        ? Color(Gender.female.color)
        : Color.fromARGB(255, 210, 210, 210);
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: GestureDetector(
              onTap: () => onGenderSelected(Gender.male.name),
              child: Icon(
                Gender.male.icon,
                color: maleIconColor,
                size: 80,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: GestureDetector(
              onTap: () => onGenderSelected(Gender.female.name),
              child: Icon(
                Gender.female.icon,
                color: femaleIconColor,
                size: 80,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
