/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

class Gender {
  final String icon;
  final int color;
  final String name;

  const Gender._internal({this.icon, this.color, this.name});

  static const male =
      const Gender._internal(icon: 'res/icons/male.png', color: 0xFF2ABEB6, name: 'male');
  static const female =
      const Gender._internal(icon: 'res/icons/female.png', color: 0xFF80065E, name: 'female');
}
