import 'package:flutter/material.dart';
import 'package:group/Animation/FadeAnimation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:async';
import 'dart:convert' show json;

import "package:http/http.dart" as http;

import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';


  class LoginPage extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
      return _LoginPageState();
    }
  }

  class _LoginPageState extends State<LoginPage> {
    bool _isLoggedIn = false;
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

    _login() async {
      try {
         await _googleSignIn.signIn();
         setState(() {
           _isLoggedIn = true;
         });
      }
      catch(err) {
        print(err);
      }
    }

    _logout() {
      _googleSignIn.signOut();
      setState(() {
        _isLoggedIn = false;
      });
    }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print('qweqweqwe');
    print(width);
    print(height);
    ScreenUtil.init(context, width: width, height: height);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          children: <Widget>[
            FadeAnimation(
              0.5,
              Container(
                height: 0.4.hp,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/jam.png'),
                  fit: BoxFit.fill,
                )),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: FadeAnimation(
                          0.5,
                          Container(
                            margin: EdgeInsets.only(top: 0.075.hp),
                            child: Center(
                              child: Text("Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold)),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 0.1.hp),
            Container(
              child: _isLoggedIn?
                  Column(
                    children: <Widget>[
                      Image.network(
                        _googleSignIn.currentUser.photoUrl,
                        height: 50.0,
                        width: 50.0,
                      ),
                      Text(_googleSignIn.currentUser.displayName),
                      OutlineButton(
                        child: Text("Logout"),
                        onPressed: () {
                          _logout();
                        },
                      )
                    ],
                  )
              :GoogleSignInButton(
                onPressed: () {
                  _login();
                },
              )

            )
          ],
        ),
      )),
    );
  }
}
