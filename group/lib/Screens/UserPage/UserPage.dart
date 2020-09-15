import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter/rendering.dart';
import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';

import 'package:group/Widgets/SideMenu/all.dart';

import 'package:group/Screens/UserPage/CircleInfo.dart';
import 'package:group/Screens/UserPage/UserDescription.dart';
import 'package:group/Screens/UserPage/Tabs/all.dart';

class UserPage extends StatelessWidget {
  final String _userNickName;
  final String _userName;
  final String _userDescription;

  final _appBarColor = Colors.pink[500];

  UserPage(this._userNickName, this._userName, this._userDescription);

  @override
  Widget build(BuildContext context) {
    var mainTabBar = TabBar(
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
    );

    return Material(
      child: SideMenu(
        child: Scaffold(
          body: Container(
            color: Colors.white,
            child: DefaultTabController(
              length: 3,
              child: NestedScrollView(
                pinnedHeaderSliverHeightBuilder: () {
                  double mainTabBarHeight = mainTabBar.preferredSize.height;
                  return mainTabBarHeight + kToolbarHeight - 24;
                },
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      primary: true,
                      pinned: true,
                      automaticallyImplyLeading:
                          false, //Now back button does not shown when drawer appear
                      elevation: 0.0,
                      backgroundColor: Colors.white,
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

                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(0.0),
                        child: Divider(
                          height: 0.0,
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          AspectRatio(
                            aspectRatio: 1.6,
                            child: CircleInfo(_userName),
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
                        primary: false,
                        backgroundColor: Colors.white,
                        bottom: PreferredSize(
                            preferredSize: Size.fromHeight(-8.0),
                            child: mainTabBar),
                      ),
                    ),
                  ];
                },
                body: Builder(builder: (BuildContext context) {
                  return SideMenuConnector(
                    child: TabBarView(
                      physics: ConnectableScrollPhysics(SideMenu.of(context)),
                      children: [
                        SafeArea(
                          top: false,
                          child: CustomScrollView(
                            slivers: <Widget>[
                              SliverOverlapInjector(
                                handle: NestedScrollView
                                    .sliverOverlapAbsorberHandleFor(context),
                              ),
                              PhotoGrid(),
                            ],
                          ),
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
