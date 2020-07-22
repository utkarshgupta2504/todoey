class Task {
  Task({this.title, this.isChecked = false});

  final String title;
  bool isChecked;

  void toggleCheck() {
    isChecked = !isChecked;
  }
}
