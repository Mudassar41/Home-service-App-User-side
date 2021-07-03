import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_side/models/providersData.dart';
import 'package:user_side/services/apiServices.dart';
import 'dart:math' show cos, sqrt, asin;

import 'package:user_side/utils/customColors.dart';

class ServiceProviderController extends GetxController {
  var lat = 0.0.obs;
  var lang = 0.0.obs;
  var catId = ''.obs;
  var isLoading = true.obs;
  var areainKm = 3.0.obs;
  var searchCheck = true.obs;
  var distanceEditTextController = TextEditingController();
  var searchNameText = ''.obs;
  var searchNameEditTextController = TextEditingController();
  var dataList = <ProvidersData>[].obs;
  var searchgList = <ProvidersData>[].obs as List<ProvidersData>;
  var tempList = <ProvidersData>[].obs;

  @override
  void refresh() {
    super.refresh();
    print("updated");
    print(catId.value);
    fetchCategoriesData(catId.value, areainKm.value, searchNameText.value);
  }

  void fetchCategoriesData(String id, double distance, String searchTag) async {
    dataList.value.clear();
    isLoading(true);
    try {
      List<ProvidersData> list = await ApiServices.searchCategiesData(id);
      if (list != null) {
        if (searchTag != '') {
          list.map((e) {
            if (e.serviceprovidersdatas.providerFirstName
                    .toLowerCase()
                    .contains(searchTag) &&
                coordinateDistance(double.parse(e.latitude),
                            double.parse(e.longitude), lat.value, lang.value)
                        .truncate() <=
                    areainKm.value) {
              searchgList.add(e);
            }
          }).toList();
        } else {
          list.map((e) {
            if (coordinateDistance(double.parse(e.latitude),
                        double.parse(e.longitude), lat.value, lang.value)
                    .truncate() <=
                areainKm.value) {
              searchgList.add(e);
            }
          }).toList();
        }

        dataList.value = searchgList;

        tempList.value = searchgList;
      }
    } finally {
      isLoading(false);
    }
  }

  double coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Distance in Km'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchNameEditTextController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Enter Service Provider Name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: distanceEditTextController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'Enter Distance'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: CustomColors.lightRed),
                      child: Text('Apply'),
                      onPressed: () {
                        areainKm.value =
                            double.parse(distanceEditTextController.text);

                        searchNameText.value =
                            searchNameEditTextController.text;

                        searchNameEditTextController.clear();
                        dataList.value.clear();
                        update();
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context);
                      }),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
