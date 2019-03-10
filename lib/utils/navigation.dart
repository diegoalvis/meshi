import 'package:flutter/material.dart';

class Navigation {
  /* Navigates to home page */
  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, '/home');
  }

  /* Navigates to login page */
  static void goToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
  }
}
