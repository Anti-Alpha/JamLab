import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';

class AboutMeText extends StatelessWidget {
  final String _aboutMe;

  AboutMeText(this._aboutMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              _aboutMe,
              style: TextStyle(
                fontSize: 18.0,
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
  //final _appBarTitleSize = 28.0;
  //final _appBarIconSize = 40.0;

  UserPage(this._userNickName, this._userName, this._userDescription);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        //Removing shadows by placing on 0.0 Z coordinate
        //elevation: 0.0,
        title: new Text(
          '@' + _userNickName,
          style: TextStyle(
            fontSize: 28.0,
            color: _appBarColor,
          ),
        ),

        actions: <Widget>[
          new IconButton(
            iconSize: 40,
            icon: new Icon(Icons.list, color: _appBarColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //User info block
            Container(
              //height: MediaQuery.of(context).size.height * 0.15,
              //constraints: BoxConstraints(minHeight: 95, maxHeight: 95),
              height: 75.0,
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                  //Avatar
                  AspectRatio(
                    aspectRatio: 1,
                    child: CircleAvatar(),
                  ),
                  //Text info block
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _userName,
                              style: TextStyle(fontSize: 30.0),
                            ),
                          ),
                          //AboutMeText(_userDescription),
                          //TODO WasInNetwork Widget
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Был в сети в 1970 году',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              child: Column(
                children: [
                  AboutMeText(_userDescription),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'About me',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: _appBarColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
