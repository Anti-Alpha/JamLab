import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:group/Screens/SideMenu.dart';

class SimpleScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class SideMenuConnector extends StatelessWidget {
  SideMenuConnector({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    SideMenuState sideMenuState = SideMenu.of(context);
    assert(sideMenuState != null);

    ScrollController sideMenuController = sideMenuState.controller;

    DragStartDetails dragStartDetails;
    Drag drag;

    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollStartNotification) {
          dragStartDetails = notification.dragDetails;
        }

        if (notification is OverscrollNotification) {
          if (notification.dragDetails == null) {
            return true;
          }

          //print(notification.dragDetails.delta);

          if (notification.dragDetails.delta.dx != 0) {
            drag = sideMenuController.position.drag(dragStartDetails, () {});
            drag.update(notification.dragDetails);
          }
        }

        if (notification is ScrollUpdateNotification) {
          if (notification.dragDetails == null) {
            return true;
          }

          if (sideMenuController.offset > 0) {
            drag.update(notification.dragDetails);
          }
        }

        if (notification is ScrollEndNotification) {
          if (notification.dragDetails == null) {
            return true;
          }

          if (drag != null) {
            drag.end(notification.dragDetails);
          }

          drag = null;

          /*if (notification.dragDetails.velocity.pixelsPerSecond.dx <= -365 &&
              sideMenuController.offset > 0) {
            //SideMenu.of(context).openWithVelocity(notification.dragDetails);
            //SideMenu.of(context).open();
            drag.end(notification.dragDetails);
          } else {
            drag?.cancel();
          }*/
        }

        return true;
      },
      child: ScrollConfiguration(
        behavior: SimpleScrollBehavior(),
        child: child,
      ),
    );
  }
}
