import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:group/Screens/LoginScreen.dart';

import 'Screens/UserPage.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    ));

/*void main() {
  debugPrintGestureArenaDiagnostics = true;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserPage('@tewiskh', 'Rostislav Pytlyar',
        'Hi! I`m Rostislav and i`m looking for funny bandmates to play out every weekend. Also I can sing, so I need a second guitar player and a drummer. Have a nice day!)'),
  ));
}*/
