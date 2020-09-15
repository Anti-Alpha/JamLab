import 'package:flutter/material.dart';

import 'SideMenu.dart';

class ConnectableScrollPhysics extends ScrollPhysics {
  const ConnectableScrollPhysics(this.rightSideConnection,
      {ScrollPhysics parent})
      : super(parent: parent);

  final SideMenuState rightSideConnection;

  @override
  ConnectableScrollPhysics applyTo(ScrollPhysics ancestor) {
    return ConnectableScrollPhysics(rightSideConnection,
        parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      return value - position.pixels;
    } // underscroll

    if (position.maxScrollExtent <= position.pixels &&
        position.pixels < value) // overscroll
    {
      return value - position.pixels;
    }

    if (value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels) // hit top edge
    {
      return value - position.minScrollExtent;
    }

    if (position.pixels < position.maxScrollExtent &&
        position.maxScrollExtent < value) // hit bottom edge
    {
      return value - position.maxScrollExtent;
    }

    /*if (rightSideConnection.offset > 0.0) {
      return value - position.pixels;
    } else {
      return 0.0;
    }*/
    if (rightSideConnection.isOverScroll) {
      return value - position.pixels;
    } else {
      return 0.0;
    }
  }
}
