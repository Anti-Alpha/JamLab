import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/scheduler.dart';

import 'SideMenu.dart';

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

          if (sideMenuController.offset == 0) {
            /*SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              sideMenuState.block();
            });*/
            sideMenuState.block();
          }
        }

        if (notification is OverscrollNotification) {
          if (notification.dragDetails == null) {
            return false;
          }

          if (notification.dragDetails.delta.dx < 0 &&
              sideMenuController.offset == 0) {
            if (drag == null) {
              sideMenuState.overscrollStart();

              drag = sideMenuController.position.drag(dragStartDetails, () {});
            }
          }
          if (drag != null) {
            //print('Calling overscroll update');
            drag.update(notification.dragDetails);
          }
        }

        if (notification is ScrollUpdateNotification) {
          if (notification.dragDetails == null) {
            return false;
          }

          if (sideMenuController.offset == 0) {
            sideMenuState.block();
          }

          if (sideMenuController.offset > 0) {
            drag.update(notification.dragDetails);
          }
        }

        if (notification is ScrollEndNotification) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            sideMenuState.unblock();

            sideMenuState.overScrollEnd();
          });

          //sideMenuState.unblock();

          //sideMenuState.overScrollEnd();

          if (notification.dragDetails == null) {
            drag = null;
            return false;
          }

          if (drag != null) {
            //print('Ending drag');
            drag.end(notification.dragDetails);
          }

          drag = null;
        }

        return false;
      },
      child: ScrollConfiguration(
        behavior: SimpleScrollBehavior(),
        child: child,
      ),
    );
  }
}
