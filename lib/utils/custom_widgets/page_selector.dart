import 'package:flutter/material.dart';

class PageSelector extends StatelessWidget {
  final int currentPage;
  final List<Widget> pages;

  const PageSelector({Key key, this.currentPage, this.pages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (currentPage > pages.length) {
      return pages.last;
    } else {
      return pages[currentPage - 1];
    }
  }
}
