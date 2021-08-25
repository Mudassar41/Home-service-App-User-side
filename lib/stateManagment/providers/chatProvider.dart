import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:user_side/models/chatModel.dart';

import 'package:user_side/models/providersData.dart';
import 'package:user_side/services/apiServices.dart';
import 'package:user_side/services/sharedPrefService.dart';

import '../controllers/currentUserController.dart';

class ChatProvider extends ChangeNotifier {
  List<Chat> _chatList = [];
  List<Chat> _chatUserList = [];
  Chat _twoWayChat = Chat();

  Chat get twoWayChat => _twoWayChat;

  set twoWayChat(Chat value) {
    _twoWayChat = value;
    notifyListeners();
  }

  ScrollController scrollController;

  var chatEditTextController = TextEditingController();
  ApiServices apiServices = ApiServices();
  SharePrefService sharePrefService = SharePrefService();
  CureentUserController userInfo = Get.find();
  Stream<QuerySnapshot> chatStream;
  bool loadingbar = true;

  List<Chat> get chatList => _chatList;

  set chatList(List<Chat> value) {
    _chatList = value;
    notifyListeners();
    loadingbar = false;
  }

  List<Chat> get chatUserList => _chatUserList;

  set chatUserList(List<Chat> value) {
    _chatUserList = value;
    notifyListeners();
  }

  Future<String> getId() async {
    String id = '';
    id = await sharePrefService.getcurrentUserId();
    return id;
  }

  void scrollUp() {
    final double start = 0;
    scrollController.jumpTo(start);
  }

  void scrollDown() {
    final double end = scrollController.position.maxScrollExtent;
    scrollController.jumpTo(end);
  }
}
