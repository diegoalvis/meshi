import 'package:flutter/material.dart';

class SectionIndicator extends StatelessWidget {
  final int currentStep;
  final Color disabledColor;
  final Color enabledColor;
  final Color completedColor;
  final Map<String, List<int>> sections; // Map with section identifier and number of steps by section

  const SectionIndicator(
      {Key key,
      this.sections,
      this.currentStep,
      this.disabledColor,
      this.enabledColor,
      this.completedColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetListOptions = sections?.keys
        ?.map<Widget>((section) => Expanded(
              flex: section.length ~/ (section.length + 1),
              child: Container(
                child: FlatButton(
//              onPressed: () => onSelected(section),
                  child: Text(section.toString(), textAlign: TextAlign.center),
                  textColor: currentStep < sections[section][0]
                      ? disabledColor
                      : currentStep > sections[section][1] ? completedColor : enabledColor,
                ),
              ),
            ))
        ?.toList();
    return widgetListOptions != null ? Row(children: widgetListOptions) : SizedBox();
  }
}
