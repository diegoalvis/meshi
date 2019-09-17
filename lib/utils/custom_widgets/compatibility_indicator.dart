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
  final bool isPremium;

  const CompatibilityIndicator({Key key, this.compatibility, this.similarities, this.isPremium = false}) : super(key: key);

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
          onTap: widget.isPremium ? () {
            setState(() => showMore = !showMore);
          } : null,
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
                          color: Theme.of(context).accentColor,
                          size: 25,
                        ),
                        SizedBox(width: 20),
                        Expanded(
                            child: Text("${strings.weAgree}  ${widget.compatibility > 30 ? compatibilityPercent : '?'}",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        RotatedBox(quarterTurns: showMore ? 3 : 1, child: Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                    showMore && widget.similarities != null && widget.compatibility > 30
                        ? Column(
                            children: widget.similarities
                                .map((similarity) => Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(width: 16),
                                          Center(
                                            child: ClipOval(
                                                child: Container(height: 8, width: 8, color: Theme.of(context).accentColor)),
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                              child: Text(
                                                  "${toBeginningOfSentenceCase(strings.getUserProp(similarity.label))} ${getSimilarityValue(strings, similarity)}")),
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

  String getSimilarityValue(MyLocalizations strings, Similarity similarity) {
    if (similarity.type == TYPE_ARRAY) {
      return similarity.value.split(',').map((val) => strings.getCompatibilityDisplayName(val)).join(", ");
    }
    if (similarity.type == TYPE_INT && similarity.value == "0") {
      return "No";
    }
    return strings.getCompatibilityDisplayName(similarity.value);
  }
}
