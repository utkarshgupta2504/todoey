import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_data.dart';
import 'package:todoey/screens/task_info_screen.dart';

class TaskTile extends StatelessWidget {
  TaskTile({this.title, this.isChecked, this.callback, this.index});

  final String title;
  final bool isChecked;
  final Function callback;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TaskInfoScreen(
            index: index,
            task: Provider.of<TaskData>(context).tasks[index],
          );
        }));
      },
      onDoubleTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TaskInfoScreen(
            index: index,
            task: Provider.of<TaskData>(context).tasks[index],
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
