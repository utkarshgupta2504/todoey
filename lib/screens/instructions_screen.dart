import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InstructionsScreen extends StatelessWidget {
  static String id = 'InstructionsScreen';

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
              SizedBox(
                height: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InstructionTile(
                    title:
                        'Hold on a task to view information regarding it or edit it.',
                  ),
                  InstructionTile(
                    title: 'Click on the + button to add a new task',
                  ),
                  InstructionTile(
                    title:
                        'Click on the checkbox on the right to mark the task as done',
                  ),
                  InstructionTile(
                    title: 'Swipe a task in any direction to delete the task.',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InstructionTile extends StatelessWidget {
  InstructionTile({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(
        5.0,
      ),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: ListTile(
        leading: Icon(
          FontAwesomeIcons.greaterThan,
          size: 25.0,
        ),
        title: Text(title),
      ),
    );
  }
}
