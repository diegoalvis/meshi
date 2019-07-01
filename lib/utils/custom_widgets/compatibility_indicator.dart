/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meshi/data/models/recomendation.dart';
import 'package:meshi/utils/app_icons.dart';

import '../localiztions.dart';

class CompatibilityIndicator extends StatefulWidget {
  final int compatibility;
  final List<Similarity> similarities;

  const CompatibilityIndicator({Key key, this.compatibility, this.similarities}) : super(key: key);

  @override
  _CompatibilityIndicatorState createState() => _CompatibilityIndicatorState();
}

class _CompatibilityIndicatorState extends State<CompatibilityIndicator> {
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
                        SizedBox(width: 10),
                        Icon(
                          AppIcons.hearth,
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        ),
                        SizedBox(width: 20),
                        Expanded(child: Text("${strings.weAgree} $compatibilityPercent", style: TextStyle(fontWeight: FontWeight.bold))),
                        RotatedBox(quarterTurns: showMore ? 3 : 1, child: Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                    showMore && widget.similarities != null
                        ? Column(
                            children: widget.similarities
                                .map((similarity) => Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(width: 24),
                                          Center(
                                            child: ClipOval(
                                                child: Container(height: 12, width: 12, color: Theme.of(context).accentColor)),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(child: Text("${toBeginningOfSentenceCase(similarity.label)} ${similarity.value}")),
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
