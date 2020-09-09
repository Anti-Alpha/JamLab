import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';
import 'dart:core';

import 'package:group/Screens/SideMenu.dart';
import 'package:group/Widgets/ConnectablePageScrollPhysics.dart';
import 'package:group/Widgets/SideMenuConnector.dart';

class CircleInfo extends StatelessWidget {
  Widget getInfoField(String mainText, String underlineText, double width) {
    return Container(
      width: width,
      child: Column(
        children: [
          Text(mainText),
          Divider(),
          Text(underlineText),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.325;
    return Container(
      //color: Colors.white,
      height: 300,
      child: Column(
        children: [
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: getInfoField('The Hackers', 'Group', width),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: getInfoField('Guitar', 'Instrument', width),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(0),
                  width: 0.35 * MediaQuery.of(context).size.width,
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CircleAvatar(),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child:
                            getInfoField('CA, Sacramento', 'Location', width),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child: getInfoField('443', 'Subscriptions', width),
                      ),
                      /*Spacer(
                        flex: 2,
                      ),*/
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(
            flex: 1,
          ),
          getInfoField('George Smith', 'Name',
              MediaQuery.of(context).size.width * 0.325),
        ],
      ),
    );
  }
}

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
      //color: Colors.white,
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

class SimpleScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class ContentField extends StatefulWidget {
  @override
  _ContentFieldState createState() => _ContentFieldState();
}

class _ContentFieldState extends State<ContentField>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ScrollController sideMenuController = SideMenu.of(context).controller;

    return Expanded(
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.photo,
                  color: Colors.black,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.videocam,
                  color: Colors.black,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.music_note,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Expanded(
            child: SideMenuConnector(
              child: TabBarView(
                physics: ConnectableScrollPhysics(sideMenuController),
                controller: _tabController,
                children: [
                  ListView(
                    children: [
                      Container(
                        color: Colors.pink,
                        height: 250,
                      ),
                      Container(
                        color: Colors.cyan,
                        height: 250,
                      ),
                      Container(
                        color: Colors.purple,
                        height: 250,
                      ),
                    ],
                  ),
                  Container(color: Colors.green),
                  Container(color: Colors.blue),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserPage extends StatelessWidget {
  final String _userNickName;
  final String _userName;
  final String _userDescription;

  final _appBarColor = Colors.pink[500];

  UserPage(this._userNickName, this._userName, this._userDescription);

  @override
  Widget build(BuildContext context) {
    //ScrollController sideMenuController = SideMenu.of(context).controller;
    //Drawer()

    return Material(
      child: SideMenu(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading:
                false, //Now back button does not shown when drawer appear
            backgroundColor: Colors.white,
            //Removing shadows by placing on 0.0 Z coordinate
            //elevation: 0.0,
            title: new AutoSizeText(
              _userNickName,
              minFontSize: 28,
              style: TextStyle(
                color: _appBarColor,
              ),
            ),

            actions: <Widget>[
              Builder(
                builder: (context) => new IconButton(
                  iconSize: 40,
                  icon: new Icon(Icons.dehaze, color: _appBarColor),
                  onPressed: () {
                    SideMenu.of(context).open();
                    //Scaffold.of(context).openEndDrawer();
                  },
                ),
              ),
            ],
          ),
          body: DefaultTabController(
            length: 3,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerIsScrolling) {
                return [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        AspectRatio(
                          aspectRatio: 1.6,
                          child: CircleInfo(),
                        ),
                        SizedBox(height: 17.5),
                        Divider(
                          height: 0,
                        ),
                        UserDescription(_userDescription),
                        Divider(
                          height: 0,
                        ),
                      ],
                    ),
                  ),
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: Colors.white,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(-8.0),
                      child: TabBar(
                        tabs: [
                          Tab(
                            icon: Icon(
                              Icons.photo,
                              color: Colors.black,
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              Icons.videocam,
                              color: Colors.black,
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              Icons.music_note,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: Builder(builder: (context) {
                return SideMenuConnector(
                  child: TabBarView(
                    physics: ConnectableScrollPhysics(
                        SideMenu.of(context).controller),
                    children: [
                      ListView(
                        children: [
                          Container(
                            color: Colors.pink,
                            height: 250,
                          ),
                          Container(
                            color: Colors.cyan,
                            height: 250,
                          ),
                          Container(
                            color: Colors.purple,
                            height: 250,
                          ),
                          Container(
                            color: Colors.deepOrange,
                            height: 250,
                          ),
                          Container(
                            color: Colors.indigo,
                            height: 250,
                          ),
                        ],
                      ),
                      Container(color: Colors.green),
                      Container(color: Colors.blue),
                    ],
                  ),
                );
              }),
            ),
          ),
          /*body: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //User info block
                AspectRatio(
                  aspectRatio: 1.6,
                  child: CircleInfo(),
                ),
                SizedBox(height: 17.5),
                Divider(
                  height: 0,
                ),
                UserDescription(_userDescription),
                Divider(
                  height: 0,
                ),
                ContentField(),
              ],
            ),
          ),*/
        ),
      ),
    );
  }
}
