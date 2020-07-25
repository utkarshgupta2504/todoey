import 'package:flutter/material.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/screens/task_info.dart';

class TaskTile extends StatelessWidget {
  TaskTile(
      {this.title,
      this.isChecked,
      this.callback,
      this.deleteCallback,
      this.task});

  final String title;
  final bool isChecked;
  final Function callback;
  final Function deleteCallback;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: deleteCallback,
      onDoubleTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TaskInfo(
            task: task,
          );
        }));
      },
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Checkbox(
          activeColor: Colors.lightBlueAccent,
          value: isChecked,
          onChanged: callback,
        ),
      ),
    );
  }
}
