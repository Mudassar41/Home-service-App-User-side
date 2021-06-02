import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:user_side/animations/rotationAnimation.dart';
import 'package:user_side/models/providersData.dart';
import 'package:user_side/models/tasksModel.dart';
import 'package:user_side/models/userprofile.dart';
import 'package:user_side/services/sharedPrefService.dart';
import 'package:user_side/stateManagment/controllers/serviceProvidersController.dart';
import 'package:user_side/stateManagment/providers/tasksProvider.dart';
import 'package:user_side/utils/customToast.dart';
import 'package:user_side/utils/snackBar.dart';

class ApiServices {
  var ipAdress = '192.168.43.113:4000';
  SharePrefService sharePrefService = SharePrefService();

  //var getallServiceproviders=Uri.parse('http://192.168.43.113:4000/getServiceProvidersForUser/${id}');
  var userDataLink = Uri.parse('http://192.168.43.113:4000/AddUser');
  var loginLink = Uri.parse('http://192.168.43.113:4000/loginuser');

  var sendOffersLink = Uri.parse('http://192.168.43.113:4000/offers');
  var getoffersLink = 'http://192.168.43.113:4000/getTasks';
  var providersprofileLink =
      Uri.parse('http://192.168.43.113:4000/addProvidersProfile');
  var getCategoriesUrl = Uri.parse('http://192.168.43.113:4000/getCats');

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
      UserProfile providerModel, ProgressDialog progressDialog) async {
    String res = '';
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
        'http://192.168.43.113:4000/getServiceProvidersForUser/${text}'));
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
      String hrs) async {
    print(des);
    print("yes");
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
            'des': des
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
        await http.get(Uri.parse('http://192.168.43.113:4000/getTasks/${Id}'));
    if (response.statusCode == 200) {
      var value = jsonDecode(response.body);
      var data = value['data'];
      // print(data);
      List<TasksModel> tasksList =
          data.map<TasksModel>((json) => TasksModel.fromJson(json)).toList();
      tasksProvider.tasksList = tasksList;
      return tasksList;
    }
  }
}
