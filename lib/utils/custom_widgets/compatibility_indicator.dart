/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/utils/icon_utils.dart';

class CompatibilityIndicator extends StatefulWidget {
  final int compatibility;
  final List<String> assertions;

  const CompatibilityIndicator({Key key, this.compatibility, this.assertions}) : super(key: key);

  @override
  _CompatibilityIndicatorState createState() =>
      _CompatibilityIndicatorState(compatibility: compatibility, assertions: assertions);
}

class _CompatibilityIndicatorState extends State<CompatibilityIndicator> {
  final int compatibility;
  final List<String> assertions;

  bool showMore = false;

  _CompatibilityIndicatorState({this.compatibility, this.assertions});

  @override
  Widget build(BuildContext context) {
    final String compatibilityPercent = compatibility != null ? "$compatibility%" : "";
    return Center(
      child: Card(
        child: InkWell(
          onTap: () {
            setState(() => showMore = !showMore);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(IconUtils.heart, scale: 4.0, color: Theme.of(context).primaryColor),
                        Expanded(child: Center(child: Text('Coincidimos en un $compatibilityPercent'))),
                        RotatedBox(quarterTurns: showMore ? 3 : 1, child: Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                    showMore && assertions != null
                        ? Column(
                            children: assertions
                                .map((text) => Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(width: 24),
                                          Center(
                                            child: ClipOval(
                                                child: Container(height: 12, width: 12, color: Theme.of(context).accentColor)),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(child: Text(text)),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          )
                        : SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}