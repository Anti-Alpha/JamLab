import 'package:flutter/material.dart';

class CircleInfo extends StatelessWidget {
  final String _userName;

  CircleInfo(this._userName);

  Widget getInfoField(String mainText, String underlineText, double width) {
    return Container(
      width: width,
      child: Column(
        children: [
          Text(mainText),
          Divider(),
          Text(underlineText),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.325;
    return Container(
      //color: Colors.white,
      height: 300,
      child: Column(
        children: [
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: getInfoField('The Hackers', 'Group', width),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: getInfoField('Guitar', 'Instrument', width),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(0),
                  width: 0.35 * MediaQuery.of(context).size.width,
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/avatar.jpg'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child:
                            getInfoField('Kharkiv, Ukraine', 'Location', width),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child: getInfoField('443', 'Subscriptions', width),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(
            flex: 1,
          ),
          getInfoField(
              _userName, 'Name', MediaQuery.of(context).size.width * 0.325),
        ],
      ),
    );
  }
}
