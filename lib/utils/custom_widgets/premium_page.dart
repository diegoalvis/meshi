/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/utils/custom_widgets/premium_features_list.dart';
import 'package:meshi/utils/localiztions.dart';

import '../app_icons.dart';

class PremiumPage extends StatefulWidget with HomeSection {
  bool isFromRecommendation = false;

  @override
  State<StatefulWidget> createState() => PremiumPageState();

  PremiumPage(this.isFromRecommendation);
}

class PremiumPageState extends State<PremiumPage> {
  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    return Center(
      child: Wrap(
        children: <Widget>[
          Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
                            Color(0xff5E2531),
                            Color(0xff80065E),
                          ])),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Row(
                              children: <Widget>[
                                Spacer(),
                                Icon(
                                  AppIcons.crown,
                                  color: Colors.white70,
                                  size: 34,
                                ),
                                SizedBox(width: 32),
                                Text(
                                  strings.bePremium,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 34,
                                    fontFamily: 'BettyLavea',
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 16),
                              buildPremiumFeatureItem(strings.chatWithoutLimits),
                              SizedBox(height: 16),
                              buildPremiumFeatureItem(strings.participateGiftDate),
                              SizedBox(height: 16),
                              buildPremiumFeatureItem(strings.seeCompatible),
                              SizedBox(height: 16),
                              buildPremiumFeatureItem(strings.findInterestInYou),
                              SizedBox(height: 16),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: PremiumFeaturesList(widget.isFromRecommendation),
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Row buildPremiumFeatureItem(String title) {
    return Row(
      children: <Widget>[
        SizedBox(width: 24),
        Center(
          child: ClipOval(child: Container(height: 8, width: 8, color: Colors.white70)),
        ),
        SizedBox(width: 8),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text(title,
              maxLines: 2,
              style: TextStyle(
                color: Colors.white70,
              )),
        ),
      ],
    );
  }
}
