import 'package:flutter/cupertino.dart';
import 'package:user_side/models/tasksModel.dart';

class TasksProvider extends ChangeNotifier {
  double rating;
  TextEditingController reviewController = TextEditingController();
  List<TasksModel> _tasksList = [];
  TasksModel _tasksModel = TasksModel();

  TasksModel get tasksModel => _tasksModel;

  set tasksModel(TasksModel value) {
    _tasksModel = value;
    notifyListeners();
  }

  List<TasksModel> get tasksList => _tasksList;

  set tasksList(List<TasksModel> value) {
    _tasksList = value;
    notifyListeners();
  }
}
