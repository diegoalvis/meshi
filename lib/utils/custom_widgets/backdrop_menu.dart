/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/pages/home/home_page.dart';
import 'package:meta/meta.dart';

const double _kFlingVelocity = 2.0;

class BackdropMenu extends StatefulWidget {
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;
  final Widget floatingActionButton;

  const BackdropMenu({
    @required this.frontLayer,
    @required this.backLayer,
    @required this.frontTitle,
    @required this.backTitle,
    this.floatingActionButton,
  })  : assert(frontLayer != null),
        assert(backLayer != null),
        assert(backTitle != null);

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<BackdropMenu> with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');

  AnimationController _controller;
  String lastCategorySelected;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  // TODO: Add override for didUpdateWidget (104)
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling(velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity);
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest / 2;
    final double layerTop = layerSize.height - layerTitleHeight;
    final bloc = HomeBlocProvider.of(context).bloc;

    bloc.categorySelectedStream.listen((category) {
      _controller.fling(velocity: _kFlingVelocity);
    });

    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_controller.view);

    return Stack(
      key: _backdropKey,
      children: <Widget>[
        ExcludeSemantics(
          child: widget.backLayer,
          excluding: _frontLayerVisible,
        ),
        PositionedTransition(
          rect: layerAnimation,
          child: _FrontLayer(
            title: widget.frontTitle,
            child: widget.frontLayer,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0.0,
        titleSpacing: 0.0,
        leading: GestureDetector(
          onTap: _toggleBackdropLayerVisibility,
          child: Transform.rotate(
            angle: -0.3,
            child: Image.asset(
              "res/icons/logo.png",
              scale: 4,
              color: Colors.white,
            ),
          ),
        ),
        title: GestureDetector(onTap: _toggleBackdropLayerVisibility, child: Text('Meshi')),
      ),
      body: LayoutBuilder(builder: _buildStack),
      floatingActionButton: widget.floatingActionButton,
    );
  }
}

class _FrontLayer extends StatelessWidget {
  const _FrontLayer({
    Key key,
    this.child,
    this.title,
  }) : super(key: key);

  final Widget child;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    const cornerInclination = 40.0;
    return Material(
      elevation: 16.0,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(cornerInclination)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          title == null
              ? SizedBox()
              : Container(
                  height: cornerInclination,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 15.0),
                  child: title),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
