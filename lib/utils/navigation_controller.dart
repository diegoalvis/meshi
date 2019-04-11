/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';

class NavigationController {
  /* Navigates to home page */
  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, '/home');
  }

  /* Navigates to login page */
  static void goToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
  }
}
