import 'package:flutter/material.dart';
import 'package:todoey/models/task.dart';

class TaskData extends ChangeNotifier {
  List<Task> tasks = [
    Task(title: 'This Is A Task'),
    Task(title: 'Click the + button, to add a new task'),
    Task(title: 'Check the task, to mark it complete'),
    Task(title: 'Hold the text to delete the task.'),
  ];

  void addTask(String title) {
    tasks.add(Task(title: title));
    notifyListeners();
  }

  void toggleCheck(Task task) {
    task.toggleCheck();
    notifyListeners();
  }

  void deleteTask(Task task) {
    tasks.remove(task);
    notifyListeners();
  }

  int get taskCount {
    return tasks.length;
  }
}
