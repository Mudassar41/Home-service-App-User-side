import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_side/animations/alertDialogAnimation.dart';
import 'package:user_side/models/providersData.dart';
import 'package:user_side/utils/customColors.dart';

import 'createOffer.dart';

class ServiceProvidersDetailScreen extends StatelessWidget {
  ProvidersData data;
  ServiceProvidersDetailScreen({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      height: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'http://192.168.43.31:4000/${data.shopImage}'),
                              fit: BoxFit.cover))),
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
                                    image:
                                        AssetImage('assets/images/profile.jpg'),
                                    fit: BoxFit.cover)))),
                  )
                ],
              ),
              Text(
                '${data.serviceprovidersdatas.providerFirstName[0].toUpperCase()}${data.serviceprovidersdatas.providerLastName.toLowerCase().substring(1)} ${data.serviceprovidersdatas.providerFirstName[0].toUpperCase()}${data.serviceprovidersdatas.providerLastName.toLowerCase().substring(1)}',
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
              Text(data.address),
              SizedBox(
                height: 5,
              ),
              Card(
                elevation: 5,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.phone,
                              color: CustomColors.lightRed,
                            ),
                            onPressed: () {}),
                        OutlinedButton(
                          onPressed: () {
                            // openDialogForOffer(context);
                            Get.to(CreateOfferScreen());
                          },
                          child: Text(
                            "Send Offer",
                            style: TextStyle(color: CustomColors.lightGreen),
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.message,
                              color: CustomColors.lightGreen,
                            ),
                            onPressed: () {})
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Availability",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54),
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
                              Text(
                                'From',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(data.whFromTime,
                                      style: TextStyle(color: Colors.black54)),
                                  Text(data.whFromTimeType,
                                      style: TextStyle(color: Colors.black54)),
                                ],
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'To',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(data.whToTime,
                                      style: TextStyle(color: Colors.black54)),
                                  Text(data.whToTimeType,
                                      style: TextStyle(color: Colors.black54)),
                                ],
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Week-Days',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${data.wsFrom}-',
                                      style: TextStyle(color: Colors.black54)),
                                  Text(data.wsTo,
                                      style: TextStyle(color: Colors.black54)),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Statistics",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54),
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
                              Text(
                                'Jobs',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('4',
                                  style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Rating',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('4.6',
                                  style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Reviews',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('3',
                                  style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Users Reviews",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/images/profile.jpg'),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Text(
                                  'I would highly recommend this seller to anybody looking for a clean job. He does an amazing work, very communicative and very responsive. I am looking forward to work with him again.'),
                            ),
                            Row(
                              children: [
                                for (int i = 0; i < 4; i++)
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/images/profile.jpg'),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Text(
                                  'I would highly recommend this seller to anybody looking for a clean job. He does an amazing work, very communicative and very responsive. I am looking forward to work with him again.'),
                            ),
                            Row(
                              children: [
                                for (int i = 0; i < 4; i++)
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> openDialogForOffer(BuildContext context) async {
  //   showGeneralDialog(
  //       context: context,
  //       pageBuilder: (context, anim1, anim2) {},
  //       barrierDismissible: false,
  //       barrierColor: Colors.black.withOpacity(0.4),
  //       barrierLabel: '',
  //       transitionBuilder: (context, anim1, anim2, child) {
  //         return Transform.scale(
  //             scale: anim1.value,
  //             child: AlertDialog(
  //               title: Text('Create Offer'),
  //               content: SingleChildScrollView(
  //                 child: ListBody(
  //                   children: <Widget>[
  //                     Text('Create Offer'),
  //                     Text('Would you like to approve of this message?'),
  //                   ],
  //                 ),
  //               ),
  //               actions: <Widget>[
  //                 TextButton(
  //                   child: Text('Cancel'),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             ));
  //       },
  //       transitionDuration: Duration(milliseconds: 200));
  // }
}
