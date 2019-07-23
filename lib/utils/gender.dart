/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/widgets.dart';

import 'app_icons.dart';

class Gender {
  final int color;
  final IconData icon;
  final String name;

  const Gender._internal({this.icon, this.color, this.name});

  static const male =
      const Gender._internal(icon: AppIcons.male, color: 0xFF2ABEB6, name: 'm');
  static const female =
      const Gender._internal(icon: AppIcons.female, color: 0xFF80065E, name: 'f');
}
