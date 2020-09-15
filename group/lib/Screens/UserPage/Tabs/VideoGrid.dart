import 'package:flutter/material.dart';

class VideoGrid extends StatelessWidget {
  Widget buildVideo(BuildContext context, int index) {
    return Container(
      color: Colors.green[100 * (index % 9 + 1)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
      ),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(buildVideo, childCount: 13),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
      ),
    );
  }
}
