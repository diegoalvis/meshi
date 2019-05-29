/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:meshi/data/models/user.dart';

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
    this.alignment: Alignment.bottomRight,
  }) : super(listenable: controller);

  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color color;
  final Alignment alignment;

  // The base size of the dots
  static const double _kDotSize = 7.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

class InterestsProfileImage extends StatefulWidget {
  final String image;
  final Widget widget1;
  final Widget widget2;
  User user;

  InterestsProfileImage({this.image, this.widget1, this.widget2, this.user});

  @override
  State<StatefulWidget> createState() =>
      InterestsProfileImageState(image: image, widget1: widget1, widget2: widget2, user: user);
}

class InterestsProfileImageState extends State<InterestsProfileImage> {
  final _controller = new PageController();
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;
  final String image;
  final Widget widget1;
  final Widget widget2;
  User user;

  InterestsProfileImageState({this.image, this.widget1, this.widget2, this.user});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              titlePadding: EdgeInsets.only(left: 90.0, bottom: 15),
              title: Align(
                alignment: Alignment.bottomLeft,
                child: Text(user.name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  PageView.builder(
                      controller: _controller,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return sliderImage(user.images[index]);
                      }),
                  Positioned(
                    bottom: 20.0,
                    right: 20.0,
                    child: DotsIndicator(
                      controller: _controller,
                      itemCount: user.images.length,
                      onPageSelected: (int page) {
                        _controller.animateToPage(page, duration: _kDuration, curve: _kCurve);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ];
      },
      body: Column(
        children: <Widget>[
          SizedBox(height: 90),
          widget1,
          widget2,
        ],
      ),
    );
  }
}

Widget sliderImage(String url) {
  return AspectRatio(
    aspectRatio: 1.54,
    child: DecoratedBox(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: NetworkImage(url),
        fit: BoxFit.cover,
      )),
    ),
  );
}