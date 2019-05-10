/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/main.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/pages/forms/form_page.dart';
import 'package:meshi/pages/home/home_page.dart';
import 'package:meshi/pages/register/register_page.dart';
import 'package:meshi/utils/localiztions.dart';

class WelcomePage extends StatelessWidget {

  final User user;

  const WelcomePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final userImage = user?.images?.firstWhere((image) => image?.isNotEmpty ?? false, orElse: null);
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            ClipOval(
              child: Container(
                height: 200.0,
                width: 200.0,
                color: user?.images?.first != null ? Colors.transparent : Colors.grey[300],
                child: userImage != null ? Image.network(userImage, fit: BoxFit.cover) : Icon(Icons.add_a_photo),
              ),
            ),
            SizedBox(height: 30),
            Text(
              strings.welcome,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 45,
                fontFamily: 'BettyLavea',
              ),
            ),
            SizedBox(height: 20),
            Text(
              user?.name ?? strings.placeholderUser,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 23.0,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  strings.welcomeCaption,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: FlatButton(
                      onPressed: () => Navigator.of(context).pushReplacementNamed(HOME_ROUTE),
                      child: Text(
                        strings.logIn.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: FlatButton(
                      onPressed: () => Navigator.of(context).pushReplacementNamed(FORM_ROUTE),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      color: Theme.of(context).accentColor,
                      child: Text(
                        strings.completeProfile.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
