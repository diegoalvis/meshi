/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';

abstract class HomeSection extends StatefulWidget {
  Widget get title;

  bool showFloatingButton();

  onFloatingButtonPressed(BuildContext context) {}
}
