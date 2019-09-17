import 'package:flutter/material.dart';

void onWidgetDidBuild(Function callback) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    callback();
  });
}

Widget buildGradientContainer(BuildContext context, {double height = 100}) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.transparent.withOpacity(0.4),
              Colors.transparent.withOpacity(0.2),
              Colors.transparent.withOpacity(0.1),
              Colors.transparent.withOpacity(0.05),
              Colors.transparent.withOpacity(0.0),
            ],
          )),
    ),
  );
}