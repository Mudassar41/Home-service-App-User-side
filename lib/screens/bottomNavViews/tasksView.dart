
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            if (items.isLoading) {
              return Center(child: LoadingBar());
            } else {
              return items.tasksList.length == 0
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/no.svg',
                          height: 100,
                          width: 150,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'No bookings found',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: CustomColors.lightRed),
                          ),
                        ),
                      ],
                    ))
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: InkWell(
                              onTap: () {
                                Get.to(TasksDetail(
                                    tasksModel: items.tasksList[index]));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(items
                                              .tasksList[index]
                                              .serviceprovidersdatas
                                              .imageLink),
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
                                    if (items.tasksList[index].offerStatus ==
                                        'none')
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              String taskId =
                                                  items.tasksList[index].id;
                                              String response =
                                                  await apiServices.updateTask(
                                                      taskId, 'accepted');
                                              if (response == 'data updated') {
                                                print('Updated');
                                              } else {
                                                print('Not Updated');
                                              }
                                            },
                                            child: Container(
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    'offer sent',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              // height: 50,
                                              decoration: BoxDecoration(
                                                  color: CustomColors
                                                      .lightGreen,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
                                            ),
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              String taskId =
                                                  items.tasksList[index].id;
                                              String response =
                                                  await apiServices.updateTask(
                                                      taskId, 'cancel');
                                              if (response == 'data updated') {
                                                
                                                print('Updated');
                                              } else {
                                                print('Not Updated');
                                              }
                                            },
                                            child: Container(
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    'Cancel offer',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              // height: 50,
                                              decoration: BoxDecoration(
                                                  color: CustomColors.lightRed,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
                                            ),
                                          )
                                        ],
                                      )
                                    else if (items
                                            .tasksList[index].offerStatus ==
                                        'accepted')
                                      Row(
                                        children: [
                                          Container(
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  'Active',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            // height: 50,
                                            decoration: BoxDecoration(
                                                color: CustomColors.lightGreen,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                          ),
                                        ],
                                      )
                                    else if (items
                                            .tasksList[index].offerStatus ==
                                        'cancel')
                                      Row(
                                        children: [
                                          Container(
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  'Offer cancelled',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            // height: 50,
                                            decoration: BoxDecoration(
                                                color: CustomColors.lightRed,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                          )
                                        ],
                                      )
                                    else if (items
                                            .tasksList[index].offerStatus ==
                                        'completed')
                                      Row(
                                        children: [
                                          Container(
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  'Completed',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            // height: 50,
                                            decoration: BoxDecoration(
                                                color: CustomColors.lightGreen,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                          ),
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
