/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';

import '../strings.dart';

class OptionSelector extends StatelessWidget {
  final List<Object> options;
  final Object optionSelected;
  final Function(Object) onSelected;

  const OptionSelector({@required this.options, @required this.optionSelected, @required this.onSelected});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetListOptions = options
        .map<Widget>(
          (option) => Expanded(
                // TODO: strings.enumName(option)
                flex: enumName(option).length ~/ (options.length + 2),
                child: Container(
                  child: FlatButton(
                      onPressed: () => onSelected(enumName(option)),
                      // TODO: strings.enumName(option)
                      child: Text(enumName(option), textAlign: TextAlign.center),
                      textColor: option == optionSelected ? Theme.of(context).accentColor : Colors.grey[400]),
                ),
              ),
        )
        .toList();
    return Row(children: widgetListOptions);
  }
}
