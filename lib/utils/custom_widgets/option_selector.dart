/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';

import '../enum_helper.dart';
import '../localiztions.dart';

class OptionSelector extends StatelessWidget {
  final List<Object> options;
  final Object optionSelected;
  final Function(Object) onSelected;

  const OptionSelector({@required this.options, @required this.optionSelected, @required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    List<Widget> widgetListOptions = options
        .map<Widget>(
          (option) => Expanded(
                flex: strings.getEnumDisplayName(enumValue(option)).length ~/ (strings.getEnumDisplayName(enumValue(option)).length + 2),
                child: Container(
                  child: FlatButton(
                      onPressed: () => onSelected(enumValue(option)),
                      child: Text(strings.getEnumDisplayName(enumValue(option)), textAlign: TextAlign.center),
                      textColor: enumValue(option) == optionSelected ? Theme.of(context).accentColor : Colors.grey[400]),
                ),
              ),
        )
        .toList();
    return Row(children: widgetListOptions);
  }
}
