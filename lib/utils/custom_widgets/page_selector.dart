/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';

class PageSelector extends StatelessWidget {
  final int currentPagePos;
  final List<Widget> pages;

  const PageSelector({Key key, this.currentPagePos, this.pages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (currentPagePos > pages.length) {
      return pages.last;
    } else {
      return pages[currentPagePos - 1];
    }
  }
}
