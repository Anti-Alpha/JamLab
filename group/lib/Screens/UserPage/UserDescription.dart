import 'package:flutter/material.dart';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';

class UserDescription extends StatefulWidget {
  //final _closedHeight = 45.0;
  //final _openedHeight = double.infinity;
  final String _descriptionText;

  UserDescription(this._descriptionText);

  @override
  _UserDescriptionState createState() => _UserDescriptionState();
}

class _UserDescriptionState extends State<UserDescription>
    with SingleTickerProviderStateMixin {
  final _animationTime = 100;

  bool _isOpened;
  int _maxLines;

  double _rotationHolder;

  onPress() {
    setState(() {
      _isOpened = !_isOpened;

      _rotationHolder = _isOpened ? pi : 0;
      _maxLines = _isOpened ? 20 : 2;
    });
  }

  @override
  void initState() {
    _rotationHolder = 0;
    _isOpened = false;
    _maxLines = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: AnimatedSize(
                alignment: Alignment.topCenter,
                duration: Duration(milliseconds: _animationTime),
                curve: Curves.fastOutSlowIn,
                vsync: this,
                child: AutoSizeText(
                  widget._descriptionText,
                  minFontSize: 18,
                  maxLines: _maxLines,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: _rotationHolder),
              duration: Duration(milliseconds: _animationTime * 2),
              child: Icon(Icons.arrow_drop_down),
              builder: (BuildContext context, double rotation, Widget child) {
                return Transform.rotate(
                  angle: rotation,
                  child: child,
                );
              },
            ),
          ],
        ),
        onTap: onPress,
      ),
    );
  }
}
