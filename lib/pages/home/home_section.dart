/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';

abstract class HomeSection {
  Widget getTitle(BuildContext context) => null;

  bool showFloatingButton() => false;

  onFloatingButtonPressed(BuildContext context) => null;
}
