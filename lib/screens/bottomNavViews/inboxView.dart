import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';
import 'package:user_side/models/providersData.dart';
import 'package:user_side/screens/chatScreen.dart';
import 'package:user_side/services/apiServices.dart';
import 'package:user_side/stateManagment/providers/chatProvider.dart';
import 'package:user_side/utils/customColors.dart';
import 'package:user_side/widgets/loadingBar.dart';

class InboxView extends StatelessWidget {
  ChatProvider chatProvider;
  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    chatProvider = Provider.of<ChatProvider>(context);
    apiServices.inboxList(chatProvider);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<ChatProvider>(
          builder: (context, items, _) {
            if (items.loadingbar) {
              return Center(child: LoadingBar());
            } else {
              return items.chatList.length == 0
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
                  : Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 0.8,
                            child: ListTile(
                                onTap: () {
                                  Get.to(ChatScreen(
                                      providerId: items.chatList[index].user_2,
                                      providerFname: items
                                          .chatList[index].providerFirstName,
                                      providerLname: items
                                          .chatList[index].providerLastName));
                                },
                                title: Text(
                                  '${items.chatList[index].providerFirstName[0].toUpperCase()}${items.chatList[index].providerFirstName.substring(1).toLowerCase()} ${items.chatList[index].providerLastName[0].toUpperCase()}${items.chatList[index].providerLastName.substring(1).toLowerCase()}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  items.chatList[index].chats.last.message,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: Container(
                                  child: Center(
                                    child: Text(
                                      items.chatList[index].providerFirstName[0]
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ),
                                  height: 60,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: index.isOdd
                                          ? CustomColors.lightGreen
                                          : CustomColors.lightGreen,
                                      shape: BoxShape.circle),
                                )),
                          );
                        },
                        itemCount: items.chatList.length,
                      ),
                    );
            }
          },
        ));
  }
}
