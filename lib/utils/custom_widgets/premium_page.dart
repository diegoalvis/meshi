/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/utils/custom_widgets/list_premium.dart';

class PremiumPage extends StatefulWidget with HomeSection {
  @override
  State<StatefulWidget> createState() => PremiumPageState();
}

class PremiumPageState extends State<PremiumPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                //Falta aplicar El BorderRadius, esquinas superiories de este container
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    gradient:
                        LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
                      Color(0xff5E2531),
                      Color(0xff80065E),
                    ])),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(110, 30, 20, 20),
                      child: Text(
                        "Sé premium",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onError,
                          fontSize: 34,
                          fontFamily: 'BettyLavea',
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 15),
                        Text('Chatea sin Limites',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onError,
                            )),
                        SizedBox(height: 16),
                        Text('Participa por citas Regalo',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onError,
                            )),
                        SizedBox(height: 16),
                        Text('Conoce mas personas de tu gusto',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onError,
                            )),
                        SizedBox(height: 16),
                        Text('Mira en que coincides con tu pareja',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onError,
                            )),
                        SizedBox(height: 16),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                child: ListPremium(),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
              ),
            ],
          ),
        ));
  }
}
