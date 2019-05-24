/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */
import 'package:flutter/material.dart';
import 'package:meshi/utils/custom_widgets/interests_image_item.dart';

class MyInterestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 50,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return InterestsItemPage('item $index',
            'https://www.sciencenewsforstudents.org/sites/default/files/2016/06/main/articles/860-header-dog-breeds.jpg');
      },
    );
  }
}
