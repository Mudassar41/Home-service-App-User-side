import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_side/screens/tasksDetail.dart';
import 'package:user_side/services/apiServices.dart';
import 'package:user_side/stateManagment/providers/tasksProvider.dart';
import 'package:user_side/utils/customColors.dart';
import 'package:user_side/widgets/loadingBar.dart';

class TasksView extends StatefulWidget {
  const TasksView({Key key}) : super(key: key);

  @override
  _TasksViewState createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  TasksProvider tasksProvider;
  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    tasksProvider = Provider.of<TasksProvider>(context);
    apiServices.getTasks(tasksProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TasksProvider>(
          builder: (context, items, _) {
            if (items.tasksList.length == null) {
              return LoadingBar();
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: InkWell(
                        onTap: () {
                          Get.to(
                              TasksDetail(tasksModel: items.tasksList[index]));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/profile.jpg'),
                                  ),
                                  Container(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Text(
                                      '${items.tasksList[index].serviceprovidersdatas.providerFirstName[0].toUpperCase()}${items.tasksList[index].serviceprovidersdatas.providerFirstName.toLowerCase().substring(1)} ${items.tasksList[index].serviceprovidersdatas.providerLastName[0].toUpperCase()}${items.tasksList[index].serviceprovidersdatas.providerLastName.toLowerCase().substring(1)}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${items.tasksList[index].providercategories.providerCatName[0].toUpperCase()}${items.tasksList[index].providercategories.providerCatName.substring(1).toLowerCase()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                  Container(
                                    width: 50,
                                  ),
                                  Text(
                                    '${items.tasksList[index].priceOffered} Rs',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),

                                  //Text(items.tasksList[index].)
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          items.tasksList[index].offerStatus ==
                                                  'none'
                                              ? "Request sent"
                                              : items
                                                  .tasksList[index].offerStatus,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    // height: 50,
                                    decoration: BoxDecoration(
                                        color: CustomColors.lightGreen,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0))),
                                  ),
                                  Container(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'Cancel request',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      // height: 50,
                                      decoration: BoxDecoration(
                                          color: CustomColors.lightRed,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ));
                },
                itemCount: items.tasksList.length,
              );
            }
          },
        ),
      ),
    );
  }
}
