import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:user_side/animations/rotationAnimation.dart';
import 'package:user_side/models/providersData.dart';
import 'package:user_side/models/tasksModel.dart';
import 'package:user_side/models/userprofile.dart';
import 'package:user_side/services/sharedPrefService.dart';
import 'package:user_side/stateManagment/controllers/currentUserController.dart';
import 'package:user_side/stateManagment/controllers/serviceProvidersController.dart';
import 'package:user_side/stateManagment/providers/tasksProvider.dart';
import 'package:user_side/utils/customToast.dart';
import 'package:user_side/utils/snackBar.dart';

class ApiServices {
  var ipAdress = '192.168.18.100:4000';
  SharePrefService sharePrefService = SharePrefService();

  //var getallServiceproviders=Uri.parse('http://192.168.18.100:4000/getServiceProvidersForUser/${id}');
  var userDataLink = Uri.parse('http://192.168.18.100:4000/AddUser');
  var loginLink = Uri.parse('http://192.168.18.100:4000/loginuser');

  var sendOffersLink = Uri.parse('http://192.168.18.100:4000/offers');
  var getoffersLink = 'http://192.168.18.100:4000/getTasks';
  var providersprofileLink =
      Uri.parse('http://192.168.18.100:4000/addProvidersProfile');
  var getCategoriesUrl = Uri.parse('http://192.168.18.100:4000/getCats');
  var updateTaskslink = Uri.parse('http://192.168.18.100:4000/updateTasks');
  var giveRateReviewToProviderLink =
      Uri.parse('http://192.168.18.100:4000/updateTasksForRateReview');
  var addOffersLink =
      Uri.parse('http://192.168.18.100:4000/addingReviewToProfile');
  var updateImage = Uri.parse('http://192.168.18.100:4000/updateImage');

//  final CureentUserController cureentUserController = Get.put(CureentUserController());

  Future<String> saveRegisteredUserData(
      UserProfile providerModel, ProgressDialog progressDialog) async {
    String res = '';
    progressDialog.style(
        progressWidget: RotationAnimation(20, 20),
        message: 'Please wait..',
        messageTextStyle: TextStyle(fontWeight: FontWeight.normal));
    progressDialog.show();
    try {
      var response = await http.post(userDataLink,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'userFirstName': providerModel.firstName,
            'userLastName': providerModel.lastName,
            'userPhoneNumber': providerModel.phoneNumber,
            'userPassword': providerModel.password,
          }));
      if (response.statusCode == 200) {
        var value = jsonDecode(response.body);
        res = value['msg'];
        sharePrefService.addCurrentuserIdToSf(value['data']['_id']);

        progressDialog.hide();
      } else {
        var value = jsonDecode(response.body);
        print('result is ${value['msg']}');
        res = value['msg'];
        progressDialog.hide();
      }
      return res;
    } catch (e) {
      print(e);
      progressDialog.hide();
      CustomToast.showToast(e);
    }
  }

  Future<String> loginUser(
      UserProfile providerModel, ProgressDialog progressDialog,String countryCode) async {
    String res = '';
    providerModel.phoneNumber = '${countryCode}${providerModel.phoneNumber}';
    progressDialog.style(
        progressWidget: RotationAnimation(20, 20),
        message: 'Please wait..',
        messageTextStyle: TextStyle(fontWeight: FontWeight.normal));
    progressDialog.show();
    try {
      var response = await http.post(loginLink,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'userPhoneNumber': providerModel.phoneNumber,
            'userPassword': providerModel.password,
          }));
      if (response.statusCode == 200) {
        var value = jsonDecode(response.body);
        res = value['msg'];
        var currentUserId = value['UserId']['_id'];
        sharePrefService.addCurrentuserIdToSf(currentUserId);
        progressDialog.hide();
      } else {
        var value = jsonDecode(response.body);
        print('result is ${value['msg']}');
        res = value['msg'];
        progressDialog.hide();
      }
      return res;
    } catch (e) {
      print(e);
      progressDialog.hide();
      CustomToast.showToast(e);
    }
  }

  static Future<List<ProvidersData>> searchCategiesData(String text) async {
    final response = await http.get(Uri.parse(
        'http://192.168.18.100:4000/getServiceProvidersForUser/${text}'));
    if (response.statusCode == 201) {
      var value = jsonDecode(response.body);
      var data = value['data'];
      List<ProvidersData> allProvidersList = data
          .map<ProvidersData>((json) => ProvidersData.fromJson(json))
          .toList();

      return allProvidersList;
    }
  }

  Future<String> sendOfferToServiceProvider(
      ProvidersData providersData,
      ProgressDialog progressDialog,
      ServiceProviderController serviceProviderController,
      String price,
      String des,
      String address,
      String hrs) async {
    print(des);
    print("yes");
    DateTime dateTime = DateTime.now();

    String res = '';
    progressDialog.style(
        progressWidget: RotationAnimation(20, 20),
        message: 'Please wait..',
        messageTextStyle: TextStyle(fontWeight: FontWeight.normal));
    String userId = await sharePrefService.getcurrentUserId();
    progressDialog.show();
    try {
      var response = await http.post(sendOffersLink,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'providerprofiles': providersData.id,
            'usersregistrationprofiles': userId,
            'providercategories': providersData.providercategories.id,
            'serviceprovidersdatas': providersData.serviceprovidersdatas.id,
            'userlatitude': serviceProviderController.lat.toString(),
            'userlongitude': serviceProviderController.lang.toString(),
            'offerStatus': 'none',
            'priceOffered': price,
            'time': hrs,
            'des': des,
            'userAdress': address
          }));
      if (response.statusCode == 200) {
        var value = jsonDecode(response.body);
        res = value['msg'];

        progressDialog.hide();
      } else {
        var value = jsonDecode(response.body);
        // print('result is ${value['msg']}');
        res = value['msg'];
        progressDialog.hide();
      }
      return res;
    } catch (e) {
      print(e);
      progressDialog.hide();
      CustomToast.showToast(e);
    }
  }

  Future<List<TasksModel>> getTasks(TasksProvider tasksProvider) async {
    String Id = await sharePrefService.getcurrentUserId();

    final response =
        await http.get(Uri.parse('http://192.168.18.100:4000/getTasks/${Id}'));
    if (response.statusCode == 200) {
      var value = jsonDecode(response.body);
      var data = value['data'];
      List<TasksModel> tasksList =
          data.map<TasksModel>((json) => TasksModel.fromJson(json)).toList();
      tasksProvider.tasksList = tasksList;
      return tasksList;
    }
  }

  Future<String> updateTask(String taskId, String offerStatus) async {
    String res;
    try {
      var response = await http.patch(updateTaskslink,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'id': taskId,
            'offerStatus': offerStatus,
          }));
      if (response.statusCode == 200) {
        var value = jsonDecode(response.body);
        res = value['msg'];
      } else {
        var value = jsonDecode(response.body);
        print('result is ${value['msg']}');
        res = value['msg'];
      }
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

  Future<String> giveRateReviewToProvider(
      String taskId, double userRating, String userReview) async {
    String res;
    try {
      var response = await http.patch(giveRateReviewToProviderLink,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'id': taskId,
            'userRating': userRating,
            'userReview': userReview
          }));
      if (response.statusCode == 200) {
        var value = jsonDecode(response.body);
        res = value['msg'];
      } else {
        var value = jsonDecode(response.body);
        print('result is ${value['msg']}');
        res = value['msg'];
      }
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

  Future<void> getSingleTasks(
      String offerId, TasksProvider tasksProvider) async {
    final response = await http
        .get(Uri.parse('http://192.168.18.100:4000/getSingleTask/${offerId}'));
    if (response.statusCode == 200) {
      var data = TasksModel.fromJson(jsonDecode(response.body));
      tasksProvider.tasksModel = data;
    }
  }

  Future<String> addOffersDataToProfile(
      String offerId, String profileId) async {
    String res;
    try {
      var response = await http.patch(addOffersLink,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'profileId': profileId,
            'offerId': offerId,
          }));
      if (response.statusCode == 200) {
        var value = jsonDecode(response.body);
        res = value['msg'];
      } else {
        var value = jsonDecode(response.body);
        print('result is ${value['msg']}');
        res = value['msg'];
      }
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

  Future<UserProfile> getCurrrentUserInfo(String id) async {
    final response = await http
        .get(Uri.parse('http://192.168.18.100:4000/getCurrentUserInfo/${id}'));
    if (response.statusCode == 201) {
      var value = jsonDecode(response.body);
      var parsedData = value['data'];
      print(parsedData);
      UserProfile userProfile = UserProfile();
      userProfile.firstName = parsedData['userFirstName'];

      //  print('yes');
      // print(  userProfile.firstName);
      userProfile.lastName = parsedData['userLastName'];
      userProfile.phoneNumber = parsedData['userPhoneNumber'];
      userProfile.userImage = parsedData['userImage'];
       userProfile.userId=parsedData['_id'];
      return userProfile;
    }
  }

  Future<void> updateProfileImage(String imageUrl, String userId) async {
    try {
      var response = await http.patch(updateImage,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'id': userId,
            'userImage': imageUrl,
          }));
      if (response.statusCode == 200) {
        var value = jsonDecode(response.body);
        CustomToast.showToast(value['msg']);
        //cureentUserController.getCurrentUserInfo();
      } else {
        var value = jsonDecode(response.body);
        print('result is ${value['msg']}');
        CustomToast.showToast(value['msg']);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
