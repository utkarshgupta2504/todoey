import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppInfoScreen extends StatelessWidget {
  static String id = 'AppInfoScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.arrowLeft,
                        size: 30.0,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ListTile(
                      title: Text(
                          'A to do list app to maintain all your items, with the functionality of adding a reminder that will send you a notification at the specified time'),
                    ),
                    Divider(
                      thickness: 2.0,
                    ),
                    ListTile(
                      title: Text('Current Version: 1.7.3'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
