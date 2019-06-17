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
                SizedBox(height: 8.0),
                Text(
                  category,
                  style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 6.0),
                Container(
                  width: category.length * 8.0,
                  height: 2.0,
                  color: theme.colorScheme.onPrimary,
                ),
                SizedBox(height: 8.0),
              ],
            )
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                category,
                style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: ListView(
          children: categories.map((String category) => _buildCategory(context, category, categories.indexOf(category))).toList()),
    );
  }
}
