import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SettingsScreen extends StatelessWidget {
  static String id = 'SettingsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              SwitchListTile(
                value: false,
                title: Text('Dark Mode'),
                onChanged: (newVal) {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
