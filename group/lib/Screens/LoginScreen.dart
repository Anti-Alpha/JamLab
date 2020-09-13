import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Presentation/my_flutter_app_icons.dart';
import 'dart:async';
import 'dart:convert' show json;
import 'SignUpScreen.dart';
import 'UserPage.dart';


import "package:http/http.dart" as http;

import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';


  class LoginPage extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
      return _LoginPageState();
    }
  }
  final FirebaseAuth mAuth = FirebaseAuth.instance;
  class _LoginPageState extends State<LoginPage> {
    bool _isLoggedIn = false;
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();

    _login() async {
      try {
         await _googleSignIn.signIn();
         setState(() {
           _isLoggedIn = true;
         });
         //TO DO: display information in profile
         Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => UserPage(_googleSignIn.currentUser.email, _googleSignIn.currentUser.displayName, 'hui')));
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
                      child: Container(
                            margin: EdgeInsets.only(top: 0.075.hp),
                            child: Center(
                              child: Text("Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                    ),
                  ],
                ),
              ),

            Padding(

                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                        Container(
                          height: 0.1629.hp,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, 0.2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[100]))),
                                child: TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email or Phone number",
                                      hintStyle:
                                      TextStyle(color: Colors.grey[300])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle:
                                      TextStyle(color: Colors.grey[300])),
                                ),
                              ),
                            ],
                          ),
                        ),
                  ],
                )),
                Container(
                  height: 0.047.hp,
                  width: 0.7664.wp,
                  child: OutlineButton(
                    onPressed: () {
                      signUpWithEmailPassword();
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    splashColor: Colors.red[500],
                    textColor: Colors.grey[300],
                    color: Colors.red[500],
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );},
              textColor: Colors.red[500],
              child: Text("Don't have an Account? Sign up!",
              style: TextStyle(fontSize: 15.0),),
            ),
            OrDivider(),
            Container (
              width: 0.7664.wp,
              child: Row(
              children: <Widget>[
                Expanded(
                child: RawMaterialButton(
                  onPressed: () {_login();},
                  elevation: 2.0,
                  fillColor: Colors.red,
                  child: Icon(MyFlutterApp.google, color: Colors.white),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),),
                Expanded(
                child: RawMaterialButton(
                  onPressed: () {},
                  elevation: 2.0,
                  fillColor: Colors.blue[700],
                  child: Icon(MyFlutterApp.facebook, color: Colors.white),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),),
                Expanded(
                child: RawMaterialButton(
                  onPressed: () {},
                  elevation: 2.0,
                  fillColor: Colors.blue[300],
                  child: Icon(MyFlutterApp.twitter, color: Colors.white,),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),),
              ],
            ),
            ),
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
              :null

            ),

            SizedBox(
              height: 0.08.hp,
            ),
                Container(
                  //0,1377.hp?
                  child: FlatButton(
                    onPressed: () {
                    },
                    textColor: Colors.red[500],
                    child: Text("Forgot password?"),
                  ),
                )
        ],
        ),
      )),
    );
  }
    Future<void> signUpWithEmailPassword() async {
      FirebaseUser user;
      user = (await mAuth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text)) as FirebaseUser;
    }
    Future<void> signInWithEmailPassword() async {
      FirebaseUser user;
      user = (await mAuth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text)) as FirebaseUser;
    }
}
class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "OR",
              style: TextStyle(
                color: Colors.red[500],
                fontWeight: FontWeight.w600,
              ),
            ),),
          buildDivider(),
        ],
      ),
    );
  }
}
Expanded buildDivider() {
  return Expanded(
    child: Divider(
      color:  Colors.black,
      height: 1.5,
    ),
  );
}

