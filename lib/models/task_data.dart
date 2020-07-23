import 'package:flutter/material.dart';
import 'package:todoey/models/task.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';

final LocalStorage localStorage = LocalStorage('toDoList.json');

class TaskData extends ChangeNotifier {
  List<Task> tasks = [
    Task(title: 'This Is A Task'),
    Task(title: 'Click the + button, to add a new task'),
    Task(title: 'Check the task, to mark it complete'),
    Task(title: 'Hold the text to delete the task.'),
  ];

  Future<void> _saveToStorage() async {
    await localStorage.setItem('todos', tasks.map((e) => e.toJson()).toList());
  }

  Future<void> getTasks() async {
    await localStorage.ready;
    List tasksList = localStorage.getItem('todos') ?? tasks;
    print(tasksList);
    tasks.clear();
    tasksList.map((e) {
      tasks.add(Task(title: e['title'], isChecked: e['isChecked']));
    });
    notifyListeners();
  }

  Future<void> addTask(String title) async {
    tasks.add(Task(title: title));
    await _saveToStorage();
    // await getTasks();
    notifyListeners();
  }

  Future<void> toggleCheck(Task task) async {
    task.toggleCheck();
    await _saveToStorage();
    // await getTasks();
    notifyListeners();
  }

  Future<void> deleteTask(Task task) async {
    tasks.remove(task);
    await _saveToStorage();
    getTasks();
    notifyListeners();
  }

  int get taskCount {
    return tasks.length;
  }

  Future<void> init(item) async {
    print(item);
//    tasks.clear();
    if (item.length > 0) {
      tasks.clear();
      for (Map e in item) {
        tasks.add(Task(title: e['title'], isChecked: e['isChecked']));
      }
      print('zeroth');
//      notifyListeners();
    }
  }
}
