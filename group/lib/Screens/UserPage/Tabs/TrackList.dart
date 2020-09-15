import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

class TrackList extends StatelessWidget {
  Widget buildTrack(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.only(bottom: 5.0),
      height: 50,
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          AutoSizeText(
            'Strategy of Fire',
            minFontSize: 16.0,
          ),
          SizedBox(
            width: 10.0,
          ),
          AutoSizeText(
            '3:05',
            minFontSize: 16.0,
          ),
          Spacer(),
          AspectRatio(
            aspectRatio: 1.0,
            child: Material(
              color: Colors.white,
              child: InkWell(
                customBorder: CircleBorder(),
                child: Icon(
                  Icons.play_arrow,
                  size: 45,
                ),
                onTap: () {
                  //print('pressed');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        top: 5.0,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(buildTrack, childCount: 5),
      ),
    );
  }
}
