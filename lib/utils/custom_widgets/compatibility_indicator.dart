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
  _CompatibilityIndicatorState createState() => _CompatibilityIndicatorState();
}

class _CompatibilityIndicatorState extends State<CompatibilityIndicator> {
  //final int compatibility;
  //List<String> assertions;

  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    final String compatibilityPercent = widget.compatibility != null ? "$widget.compatibility%" : "";
    return Center(
      child: Card(
        child: InkWell(
          onTap: () {
            setState(() => showMore = !showMore);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Wrap(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(IconUtils.heart, scale: 6.0, color: Theme.of(context).primaryColor),
                        Expanded(child: Center(child: Text('Coincidimos en un $compatibilityPercent'))),
                        RotatedBox(quarterTurns: showMore ? 3 : 1, child: Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                    showMore && widget.assertions != null
                        ? Column(
                            children: widget.assertions
                                .map((text) => Container(
                                      margin: const EdgeInsets.all(10.0),
                                      color: Colors.white,
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
