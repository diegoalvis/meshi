class Gender {
  final String icon;
  final int color;

  const Gender._internal({this.icon, this.color});

  static const male = const Gender._internal(icon: 'res/icons/male.png', color: 0xFF2ABEB6);
  static const female = const Gender._internal(icon: 'res/icons/female.png', color: 0xFF80065E);
}
