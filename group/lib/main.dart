import 'package:flutter/material.dart';
import 'package:group/Animation/FadeAnimation.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          children: <Widget>[
            FadeAnimation(0.5,
            Container(
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/jam.png'),
                  fit: BoxFit.fill,
                )
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: FadeAnimation(
                        0.5,
                        Container(
                          margin: EdgeInsets.only(top: 50),
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
            Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                        0.6,
                        Container(
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
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[300])),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                )),
            FadeAnimation(
                0.7,
                Container(
                  height: 40,
                  width: 315,
                  child: OutlineButton(
                    onPressed: () {},
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
                )),
            SizedBox(
              height: 70.0,
            ),
            FadeAnimation(
                0.8,
                Container(
                  child: FlatButton(
                    onPressed: () {},
                    textColor: Colors.red[500],
                    child: Text("Forgot Password?"),
                  ),
                ))
          ],
        ),
      )),
    );
  }
}
