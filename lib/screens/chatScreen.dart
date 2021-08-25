import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_side/models/chatModel.dart';
import 'package:user_side/models/providersData.dart';
import 'package:user_side/services/apiServices.dart';
import 'package:user_side/services/sharedPrefService.dart';
import 'package:user_side/stateManagment/providers/chatProvider.dart';
import 'package:user_side/utils/customColors.dart';
import 'package:user_side/utils/customToast.dart';
import 'package:user_side/widgets/loadingBar.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  //ProvidersData providerData;
  String providerId;
  String providerFname;
  String providerLname;

  ChatScreen({this.providerId, this.providerFname, this.providerLname});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatProvider chatProvider;
  ScrollController scrollController = ScrollController();
  ApiServices apiServices = ApiServices();
  double offsetA = 0.0;
  String currentUserId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  scrollController.addListener(listenScrolling);
  }

  void listenScrolling() {
    if (scrollController.position.atEdge) {
      final isTop = scrollController.position.pixels == 0;

      if (isTop) {
        CustomToast.showToast('Reached Start');
      } else {
        CustomToast.showToast('Reached End');
      }
    }
  }

  @override
  build(BuildContext context) {
    ScrollController statelessControllerA =
        ScrollController(initialScrollOffset: offsetA);
    statelessControllerA.addListener(() {
      setState(() {
        offsetA = statelessControllerA.offset;
      });
    });
    chatProvider = Provider.of<ChatProvider>(context);
    apiServices.chatList(widget.providerId, chatProvider);

    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: (){
      //   chatProvider.scrollDown();
      // },),
      appBar: AppBar(
        title: Text(
            '${widget.providerFname[0].toUpperCase()}${widget.providerFname.substring(1).toLowerCase()} ${widget.providerLname[0].toUpperCase()}${widget.providerLname.substring(1).toLowerCase()}'),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, items, _) {
                if (items.twoWayChat.isNullOrBlank) {
                  return Center(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LoadingBar()));
                } else {
                  return items.twoWayChat.chats.isNullOrBlank
                      ? Center(
                          child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'No Message',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: CustomColors.lightRed),
                          ),
                        ))
                      : SingleChildScrollView(
                          controller: statelessControllerA,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 50),
                            child: Column(
                              children: items.twoWayChat.chats.map((e) {
                                return Align(
                                    alignment: e.recieverId == widget.providerId
                                        ? Alignment.topLeft
                                        : Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: e.recieverId ==
                                                          widget.providerId
                                                      ? CustomColors.lightGreen
                                                      : CustomColors.lightRed,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  e.message,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              '${DateFormat.jm().format(e.timestamp.toDate())}',
                                              style: TextStyle(fontSize: 10),
                                              textAlign: TextAlign.left,
                                            ),
                                          )
                                        ],
                                      ),
                                    ));
                              }).toList(),
                            ),
                          ),
                        );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                //color of shadow
                                spreadRadius: 5,
                                //spread radius
                                blurRadius: 7,
                                // blur radius
                                offset:
                                    Offset(0, 2), // changes position of shadow
                                //first paramerter of offset is left-right
                                //second parameter is top to down
                              )
                            ],
                            color: Colors.white,
                            // border: Border.all(width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),

                        //  height: 50,
                        child: TextField(
                          controller: chatProvider.chatEditTextController,
                          maxLines: 10,
                          minLines: 1,
                          decoration: InputDecoration(
                            //  contentPadding:  EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                            border: InputBorder.none,
                            hintText: "Message ...",
                            hintStyle: TextStyle(
                              color: Colors.black26,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          //color of shadow
                          spreadRadius: 5,
                          //spread radius
                          blurRadius: 7,
                          // blur radius
                          offset: Offset(0, 2), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        )
                      ], color: Colors.white, shape: BoxShape.circle),
                      width: 50,
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            print(offsetA);
                            if (offsetA == 0.0) {
                              if (chatProvider
                                  .chatEditTextController.text.isNotEmpty) {
                                //print("yes");
                                chatProvider.apiServices.snedMessage(
                                    chatProvider.userInfo.userInfo.value,
                                    widget.providerId,
                                    widget.providerFname,
                                    widget.providerLname,
                                    chatProvider.chatEditTextController.text);
                                chatProvider.chatEditTextController.clear();
                              }
                            } else {
                              if (chatProvider
                                  .chatEditTextController.text.isNotEmpty) {
                                statelessControllerA.animateTo(
                                    statelessControllerA
                                        .position.maxScrollExtent,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                                chatProvider.apiServices.snedMessage(
                                    chatProvider.userInfo.userInfo.value,
                                    widget.providerId,
                                    widget.providerFname,
                                    widget.providerLname,
                                    chatProvider.chatEditTextController.text);
                                chatProvider.chatEditTextController.clear();
                              }
                            }
                          },
                          icon: Icon(
                            Icons.send_rounded,
                            color: CustomColors.lightGreen,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
