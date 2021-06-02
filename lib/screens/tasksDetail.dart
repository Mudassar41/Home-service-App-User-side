import 'package:flutter/material.dart';
import 'package:user_side/models/tasksModel.dart';
import 'package:user_side/utils/customColors.dart';

class TasksDetail extends StatefulWidget {
  TasksModel tasksModel;

  TasksDetail({this.tasksModel});

  @override
  _TasksDetailState createState() => _TasksDetailState();
}

class _TasksDetailState extends State<TasksDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Task Detail'),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      '',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, right: 20, left: 8, bottom: 8),
                            child: Icon(
                              Icons.person,
                              color: CustomColors.lightGreen,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                  '${widget.tasksModel.serviceprovidersdatas.providerFirstName[0].toUpperCase()}${widget.tasksModel.serviceprovidersdatas.providerFirstName.toLowerCase().substring(1)} ${widget.tasksModel.serviceprovidersdatas.providerLastName[0].toUpperCase()}${widget.tasksModel.serviceprovidersdatas.providerLastName.toLowerCase().substring(1)}')
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, right: 20, left: 8, bottom: 8),
                            child: Icon(
                              Icons.shop_2,
                              color: CustomColors.lightGreen,
                            ),
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Shop Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(widget
                                    .tasksModel.providerprofiles.shopName),
                              ])
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, right: 20, left: 8, bottom: 8),
                            child: Icon(
                              Icons.location_on,
                              color: CustomColors.lightGreen,
                            ),
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Shop Address',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Bosan Road,Multan'),
                              ])
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, right: 20, left: 8, bottom: 8),
                            child: Icon(
                              Icons.work,
                              color: CustomColors.lightGreen,
                            ),
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Job',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                    '${widget.tasksModel.providercategories.providerCatName[0].toUpperCase()}${widget.tasksModel.providercategories.providerCatName.substring(1).toLowerCase()}'),
                              ])
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, right: 20, left: 8, bottom: 8),
                            child: Icon(
                              Icons.view_day,
                              color: CustomColors.lightGreen,
                            ),
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Assigned Task',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(widget.tasksModel.des),
                              ])
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, right: 20, left: 8, bottom: 8),
                            child: Text(
                              'RS',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: CustomColors.lightGreen),
                            ),
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Amount Offered',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(widget.tasksModel.priceOffered),
                              ])
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, right: 20, left: 8, bottom: 8),
                            child: Icon(
                              Icons.timeline,
                              color: CustomColors.lightGreen,
                            ),
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Estimated Time',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('${widget.tasksModel.time} Hrs'),
                              ])
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, right: 20, left: 8, bottom: 8),
                            child: Icon(
                              Icons.table_view,
                              color: CustomColors.lightGreen,
                            ),
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Task Status',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(widget.tasksModel.offerStatus == 'none'
                                    ? "Request sent"
                                    : widget.tasksModel.offerStatus),
                              ])
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 40,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  widget.tasksModel.offerStatus == 'none'
                                      ? "Request sent"
                                      : widget.tasksModel.offerStatus,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            // height: 50,
                            decoration: BoxDecoration(
                                color: CustomColors.lightGreen,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                          ),
                        ),
                        Expanded(
                            flex: 0,
                            child: Container(
                              width: 10,
                            )),
                        Expanded(
                          flex: 3,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              height: 40,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    'Cancel request',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              // height: 50,
                              decoration: BoxDecoration(
                                  color: CustomColors.lightRed,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
