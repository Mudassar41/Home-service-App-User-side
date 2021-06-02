import 'dart:convert';
import 'package:flutter_grid_delegate_ext/rendering/grid_delegate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:user_side/models/categories.dart';
import 'package:user_side/utils/customColors.dart';
import 'package:get/get.dart';
import 'package:user_side/utils/sizing.dart';
import 'package:user_side/widgets/loadingBar.dart';
import 'package:user_side/screens/serviceProvidersScreen.dart';
import 'package:user_side/stateManagment/controllers/serviceProvidersController.dart';
import 'package:location/location.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var location = new Location();
  LocationData _locationData;
  var lat;
  var lan;
  Position _currentPosition;
  bool value = true;
  FocusNode focusNode;
  TextEditingController searchController = TextEditingController();
  dynamic selectedcategory;
  List<Providercategories> categoriesList = <Providercategories>[];
  List<Providercategories> tempList = <Providercategories>[];
  bool isLoading = false;
  final ServiceProviderController serviceProviderController =
      Get.put(ServiceProviderController());

  @override
  void initState() {
    getFilterData();
    getProvidercurrentlocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return category();
  }

  Widget category() {
    return Column(children: [
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
                          onTap: () {
                            // location.onLocationChanged
                            //     .listen((LocationData currentLocation) {

                            //   // Use current location

                            // });

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
                                    CustomColors.lightGreen,
                                    Colors.white
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight),
                              color: Colors.black12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.network(
                                    'http://192.168.43.113:4000/${categoriesList[index].providerCatImage}',
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '${categoriesList[index].providerCatName[0].toUpperCase()}${categoriesList[index].providerCatName.toLowerCase().substring(1)}',
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
        await http.get(Uri.parse('http://192.168.43.113:4000/getCats'));
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

  getProvidercurrentlocation() {
    location.onLocationChanged.listen((LocationData currentLocation) {
      if(mounted)
      setState(() {
        lat = currentLocation.latitude;
        lan = currentLocation.longitude;
      });
    //  print(lat);
    });
  }
}
