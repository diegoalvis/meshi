import 'package:flutter/material.dart';
import 'package:meshi/pages/forms/basic/basic_page_four.dart';
import 'package:meshi/pages/forms/basic/basic_page_one.dart';
import 'package:meshi/pages/forms/basic/basic_page_three.dart';
import 'package:meshi/pages/forms/basic/basic_page_two.dart';
import 'package:meshi/pages/forms/habits/habits_page_one.dart';
import 'package:meshi/pages/forms/habits/habits_page_two.dart';
import 'package:meshi/pages/forms/specifics/specific_page_one.dart';

class PageSelector extends StatelessWidget {
  final int currentPage;

  const PageSelector({Key key, this.currentPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (currentPage) {
      case 1:
        return BasicFormPageOne();
      case 2:
        return BasicFormPageTwo();
      case 3:
        return BasicFormPageThree();
      case 4:
        return BasicFormPageFour();
      case 5:
        return HabitsFormPageOne();
      case 6:
        return HabitsFormPageTwo();
      case 7:
        return SpecificsFormPageOne();
      default:
        return BasicFormPageOne();
    }
  }
}
