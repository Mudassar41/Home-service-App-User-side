import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:user_side/models/providersData.dart';
import 'package:user_side/services/apiServices.dart';
import 'package:user_side/stateManagment/controllers/createOfferController.dart';
import 'package:user_side/stateManagment/controllers/serviceProvidersController.dart';
import 'package:user_side/utils/customColors.dart';
import 'package:user_side/utils/customToast.dart';
import 'package:user_side/utils/snackBar.dart';

class CreateOfferScreen extends StatelessWidget {
  ProvidersData providerInfo;

  CreateOfferScreen({this.providerInfo});

  final OfferController controller = Get.put(OfferController());
  final ServiceProviderController serviceProviderController = Get.find();
  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    controller.progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create Offer',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Obx(
              () => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(flex: 3, child: Text('Estimated Time (Hrs)')),
                        Expanded(
                          flex: 1,
                          child: DropdownButtonFormField(
                            onSaved: (value) {
                              // profileModel.wsFrom = value;
                            },
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Field Required';
                              }
                              return null;
                            },
                            isExpanded: true,
                            hint: Text('select '),
                            icon: Icon(Icons.arrow_drop_down_sharp),
                            onChanged: (val) {
                              controller.time.value = val;
                            },
                            items: controller.list.map((element) {
                              return DropdownMenuItem(
                                  value: element, child: Text(element));
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(flex: 3, child: Text("Offer Amount")),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: controller.priceEditController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(hintText: '0 Rs'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: controller.addressController,
                          maxLines: 4,
                          decoration: InputDecoration.collapsed(
                            hintText: "Address Detail",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: controller.desEditController,
                          maxLines: 8,
                          decoration: InputDecoration.collapsed(
                            hintText: "Write some description here..",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            minimumSize: Size(100, 40),
                            primary: CustomColors.lightRed),
                        onPressed: () async {
                          if (controller.time == '0') {
                            CustomSnackBar.showSnackBar(
                                'Pick select Duration', context);
                          } else if (controller.priceEditController == '') {
                            CustomSnackBar.showSnackBar(
                                'Price can\'t be empty', context);
                          } else if (controller.desEditController == '') {
                            CustomSnackBar.showSnackBar(
                                'Write some description of work ', context);
                          } else {
                            String response;
                            response =
                                await apiServices.sendOfferToServiceProvider(
                                    providerInfo,
                                    controller.progressDialog,
                                    serviceProviderController,
                                    controller.priceEditController.text,
                                    controller.desEditController.text,
                                    controller.addressController.text,
                                    controller.time.value);
                            if (response == 'Offer Sent') {
                              controller.priceEditController.clear();
                              controller.desEditController.clear();
                              controller.addressController.clear();
                              FocusScope.of(context).unfocus();
                              Navigator.pop(context);
                              CustomToast.showToast(response);
                            } else {
                              CustomToast.showToast(response);
                            }
                          }
                        },
                        child: Text('Send Offer')),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
