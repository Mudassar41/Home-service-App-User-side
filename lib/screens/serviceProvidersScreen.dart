import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:user_side/stateManagment/controllers/serviceProvidersController.dart';
import 'package:user_side/utils/customColors.dart';
import 'package:user_side/widgets/loadingBar.dart';
import 'package:user_side/screens/serviceProvidersDetail.dart';

class ServiceProvidersListScreen extends StatelessWidget {
  final double latitude;
  final double longitude;
  ServiceProvidersListScreen({this.latitude, this.longitude});
  final ServiceProviderController controller = Get.find();
  //String catId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: LoadingBar());
        } else {
          return controller.dataList.length == 0
              ? Center(child: Text("No Service Found"))
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        AssetImage('assets/images/profile.jpg'),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${controller.dataList[index].serviceprovidersdatas.providerFirstName[0].toUpperCase()}${controller.dataList[index].serviceprovidersdatas.providerLastName.toLowerCase().substring(1)} ${controller.dataList[index].serviceprovidersdatas.providerFirstName[0].toUpperCase()}${controller.dataList[index].serviceprovidersdatas.providerLastName.toLowerCase().substring(1)}',
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
                                          Text(
                                              '${Geolocator.distanceBetween(double.parse(controller.dataList[index].latitude), double.parse(controller.dataList[index].longitude), controller.lat.value, controller.lang.value).truncate()/1000 } Km',
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                          Text('4.6',
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
                                        Text('4',
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
    );
  }
  
}
