import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meshi/pages/basic_form_page.dart';
import 'package:meshi/utils/localiztions.dart';

class WelcomePage extends StatelessWidget {
  final File image;
  final String name;

  WelcomePage({Key key, this.image, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);

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
                color: image != null ? Colors.transparent : Colors.grey[300],
                child: image != null ? Image.file(image, fit: BoxFit.cover) : Icon(Icons.add_a_photo),
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
              name != null ? name : strings.placeholderUser,
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
                      onPressed: () => Navigator.push(
                          context, MaterialPageRoute(builder: (context) => BasicFormPage())),
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
