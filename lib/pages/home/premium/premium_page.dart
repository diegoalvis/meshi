/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/utils/custom_widgets/list_premium.dart';


class PremiumPage extends StatelessWidget with HomeSection {
  @override
  Widget build(BuildContext context) {
    // TODO construir aqui la vista
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(150, 40, 20, 20),
              child: Text(
                "Se premium",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 34,
                  fontFamily: 'BettyLavea',
                ),
              ),
            ),
            ListTile(
              title: Text('Chatea sin Limites'),
            ),
            ListTile(
              title: Text('Participa por citas Regalo'),
            ),
            ListTile(
              title: Text('Conoce mas personas de tu gusto'),
            ),
            ListTile(
              title: Text('Mira en que coincides con tu pareja'),
            ),

            ListPremium()
          ],
        ),
      ),
    );
  }
}
