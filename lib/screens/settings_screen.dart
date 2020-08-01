import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_data.dart';

class SettingsScreen extends StatefulWidget {
  static String id = 'SettingsScreen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool isDark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
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
              SwitchListTile(
                value: Provider.of<TaskData>(context).currTheme == ThemeData.dark(),
                title: Text('Dark Mode'),
                onChanged: (newVal) {
                  setState(() {
                    isDark = newVal;
                    Provider.of<TaskData>(context, listen: false).toggleTheme();
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
