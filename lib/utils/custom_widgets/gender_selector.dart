/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/utils/gender.dart';

class GenderSelector extends StatelessWidget {
  final Function(Gender gender) onGenderSelected;
  final Set<Gender> data;

  const GenderSelector({Key key, this.onGenderSelected, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color maleIconColor = data?.contains(Gender.male) == true ? Color(Gender.male.color) : null;
    Color femaleIconColor = data?.contains(Gender.female) == true ? Color(Gender.female.color) : null;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => onGenderSelected(Gender.male),
            child: Image.asset(Gender.male.icon, color: maleIconColor),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => onGenderSelected(Gender.female),
            child: Image.asset(Gender.female.icon, color: femaleIconColor),
          ),
        ),
      ],
    );
  }
}
