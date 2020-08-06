import 'package:flutter/material.dart';
import 'package:todoey/models/task.dart';
import 'package:localstorage/localstorage.dart';

final LocalStorage localStorage = LocalStorage(
  'toDoList.json',
);

class TaskData extends ChangeNotifier {
  ThemeData currTheme = ThemeData.light();

  List<Task> tasks = [];

  Future<void> _saveToStorage() async {
    await localStorage.setItem('theme', currTheme == ThemeData.dark() ? 'dark' : 'light');
    await localStorage.setItem('todos', tasks.map((e) => e.toJson()).toList());
  }

  Future<void> addTask(Task task, {int index}) async {
    if (index != null) {
      tasks.insert(index, task);
    } else {
      tasks.add(task);
    }
    await _saveToStorage();
    notifyListeners();
  }

  Future<void> toggleCheck(Task task) async {
    task.toggleCheck();
    await _saveToStorage();
    notifyListeners();
  }

  Future<void> deleteTask(Task task) async {
    tasks.remove(task);
    await _saveToStorage();
    notifyListeners();
  }

  Future<void> modifyTask(Task original, Task newTask) async {
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i] == original) {
        print('Task found at $i');
        tasks[i] = newTask;
        break;
      }
    }

    await _saveToStorage();
    notifyListeners();
  }

  int get taskCount {
    return tasks.length;
  }

  Future<void> init(item) async {
    print(item);
    if (item != null && item.length > 0) {
      tasks.clear();
      for (Map e in item) {
        tasks.add(Task(
            title: e['title'],
            isChecked: e['isChecked'],
            reminderDate: e['reminderDate'] != null ? DateTime.parse(e['reminderDate']) : null,
            reminderId: e['reminderId']));
      }
    }
  }

  Future<void> toggleTheme() async {
    if (currTheme == ThemeData.light()) {
      currTheme = ThemeData.dark();
    } else {
      currTheme = ThemeData.light();
    }
    await _saveToStorage();
    notifyListeners();
  }
}
