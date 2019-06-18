/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/utils/app_icons.dart';

import '../localiztions.dart';

class CompatibilityIndicator extends StatefulWidget {
  final int compatibility;
  final List<String> assertions;

  const CompatibilityIndicator({Key key, this.compatibility, this.assertions}) : super(key: key);

  @override
  _CompatibilityIndicatorState createState() => _CompatibilityIndicatorState();
}

class _CompatibilityIndicatorState extends State<CompatibilityIndicator> {
  //final int compatibility;
  //List<String> assertions;

  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    final String compatibilityPercent = widget.compatibility != null ? "${widget.compatibility}%" : "";
    final strings = MyLocalizations.of(context);
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
                        Icon(AppIcons.hearth, color:Theme.of(context).primaryColor, size:30, ),
                        Expanded(child: Center(child: Text("${strings.weAgree} $compatibilityPercent"))),
                        RotatedBox(quarterTurns: showMore ? 3 : 1, child: Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                    showMore && widget.assertions != null
                        ? Column(
                            children: widget.assertions
                                .map((text) => Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(width: 24),
                                          Center(
                                            child: ClipOval(
                                                child: Container(
                                                    height: 12,
                                                    width: 12,
                                                    color: Theme.of(context).accentColor)),
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
