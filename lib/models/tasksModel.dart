import 'package:user_side/models/providersData.dart';
import 'package:user_side/models/userprofile.dart';

import 'categories.dart';

class TasksModel {
  String id;

  ProvidersData providerprofiles;
  UserProfile usersregistrationprofiles;
  Providercategories providercategories;
  String userlatitude;
  String userlongitude;
  String offerStatus;
  int v;
  Serviceprovidersdatas serviceprovidersdatas;
  String priceOffered;
  String time;
  String des;
  double userRating;
  String userReview;
  double providerRating;
  String providerReview;
  DateTime dateTime;
  String userAdress;

  TasksModel(
      {this.id,
      this.userlatitude,
      this.userlongitude,
      this.offerStatus,
      this.providercategories,
      this.serviceprovidersdatas,
      this.providerprofiles,
      this.usersregistrationprofiles,
      this.des,
      this.time,
      this.priceOffered,
      this.userReview,
      this.userRating,
      this.providerRating,
      this.providerReview,
      this.dateTime});

  factory TasksModel.fromJson(Map<String, dynamic> json) => TasksModel(
        id: json["_id"],
        providerprofiles: ProvidersData.fromJson1(json["providerprofiles"]),
        usersregistrationprofiles:
            UserProfile.fromJson(json["usersregistrationprofiles"]),
        providercategories:
            Providercategories.fromJson(json["providercategories"]),
        userlatitude: json["userlatitude"],
        userlongitude: json["userlongitude"],
        offerStatus: json["offerStatus"],
        des: json['des'],
        priceOffered: json['priceOffered'],
        time: json['time'],
        serviceprovidersdatas:
            Serviceprovidersdatas.fromJson(json["serviceprovidersdatas"]),
        userRating: json['userRating'].toDouble(),
        userReview: json['userReview'],
        providerRating: json['providerRating'].toDouble(),
        providerReview: json['providerReview'],
        dateTime: DateTime.parse(json["dateTime"]),
      );

  factory TasksModel.fromJson1(Map<String, dynamic> json) => TasksModel(
        id: json["_id"],
        //   providerprofiles: ProvidersData.fromJson1(json["providerprofiles"]),

        usersregistrationprofiles:
            UserProfile.fromJson(json["usersregistrationprofiles"]),

        //  providercategories:
        //  Providercategories.fromJson(json["providercategories"]),
        userlatitude: json["userlatitude"],
        userlongitude: json["userlongitude"],
        offerStatus: json["offerStatus"],
        des: json['des'],
        priceOffered: json['priceOffered'],
        time: json['time'],
        // serviceprovidersdatas:
        // Serviceprovidersdatas.fromJson(json["serviceprovidersdatas"]),
        userRating: json['userRating'].toDouble(),
        userReview: json['userReview'],
        providerRating: json['providerRating'].toDouble(),
        providerReview: json['providerReview'],
        dateTime: DateTime.parse(json["dateTime"]),
      );
}

class Serviceprovidersdatas {
  String id;
  String providerFirstName;
  String providerLastName;
  String providerPhoneNumber;
  String providerPassword;
  String imageLink;
  int v;

  Serviceprovidersdatas({
    this.id,
    this.providerFirstName,
    this.providerLastName,
    this.providerPhoneNumber,
    this.providerPassword,
    this.imageLink,
    this.v,
  });

  factory Serviceprovidersdatas.fromJson(Map<String, dynamic> json) =>
      Serviceprovidersdatas(
        id: json["_id"],
        imageLink: json['imageLink'],
        providerFirstName: json["providerFirstName"],
        providerLastName: json["providerLastName"],
        providerPhoneNumber: json["providerPhoneNumber"],
        providerPassword: json["providerPassword"],
        v: json["__v"],
      );

}
