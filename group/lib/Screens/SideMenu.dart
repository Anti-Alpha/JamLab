import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:core';

class SideMenu extends StatefulWidget {
  final Widget child;

  SideMenu({
    this.child,
  }) : assert(child != null);

  @override
  SideMenuState createState() => SideMenuState();

  static SideMenuState of(BuildContext context) {
    final navigator = context.findAncestorStateOfType<SideMenuState>();

    assert(() {
      if (navigator == null) {
        throw new FlutterError(
            '_SideMenuState operation requested with a context that does '
            'not include a _SideMenuState.');
      }
      return true;
    }());

    return navigator;
  }
}

class _SimpleScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class SideMenuState extends State<SideMenu>
    with SingleTickerProviderStateMixin {
  final double _menuScreenFactor = 0.65;
  ScrollController controller;
  bool isMenuOpen = false;
  bool isMenuBlocked = false;
  bool isOverScroll = false;

  @override
  initState() {
    super.initState();

    isMenuOpen = false;
    controller = ScrollController()
      ..addListener(() {
        bool _newMenuOpen = controller.offset > 50 ? true : false;

        if (_newMenuOpen != isMenuOpen) {
          setState(() {
            isMenuOpen = _newMenuOpen;
          });
        }
      });
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  block() {
    if (!isMenuBlocked) {
      setState(() {
        isMenuBlocked = true;
        //print('isMenuBlocked true');
      });
    }
  }

  unblock() {
    if (isMenuBlocked) {
      setState(() {
        isMenuBlocked = false;
        //print('isMenuBlocked false');
      });
    }
  }

  overscrollStart() {
    if (!isOverScroll) {
      setState(() {
        isOverScroll = true;
        //print('isOverScroll true');
      });
    }
  }

  overScrollEnd() {
    if (isOverScroll) {
      setState(() {
        isOverScroll = false;
        //print('isOverScroll false');
      });
    }
  }

  open() {
    controller.animateTo(controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 246), curve: Curves.ease);
  }

  close() {
    controller.animateTo(0,
        duration: const Duration(milliseconds: 246), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    HitTestBehavior _pageGestureBehaviour =
        isMenuOpen ? HitTestBehavior.opaque : HitTestBehavior.deferToChild;

    ScrollPhysics _physics =
        isMenuBlocked ? NeverScrollableScrollPhysics() : PageScrollPhysics();

    double width = MediaQuery.of(context).size.width;

    return ScrollConfiguration(
      behavior: _SimpleScrollBehavior(),
      child: ListView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        physics: _physics,
        children: [
          Container(
            width: width,
            child: Stack(
              children: [
                widget.child,
                GestureDetector(
                  behavior: _pageGestureBehaviour,
                  excludeFromSemantics: true,
                  onTap: close,
                ),
              ],
            ),
          ),
          Container(
            width: width * _menuScreenFactor,
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }
}