import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';
import 'dart:core';

import 'package:group/Screens/SideMenu.dart';
import 'package:group/Widgets/ConnectablePageScrollPhysics.dart';
import 'package:group/Widgets/SideMenuConnector.dart';

class UserPage extends StatelessWidget {
  final String _userNickName;
  final String _userName;
  final String _userDescription;

  final _appBarColor = Colors.pink[500];

  UserPage(this._userNickName, this._userName, this._userDescription);

  @override
  Widget build(BuildContext context) {
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
                  },
                ),
              ),
            ],
          ),
          body: Container(
            color: Colors.white,
            child: DefaultTabController(
              length: 3,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
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
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverAppBar(
                        forceElevated: innerBoxIsScrolled,
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
                    ),
                  ];
                },
                body: Builder(builder: (BuildContext context) {
                  return SideMenuConnector(
                    child: TabBarView(
                      physics: ConnectableScrollPhysics(SideMenu.of(context)),
                      children: [
                        CustomScrollView(
                          slivers: <Widget>[
                            SliverOverlapInjector(
                              handle: NestedScrollView
                                  .sliverOverlapAbsorberHandleFor(context),
                            ),
                            PhotoGrid(),
                          ],
                        ),
                        CustomScrollView(
                          slivers: <Widget>[
                            SliverOverlapInjector(
                              handle: NestedScrollView
                                  .sliverOverlapAbsorberHandleFor(context),
                            ),
                            VideoGrid(),
                          ],
                        ),
                        CustomScrollView(
                          slivers: <Widget>[
                            SliverOverlapInjector(
                              handle: NestedScrollView
                                  .sliverOverlapAbsorberHandleFor(context),
                            ),
                            TrackList(),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/avatar.jpg'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child:
                            getInfoField('Kharkiv, Ukraine', 'Location', width),
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
          getInfoField('Rostislav Pitlyar', 'Name',
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

class PhotoGrid extends StatelessWidget {
  Widget buildPhoto(BuildContext context, int index) {
    if (index < 3) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/photo${(index + 1)}.jpg'),
            fit: BoxFit.fitHeight,
          ),
        ),
      );
    }

    return Container(
      color: Colors.red[100 * (index % 9 + 1)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
      ),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(buildPhoto, childCount: 3),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
      ),
    );
  }
}

class VideoGrid extends StatelessWidget {
  Widget buildVideo(BuildContext context, int index) {
    return Container(
      color: Colors.green[100 * (index % 9 + 1)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
      ),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(buildVideo, childCount: 13),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
      ),
    );
  }
}

class TrackList extends StatelessWidget {
  Widget buildTrack(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.only(bottom: 5.0),
      height: 50,
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          AutoSizeText(
            'Strategy of Fire',
            minFontSize: 16.0,
          ),
          SizedBox(
            width: 10.0,
          ),
          AutoSizeText(
            '3:05',
            minFontSize: 16.0,
          ),
          Spacer(),
          AspectRatio(
            aspectRatio: 1.0,
            child: Material(
              color: Colors.white,
              child: InkWell(
                customBorder: CircleBorder(),
                child: Icon(
                  Icons.play_arrow,
                  size: 45,
                ),
                onTap: () {
                  //print('pressed');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        top: 5.0,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(buildTrack, childCount: 5),
      ),
    );
  }
}
