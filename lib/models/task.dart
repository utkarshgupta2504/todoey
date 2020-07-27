class Task {
  Task(
      {this.title, this.isChecked = false, this.reminderDate, this.reminderId});

  final String title;
  bool isChecked;
  final DateTime reminderDate;
  final int reminderId;

  void toggleCheck() {
    isChecked = !isChecked;
  }

  Map toJson() => {
        "title": title,
        "isChecked": isChecked,
        "reminderDate": reminderDate != null ? reminderDate.toString() : null,
        "reminderId": reminderId
      };
}
