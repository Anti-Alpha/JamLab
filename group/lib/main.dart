import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:group/Screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Screens/UserPage/UserPage.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JamLab(),
    ));

class JamLab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.hasData) {
            FirebaseUser user = snapshot.data; // this is your user instance
            /// is because there is user already logged
            return UserPage('@tewiskh', 'Rostislav Pytlyar', 'hui');
          }

          /// other way there is no user logged.
          return LoginPage();
        });
  }
}

/*void main() {
  debugPrintGestureArenaDiagnostics = false;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserPage('@tewiskh', 'Rostislav Pytlyar',
        'Hi! I`m Rostislav and i`m looking for funny bandmates to play out every weekend. Also I can sing, so I need a second guitar player and a drummer. Have a nice day!)'),
  ));
}*/
