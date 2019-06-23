/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class MenuPage extends StatelessWidget {
  final String currentCategory;
  final Function(String category, int pos) onCategoryTap;
  final List<String> categories;

  const MenuPage({
    Key key,
    @required this.currentCategory,
    @required this.onCategoryTap,
    @required this.categories,
  })  : assert(currentCategory != null),
        assert(onCategoryTap != null),
        assert(categories != null);

  Widget _buildCategory(BuildContext context, String category, int pos) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () => onCategoryTap(category, pos),
      child: category == currentCategory
          ? Column(
              children: <Widget>[
                Spacer(),
                Text(
                  category,
                  style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: category.length * 8.0,
                  height: 2.0,
                  color: theme.colorScheme.onPrimary,
                ),
                Spacer(),
              ],
            )
          : Center(
            child: Text(
              category,
              style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 17.0),
              textAlign: TextAlign.center,
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: <Widget>[
            Container(
              height: constrains.biggest.height / 2 - 48.0,
              child: Column(
                  children: categories
                      .map((String category) =>
                      Expanded(child: _buildCategory(context, category, categories.indexOf(category))))
                      .toList()),
            ),
          ],
        ),
      );
    });
  }
}
