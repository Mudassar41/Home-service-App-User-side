import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:user_side/animations/rotationAnimation.dart';
import 'package:user_side/models/providersData.dart';
import 'package:user_side/models/userprofile.dart';
import 'package:user_side/utils/customToast.dart';
import 'package:user_side/utils/snackBar.dart';

class ApiServices {
  var ipAdress='192.168.43.31:4000';
  //var getallServiceproviders=Uri.parse('http://192.168.43.31:4000/getServiceProvidersForUser/${id}');
  var userDataLink = Uri.parse('http://192.168.43.31:4000/AddUser');
  var loginLink = Uri.parse('http://192.168.43.31:4000/loginuser');
  var providersprofileLink =
      Uri.parse('http://192.168.43.31:4000/addProvidersProfile');
  var getCategoriesUrl = Uri.parse('http://192.168.43.31:4000/getCats');

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
    final response = await http.get(
        Uri.parse('http://192.168.43.31:4000/getServiceProvidersForUser/${text}'));
    if (response.statusCode == 201) {
      var value = jsonDecode(response.body);
      var data = value['data'];
      List<ProvidersData> allProvidersList =
          data.map<ProvidersData>((json) => ProvidersData.fromJson(json)).toList();

      return allProvidersList;
    }
  }



}
