import 'package:flutter/material.dart';

class PhotoGrid extends StatelessWidget {
  Widget buildPhoto(BuildContext context, int index) {
    if (index < 3) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/photo${(index + 1)}.jpg'),
            fit: BoxFit.fitHeight,
          ),
        ),
      );
    }

    return Container(
      color: Colors.red[100 * (index % 9 + 1)],
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
        delegate: SliverChildBuilderDelegate(buildPhoto, childCount: 3),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
      ),
    );
  }
}
