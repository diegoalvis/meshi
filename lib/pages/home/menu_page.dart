import 'package:flutter/material.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meta/meta.dart';

class MenuPage extends StatelessWidget {
  final String currentCategory;
  final Function(String category) onCategoryTap;
  final List<String> categories;

  const MenuPage({
    Key key,
    @required this.currentCategory,
    @required this.onCategoryTap,
    @required this.categories,
  })  : assert(currentCategory != null),
        assert(onCategoryTap != null),
        assert(categories != null);

  Widget _buildCategory(String category, BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () => onCategoryTap(category),
      child: category == currentCategory
          ? Column(
              children: <Widget>[
                SizedBox(height: 16.0),
                Text(
                  category,
                  style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.0),
                Container(
                  width: category.length * 8.0,
                  height: 2.0,
                  color: theme.colorScheme.onPrimary,
                ),
              ],
            )
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
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
    final ThemeData theme = Theme.of(context);
    return Center(
      child: Container(
        color: theme.primaryColor,
        child: ListView(children: categories.map((String c) => _buildCategory(c, context)).toList()),
      ),
    );
  }
}
