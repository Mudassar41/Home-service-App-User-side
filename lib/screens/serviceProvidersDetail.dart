import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:user_side/animations/alertDialogAnimation.dart';
import 'package:user_side/models/providersData.dart';
import 'package:user_side/stateManagment/providers/chatProvider.dart';
import 'package:user_side/utils/customColors.dart';

import 'chatScreen.dart';
import 'createOffer.dart';

class ServiceProvidersDetailScreen extends StatelessWidget {
  ProvidersData data;

  ServiceProvidersDetailScreen({this.data});

  ChatProvider chatController;

  @override
  Widget build(BuildContext context) {
    // print(data.serviceprovidersdatas.id);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Service Provider Detail',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: data.shopImage,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 250,
                        // width: Screensize.widthMultiplier * 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Center(child: Icon(Icons.error)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: Center(
                          child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          data.serviceprovidersdatas.imageLink),
                                      fit: BoxFit.cover)))),
                    ),
                  ],
                ),
                Text(
                  '${data.serviceprovidersdatas.providerFirstName[0].toUpperCase()}${data.serviceprovidersdatas.providerFirstName.toLowerCase().substring(1)} ${data.serviceprovidersdatas.providerLastName[0].toUpperCase()}${data.serviceprovidersdatas.providerLastName.toLowerCase().substring(1)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data.address,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54)),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '0${data.serviceprovidersdatas.providerPhoneNumber.substring(3)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: CustomColors.creame),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Jobs', style: TextStyle(color: Colors.black54)),
                          Text(
                            '${data.offerscollections.length}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Rating',
                              style: TextStyle(color: Colors.black54)),
                          Text(
                            (data.offerscollections.fold(
                                            0,
                                            (sum, element) =>
                                                sum + element.userRating) /
                                        data.offerscollections.length)
                                    .isNaN
                                ? '0.0'
                                : '${data.offerscollections.fold(0, (sum, element) => sum + element.userRating) / data.offerscollections.length}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Reviews',
                              style: TextStyle(color: Colors.black54)),
                          Text(
                            getCount().toString() == '0'
                                ? "0"
                                : getCount().toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                        color: CustomColors.lightGreen,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.phone,
                                  color: CustomColors.creame,
                                ),
                                onPressed: () {
                                  FlutterPhoneDirectCaller.callNumber(data
                                      .serviceprovidersdatas
                                      .providerPhoneNumber);
                                }),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  minimumSize: Size(110, 48),
                                  primary: CustomColors.lightRed),
                              onPressed: () {
                                // openDialogForOffer(context);
                                Get.to(CreateOfferScreen(providerInfo: data));
                              },
                              child: Text(
                                "Send Offer",
                                style: TextStyle(color: CustomColors.creame),
                              ),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.message,
                                  color: CustomColors.creame,
                                ),
                                onPressed: () {
                                  Get.to(ChatScreen(
                                      providerId: data.serviceprovidersdatas.id,
                                      providerFname: data.serviceprovidersdatas
                                          .providerFirstName,
                                      providerLname: data.serviceprovidersdatas
                                          .providerLastName));
                                })
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //     children: [
                      //       Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Text(
                      //             'From',
                      //             style: TextStyle(fontWeight: FontWeight.bold),
                      //           ),
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             children: [
                      //               Text(data.whFromTime,
                      //                   style:
                      //                       TextStyle(color: Colors.black54)),
                      //               Text(data.whFromTimeType,
                      //                   style:
                      //                       TextStyle(color: Colors.black54)),
                      //             ],
                      //           )
                      //         ],
                      //       ),
                      //       Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Text(
                      //             'To',
                      //             style: TextStyle(fontWeight: FontWeight.bold),
                      //           ),
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               Text(data.whToTime,
                      //                   style:
                      //                       TextStyle(color: Colors.black54)),
                      //               Text(data.whToTimeType,
                      //                   style:
                      //                       TextStyle(color: Colors.black54)),
                      //             ],
                      //           )
                      //         ],
                      //       ),
                      //       Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Text(
                      //             'Working Days',
                      //             style: TextStyle(fontWeight: FontWeight.bold),
                      //           ),
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               Text('${data.wsFrom}-',
                      //                   style:
                      //                       TextStyle(color: Colors.black54)),
                      //               Text(data.wsTo,
                      //                   style:
                      //                       TextStyle(color: Colors.black54)),
                      //             ],
                      //           )
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 5,
                      ),
                      data.offerscollections.length <= 0
                          ? Text('')
                          : Text(
                              "Reviews",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                    ],
                  ),
                ),
                ListView.builder(
                    itemCount: data.offerscollections.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              data.offerscollections[index].userReview ==
                                          'no' &&
                                      data.offerscollections[index]
                                              .userRating <=
                                          0.0
                                  ? Container(
                                      height: 0,
                                      width: 0,
                                    )
                                  : CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(data
                                          .offerscollections[index]
                                          .usersregistrationprofiles
                                          .userImage),
                                    ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ' ${data.offerscollections[index].usersregistrationprofiles.firstName[0].toUpperCase()}${data.offerscollections[index].usersregistrationprofiles.firstName.toLowerCase().substring(1)} ${data.offerscollections[index].usersregistrationprofiles.lastName[0].toUpperCase()}${data.offerscollections[index].usersregistrationprofiles.lastName.toLowerCase().substring(1)}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45),
                                    ),
                                    data.offerscollections[index].userRating <=
                                            0.0
                                        ? Container(
                                            height: 0,
                                            width: 0,
                                          )
                                        : Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              RatingBarIndicator(
                                                rating: data
                                                    .offerscollections[index]
                                                    .userRating,
                                                itemBuilder: (context, index) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: 20.0,
                                                direction: Axis.horizontal,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 2),
                                                child: Text(
                                                  '  ${data.offerscollections[index].userRating}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: data.offerscollections[index]
                                                  .userReview ==
                                              'no'
                                          ? Container(
                                              height: 8,
                                              width: 0,
                                            )
                                          : Text(
                                              data.offerscollections[index]
                                                  .userReview,
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int getCount() {
    int reviewCount = 0;
    for (int i = 0; i < data.offerscollections.length; i++) {
      if (data.offerscollections[i].userReview != 'no') {
        reviewCount++;
        print("yes");
      }
    }
    return reviewCount;
  }
}
