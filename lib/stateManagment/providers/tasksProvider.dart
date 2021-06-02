import 'package:flutter/cupertino.dart';
import 'package:user_side/models/tasksModel.dart';

class TasksProvider extends ChangeNotifier {
  List<TasksModel> _tasksList = [];

  List<TasksModel> get tasksList => _tasksList;

  set tasksList(List<TasksModel> value) {
    _tasksList = value;
    notifyListeners();
  }
}
