import 'package:flutter/material.dart';

class OptionSelector extends StatelessWidget {
  final List<String> options;
  final String optionSelected;
  final Function(dynamic) onSelected;

  const OptionSelector(
      {@required this.options, @required this.optionSelected, @required this.onSelected});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetListOptions = options
        .map<Widget>(
          (option) => Expanded(
                flex: option.length ~/ (options.length + 2),
                child: Container(
                  child: FlatButton(
                      onPressed: () => onSelected(option),
                      child: Text(option.toString(), textAlign: TextAlign.center),
                      textColor:
                          option == optionSelected ? Theme.of(context).accentColor : Colors.grey[400]),
                ),
              ),
        )
        .toList();
    return Row(children: widgetListOptions);
  }
}
