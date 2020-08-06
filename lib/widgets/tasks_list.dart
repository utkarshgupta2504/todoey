import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/models/task_data.dart';
import 'package:todoey/widgets/task_tile.dart';

final LocalStorage localStorage = LocalStorage('toDoList.json');

bool initialised = false;
List tasksList = [];
String theme;

class TasksList extends StatelessWidget {
  Future<bool> get getData async {
    await localStorage.ready;

    if (localStorage != null) {
      theme = await localStorage.getItem('theme');

      tasksList = await localStorage.getItem('todos');
      print(theme);
      print(tasksList);
      if (tasksList == null) {
        tasksList = [
          Task(title: 'This Is A Task, Hold to view details.'),
          Task(title: 'Click the + button, to add a new task'),
          Task(title: 'Check the task, to mark it complete'),
          Task(title: 'Swipe in any direction to delete the task.'),
        ].map((e) => e.toJson()).toList();
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData,
      builder: (context, snapshot) {
        print(snapshot);
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Consumer<TaskData>(
            builder: (context, taskData, child) {
              if (!initialised) {
                if (theme == 'dark') {
                  taskData.toggleTheme();
                }
                taskData.init(tasksList);
                initialised = true;
              }
              print(taskData.tasks);

              if (taskData.tasks.length == 0) {
                return Center(
                  child: Text(
                    'Woohoo! You are all caught up!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25.0,
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final task = taskData.tasks[index];
                  return Dismissible(
                    key: UniqueKey(),
                    dismissThresholds: {
                      DismissDirection.startToEnd: 0.6,
                      DismissDirection.endToStart: 0.6,
                    },
                    onDismissed: (direction) {
                      taskData.deleteTask(task);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Item Removed'),
                        action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              taskData.addTask(task, index: index);
                            }),
                      ));
                    },
                    background: Container(
                      color: Colors.red,
                      padding: EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    secondaryBackground: Container(
                      padding: EdgeInsets.only(right: 20.0),
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    child: TaskTile(
                      index: index,
                      title: task.title,
                      isChecked: task.isChecked,
                      callback: (newValue) {
                        taskData.toggleCheck(task);
                      },
                    ),
                  );
                },
                itemCount: taskData.tasks.length,
              );
            },
          );
        }
      },
    );
  }
}
