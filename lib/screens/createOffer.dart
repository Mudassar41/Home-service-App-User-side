import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_side/stateManagment/controllers/createOfferController.dart';

class CreateOfferScreen extends StatelessWidget {
  final OfferController controller = Get.put(OfferController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Column(
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
                      Expanded(flex: 3, child: Text('Estimated Time (Hs)')),
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
              ],
            ),
          ),
         
        ],
      ),
    );
  }
}
