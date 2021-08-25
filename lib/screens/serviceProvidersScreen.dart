import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:user_side/models/providersData.dart';
import 'package:user_side/stateManagment/controllers/serviceProvidersController.dart';
import 'package:user_side/utils/customColors.dart';
import 'package:user_side/widgets/loadingBar.dart';
import 'package:user_side/screens/serviceProvidersDetail.dart';
import 'dart:math' show cos, sqrt, asin;

class ServiceProvidersListScreen extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String categoryName;

  ServiceProvidersListScreen(
      {this.latitude, this.longitude, this.categoryName});

  final ServiceProviderController controller = Get.find();

  //String catId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        // centerTitle: true,

        actions: [
          Row(
            children: [
              Text(
                'Search Filters',
                style: TextStyle(
                    color: Colors.black45, fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {
                    controller.showMyDialog(context);
                  },
                  icon: Icon(
                    Icons.filter_alt_outlined,
                    color: Colors.black45,
                  )),
            ],
          )
        ],
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: LoadingBar());
          } else {
            return controller.dataList.length == 0
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/nop.svg',
                        height: 100,
                        width: 150,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'No profile found',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CustomColors.lightRed),
                        ),
                      ),
                    ],
                  ))
                : ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.dataList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () {
                            Get.to(ServiceProvidersDetailScreen(
                                data: controller.dataList[index]));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 70,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(controller
                                          .dataList[index]
                                          .serviceprovidersdatas
                                          .imageLink),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${controller.dataList[index].serviceprovidersdatas.providerFirstName[0].toUpperCase()}${controller.dataList[index].serviceprovidersdatas.providerFirstName.toLowerCase().substring(1)} ${controller.dataList[index].serviceprovidersdatas.providerLastName[0].toUpperCase()}${controller.dataList[index].serviceprovidersdatas.providerLastName.toLowerCase().substring(1)}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 15,
                                              color: CustomColors.lightRed,
                                            ),
                                            // Text(
                                            //     '${_coordinateDistance(double.parse(controller.dataList[index].latitude), double.parse(controller.dataList[index].longitude), controller.lat.value, controller.lang.value)} Km',
                                            //     maxLines: 1,
                                            //     overflow: TextOverflow.ellipsis,
                                            //     style: TextStyle(
                                            //         color: Colors.black54)),
                                            Text(
                                                '${(Geolocator.distanceBetween(double.parse(controller.dataList[index].latitude), double.parse(controller.dataList[index].longitude), controller.lat.value, controller.lang.value) / 1000).toStringAsFixed(3)} Km',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.black54)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Rating',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          //  mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 16,
                                              color: Colors.yellow,
                                            ),
                                            Text(
                                                (controller.dataList[index]
                                                                .offerscollections
                                                                .fold(
                                                                    0,
                                                                    (sum, element) =>
                                                                        sum +
                                                                        element
                                                                            .userRating) /
                                                            controller
                                                                .dataList[index]
                                                                .offerscollections
                                                                .length)
                                                        .isNaN
                                                    ? '0.0'
                                                    : '${controller.dataList[index].offerscollections.fold(0, (sum, element) => sum + element.userRating) / controller.dataList[index].offerscollections.length}',
                                                style: TextStyle(
                                                    color: Colors.black54)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Jobs',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              '${controller.dataList[index].offerscollections.length}',
                                              style: TextStyle(
                                                  color: Colors.black54))
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
          }
        }),
      ),
    );
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
