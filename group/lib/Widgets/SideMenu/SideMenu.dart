import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';

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

    return WillPopScope(
      onWillPop: () {
        close();
        return Future<bool>(() {
          return isMenuOpen ? false : true;
        });
      },
      child: ScrollConfiguration(
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
              color: Colors.white,
              child: SafeArea(
                child: Row(
                  children: [
                    VerticalDivider(width: 0.0),
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width * _menuScreenFactor,
                      child: Scaffold(
                        appBar: AppBar(
                          elevation: 0.0,
                          backgroundColor: Colors.white,
                          title: new AutoSizeText(
                            '@tewiskh',
                            minFontSize: 28,
                            style: TextStyle(
                              color: Colors.pink,
                            ),
                          ),
                          bottom: PreferredSize(
                            preferredSize: Size.fromHeight(0.0),
                            child: Divider(
                              height: 0.0,
                            ),
                          ),
                        ),
                        body: Container(
                          color: Colors.white,
                          child: ListView(
                            children: [
                              Material(
                                color: Colors.white,
                                child: InkWell(
                                  child: Container(
                                    margin: EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.settings,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        AutoSizeText(
                                          'Settings',
                                          minFontSize: 24,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    close();
                                  },
                                ),
                              ),
                              Material(
                                color: Colors.white,
                                child: InkWell(
                                  child: Container(
                                    margin: EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.business_center,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        AutoSizeText(
                                          'Services',
                                          minFontSize: 24,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    close();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
