// import 'package:get/get.dart';
// import 'package:user_side/models/tasksModel.dart';
// import 'package:user_side/services/apiServices.dart';
//
// class TaskController extends GetxController{
//
// var singleTaskData=<TasksModel>[].obs;
// ApiServices apiServices=ApiServices();
// var isLoading=true.obs;
// @override
//   void refresh() {
//     // TODO: implement refresh
//     super.refresh();
//   }
// void getSingleTask(String tag) async {
//   isLoading(true);
//   try {
//     var list = await apiServices.getSingleTasks(tasksProvider, offerId);
//     if (list != null) {
//       dataList = list;
//     }
//   } finally {
//     isLoading(false);
//   }
// }
//
//
// }