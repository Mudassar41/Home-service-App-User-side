import 'dart:convert';
import 'package:flutter_grid_delegate_ext/rendering/grid_delegate.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:user_side/animations/rotationAnimation.dart';
import 'package:user_side/models/categories.dart';
import 'package:user_side/utils/customColors.dart';
import 'package:get/get.dart';
import 'package:user_side/utils/sizing.dart';
import 'package:user_side/widgets/loadingBar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:user_side/stateManagment/controllers/serviceProvidersController.dart';

import '../serviceProvidersScreen.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  var lat;
  var lan;
  bool value = true;
  FocusNode focusNode;
  Future location;
  String str = "Loading...";
  Position position;
  TextEditingController searchController = TextEditingController();
  dynamic selectedcategory;
  List<Providercategories> categoriesList = <Providercategories>[];
  List<Providercategories> tempList = <Providercategories>[];
  bool isLoading = false;
  ProgressDialog progressDialog;
  final ServiceProviderController serviceProviderController =
      Get.put(ServiceProviderController());
  bool showDialogue = true;

  @override
  void initState() {
    // getCurrentPosition();
    getFilterData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    return category();
  }

  Widget category() {
    return Column(

        children: [
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
        child: Align(
          alignment: Alignment.center,
          child: Text('Search Category you are looking for',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: Sizing.textMultiplier * 3)),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          //shadowColor: Customcolors.green,
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: TextField(
            focusNode: focusNode,
            controller: searchController,
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: value == true
                    ? IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        onPressed: () {},
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            value = true;

                            categoriesList = tempList;
                          });
                          // categoriesController.searhtag.value='';
                          searchController.clear();
                          // categoriesController.onInit();
                        },
                      ),
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
            onChanged: (val) {
              setState(() {
                value = false;
              });
              filterList(val);
              print(val);
            },
          ),
        ),
      ),
      Expanded(
          child: isLoading == true
              ? LoadingBar()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: XSliverGridDelegate(
                      crossAxisCount: 2,
                      smallCellExtent: Sizing.heightMultiplier * 20,
                      bigCellExtent: Sizing.heightMultiplier * 20,
                    ),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: InkWell(
                          onTap: () async {
                            progressDialog.style(
                                progressWidget: RotationAnimation(20, 20),
                                message: 'Please wait getting Current Location',
                                messageTextStyle:
                                    TextStyle(fontWeight: FontWeight.normal));
                            progressDialog.show();
                            position = await Geolocator.getCurrentPosition(
                                desiredAccuracy: LocationAccuracy.high,
                                forceAndroidLocationManager: true);

                            setState(() {
                              lat = position.latitude.toDouble();
                              lan = position.longitude.toDouble();
                            });
                            progressDialog.hide();
                            selectedcategory = categoriesList[index].id;
                            if (selectedcategory != null) {
                              serviceProviderController.catId.value =
                                  selectedcategory;
                              serviceProviderController.lat.value = lat;
                              serviceProviderController.lang.value = lan;
                              serviceProviderController.update();
                              // getProvidercurrentlocation();
                              print(serviceProviderController.lang.value);
                              print(serviceProviderController.lat.value);
                              Get.to(ServiceProvidersListScreen(
                                  latitude: lat, longitude: lan));
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    CustomColors.lightGreen,
                                    Colors.white
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight),
                              color: Colors.white12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.network(
                                    'http://192.168.18.100:4000/${categoriesList[index].providerCatImage}',
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '${categoriesList[index].providerCatName[0].toUpperCase()}${categoriesList[index].providerCatName.toLowerCase().substring(1)}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: categoriesList.length,
                  ),
                )),
    ]);
  }

  filterList(String txt) {
    if (txt.isEmpty) {
      if (mounted)
        setState(() {
          categoriesList = tempList;
        });
    } else {
      final List<Providercategories> filteredBreeds = <Providercategories>[];
      tempList.map((breed) {
        if (breed.providerCatName
            .toLowerCase()
            .contains(txt.toString().toLowerCase())) {
          filteredBreeds.add(breed);
        }
      }).toList();
      setState(() {
        categoriesList = filteredBreeds;
      });
    }
  }

  void getFilterData() async {
    if (mounted)
      setState(() {
        isLoading = true;
      });
    tempList = [];
    final response =
        await http.get(Uri.parse('http://192.168.18.100:4000/getCats'));
    if (response.statusCode == 201) {
      var value = jsonDecode(response.body);
      var data = value['data'];
      data.forEach((data) {
        Providercategories categories = Providercategories(
            id: data['_id'],
            providerCatName: data['providerCatName'],
            providerCatImage: data['providerCatImage']);
        tempList.add(categories);
      });
    }
    if (mounted)
      setState(() {
        categoriesList = tempList;
        isLoading = false;
      });
  }

  getCurrentPosition() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true);

    setState(() {
      lat = position.latitude.toDouble();
      lan = position.longitude.toDouble();
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
