import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Task {
  Task(
      {this.title,
      this.isChecked = false,
      this.reminderDate,
      this.reminderTime,
      this.reminderId});

  final String title;
  bool isChecked;
  final DateTime reminderDate;
  final TimeOfDay reminderTime;
  final int reminderId;

  void toggleCheck() {
    isChecked = !isChecked;
  }

  Map toJson() => {
        "title": title,
        "isChecked": isChecked,
        "reminderDate": reminderDate != null
            ? reminderDate
                .add(Duration(
                  hours: reminderTime.hour,
                  minutes: reminderTime.minute,
                ))
                .toString()
            : null,
        "reminderId": reminderId
      };
}
