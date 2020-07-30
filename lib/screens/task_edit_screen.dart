import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoey/constants.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/models/task_data.dart';
import 'package:todoey/widgets/option_button.dart';

import '../main.dart';

class TaskEditScreen extends StatefulWidget {
  TaskEditScreen({this.task});

  final Task task;

  @override
  _TaskEditScreenState createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  final titleController = TextEditingController();

  bool dropDownVal = false;
  DateTime reminderDate;
  String reminderDateString;

  String newTaskTitle;
  DateTime newTaskReminderDate;
  bool newTaskIsChecked;

  @override
  void initState() {
    super.initState();
    titleController.value = TextEditingValue(
      text: widget.task.title,
    );
    newTaskTitle = widget.task.title;
    dropDownVal = widget.task.isChecked;
    newTaskIsChecked = widget.task.isChecked;
    reminderDate = widget.task.reminderDate;
    newTaskReminderDate = reminderDate;
    reminderDateString = reminderDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlueAccent,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FlatButton(
                child: Icon(
                  FontAwesomeIcons.arrowLeft,
                  color: Colors.white,
                  size: 40.0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20.0,
                  left: 30.0,
                  right: 30.0,
                  bottom: 30.0,
                ),
                child: Text(
                  'Edit Task',
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 30.0,
                        left: 30.0,
                        right: 30.0,
                        bottom: 30.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Title: ',
                                    style: kTaskInfoTextStyle,
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      onChanged: (newValue) {
                                        newTaskTitle = newValue;
                                      },
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      controller: titleController,
                                      style: kTaskInfoTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.0),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Task is Done? : ',
                                    style: kTaskInfoTextStyle,
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  DropdownButton<bool>(
                                    value: dropDownVal,
                                    style: kTaskInfoTextStyle,
                                    items: [true, false]
                                        .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e.toString())))
                                        .toList(),
                                    onChanged: (newVal) {
                                      setState(() {
                                        dropDownVal = newVal;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Reminder: ',
                                    style: kTaskInfoTextStyle,
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Expanded(
                                    child: FlatButton(
                                      color: Colors.lightBlueAccent,
                                      onPressed: () async {
                                        newTaskReminderDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate:
                                                    reminderDate != null
                                                        ? reminderDate
                                                        : DateTime.now(),
                                                firstDate: reminderDate != null
                                                    ? reminderDate
                                                    : DateTime.now(),
                                                lastDate: DateTime(
                                                    DateTime.now().year + 2));

                                        if (newTaskReminderDate == null) {
                                          return;
                                        }

                                        TimeOfDay reminderTime =
                                            await showTimePicker(
                                                context: context,
                                                initialTime: reminderDate !=
                                                        null
                                                    ? TimeOfDay(
                                                        hour: reminderDate.hour,
                                                        minute:
                                                            reminderDate.minute,
                                                      )
                                                    : TimeOfDay(
                                                        hour: 0,
                                                        minute: 0,
                                                      ));

                                        newTaskReminderDate =
                                            newTaskReminderDate.add(Duration(
                                          hours: reminderTime.hour,
                                          minutes: reminderTime.minute,
                                        ));

                                        setState(() {
                                          reminderDateString =
                                              newTaskReminderDate.toString();
                                        });
                                      },
                                      child: Text(
                                        newTaskReminderDate != null
                                            ? reminderDateString.substring(0,
                                                reminderDateString.length - 7)
                                            : 'Not Set',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete_outline),
                                    onPressed: () {
                                      setState(() {
                                        newTaskReminderDate = null;
                                      });
                                    },
                                    color: Colors.red,
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          Container(
                            width: double.infinity,
                            child: OptionButton(
                              title: 'Save Changes',
                              onPressed: () async {
                                if (newTaskTitle == widget.task.title &&
                                    newTaskIsChecked == dropDownVal &&
                                    newTaskReminderDate ==
                                        widget.task.reminderDate) {
                                  Navigator.pop(context);
                                  return;
                                }

                                int id;

                                if (reminderDate != newTaskReminderDate &&
                                    newTaskReminderDate != null) {
                                  var scheduledNotificationDateTime =
                                      newTaskReminderDate
                                          .subtract(Duration(seconds: 5));
                                  var androidPlatformChannelSpecifics =
                                      AndroidNotificationDetails(
                                    newTaskTitle,
                                    'To Do Notification',
                                    'Do the task',
                                    priority: Priority.Max,
                                    importance: Importance.Max,
                                    playSound: true,
                                  );
                                  var iOSPlatformChannelSpecifics =
                                      IOSNotificationDetails();
                                  NotificationDetails platformChannelSpecifics =
                                      NotificationDetails(
                                          androidPlatformChannelSpecifics,
                                          iOSPlatformChannelSpecifics);
                                  id = widget.task.reminderId != null
                                      ? widget.task.reminderId
                                      : Provider.of<TaskData>(context,
                                              listen: false)
                                          .tasks
                                          .indexOf(widget.task);
                                  print(id);

                                  await flutterLocalNotificationsPlugin
                                      .cancel(id);
                                  await flutterLocalNotificationsPlugin.schedule(
                                      id,
                                      'Task reminder',
                                      'It is time for your task: $newTaskTitle',
                                      scheduledNotificationDateTime,
                                      platformChannelSpecifics);
                                }

                                if (widget.task.reminderDate != null &&
                                    newTaskReminderDate == null) {
                                  await flutterLocalNotificationsPlugin
                                      .cancel(widget.task.reminderId);
                                }

                                Provider.of<TaskData>(context, listen: false)
                                    .modifyTask(
                                        widget.task,
                                        Task(
                                            title: newTaskTitle,
                                            isChecked: dropDownVal,
                                            reminderDate: newTaskReminderDate,
                                            reminderId: id));

                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
