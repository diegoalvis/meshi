/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';

abstract class HomeSection {
  Widget get title;

  bool showFloatingButton() => false;

  onFloatingButtonPressed(BuildContext context) => null;
}
