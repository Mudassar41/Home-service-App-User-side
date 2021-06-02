import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';

class OfferController extends GetxController {
  var time = '0'.obs;
  var list = ['1', '2', '3', '4', '5'].obs;
  var priceEditController = TextEditingController();
  var desEditController=TextEditingController();
  ProgressDialog progressDialog;
}
