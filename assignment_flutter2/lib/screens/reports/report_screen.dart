import 'package:assignment_flutter/screens/reports/report_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportScreen extends StatelessWidget {
  final dynamic docAccess;
  const ReportScreen({Key? key, required this.docAccess}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportController>(
        init: ReportController(),
        builder: (cart)=>Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.green,
              centerTitle: true,
              title: Text('EXPENSE REPORT'),automaticallyImplyLeading: true,
              actions: [
                GestureDetector(
                  onTap: (){
                    cart.setItemLists(docAccess);
                  },
                  child: Icon(Icons.add,color: Colors.white,),
                ),
                SizedBox(width: 15,),
              ],

            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Center (
                    child: Column (
                      children: [
                        SizedBox(height: Get.height  * 0.03,),
                        Row(children: [
                          SizedBox(width: Get.width  * 0.1,),
                          Text('Item',style: TextStyle(color: Colors.black,fontSize: Get.height * 0.02,)),
                            SizedBox(width: Get.width  * 0.18,),
                          Text('Cost Per',style: TextStyle(color: Colors.black,fontSize: Get.height * 0.02,)),
                          ],),
                        SizedBox(height: Get.height  * 0.01,),
                        Container(color: Colors.black,
                        width: Get.width - Get.width * 0.1,
                        height: 1,),
                        Container(
                            height: Get.height * 0.7,
                            color: Colors.white,
                            padding: EdgeInsets.only(left:12.5, top: 5.0, right: 12.5, bottom: 5.0),
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance.collection('groups').doc(docAccess).snapshots(),
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    List groupPrice = snapshot.data!.data()!['purchased_cost'];
                                    List groupAmounts = snapshot.data!.data()!['purchased_quantity'];
                                    List groupItems = snapshot.data!.data()!['purchased_items'];

                                    groupItems.forEach((element) {
                                      cart.priceControllers.add(TextEditingController());
                                      cart.amountControllers.add(TextEditingController());
                                    });

                                    return ListView.builder(
                                      itemCount: groupItems.length,
                                      itemBuilder: (context, index) {
                                        return   Container(
                                            child:InkWell(child:
                                        Column(
                                            children: [
                                              Row(children: [
                                                Container(
                                                  padding: EdgeInsets.only(left:12.5, top: 5.0, right: 12.5, bottom: 0.0),
                                                  child: Text(
                                                    cart.formatReportString(groupItems[index], cart.getPrice(groupPrice, groupAmounts, index), 0),style: TextStyle(color: Colors.black,fontSize: cart.getFontSize("item")),
                                                  ),
                                                ),
                                                SizedBox(width: Get.width - cart.getStringWidth(cart.formatReportString(groupItems[index], groupPrice[index], 0), 0) - (Get.width * 0.2) - 85),
                                                Column(
                                                  children: [
                                                    SizedBox(width: (Get.width * 0.2),height: 25,
                                                      child: TextField(
                                                        controller: cart.priceControllers[index],
                                                        decoration: const InputDecoration(
                                                            border:  OutlineInputBorder( //Outline border type for TextField
                                                                borderSide: BorderSide(
                                                                  color:Colors.redAccent,
                                                                  width: 3,
                                                                )
                                                            ),
                                                            labelText: 'Total'
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5,),
                                                    SizedBox(width: (Get.width * 0.2),height: 25,
                                                      child: TextField(
                                                        controller: cart.amountControllers[index],
                                                        decoration: const InputDecoration(
                                                            border:  OutlineInputBorder( //Outline border type for TextField
                                                                borderSide: BorderSide(
                                                                  color:Colors.redAccent,
                                                                  width: 3,
                                                                )
                                                            ),
                                                            labelText: 'Quantity'
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],),
                                              Row(children: [
                                                Container(
                                                  padding: EdgeInsets.only(left:50, top: 0.0, right: 12.5, bottom: 5.0),
                                                  child: Text(
                                                    cart.formatReportString("Quantity", groupAmounts[index], 1),style: TextStyle(color: Colors.black,fontSize: cart.getFontSize("subnote")),
                                                  ),
                                                ),
                                              ],),
                                              SizedBox (height: Get.height * 0.05,),
                                              // Row(children: [
                                              //   Container(
                                              //     padding: EdgeInsets.only(left:50, top: 5.0, right: 12.5, bottom: 5.0),
                                              //     child: Text(
                                              //       cart.formatReportString("API 1", 5.0, 1),style: TextStyle(color: Colors.black,fontSize: cart.getFontSize("API")),
                                              //     ),
                                              //   ),],),
                                              // Row(children: [
                                              //   Container(
                                              //     padding: EdgeInsets.only(left:50, top: 5.0, right: 12.5, bottom: 5.0),
                                              //     child: Text(
                                              //       cart.formatReportString("API 2", 4.0, 1),style: TextStyle(color: Colors.black,fontSize: cart.getFontSize("API")),
                                              //     ),
                                              //   ),],),
                                              // Row(children: [
                                              //   Container(
                                              //     padding: EdgeInsets.only(left:50, top: 5.0, right: 12.5, bottom: 5.0),
                                              //     child: Text(
                                              //       cart.formatReportString("API 3", 2.0, 1),style: TextStyle(color: Colors.black,fontSize: cart.getFontSize("API")),
                                              //     ),
                                              //   ),],),
                                            ])));
                                      },
                                    );
                                  } else {

                                    return Container(child: Text('No Items Found',style: TextStyle(color: Colors.black,fontSize: Get.height * 0.02)),);
                                  }
                                })
                        ),
                        Container(color: Colors.black,
                          width: Get.width - Get.width * 0.1,
                          height: 1,),
                        SizedBox(height: Get.height  * 0.01,),
                        Row(children: [
                          Column(children: [
                            SizedBox(height: Get.height * 0.01),
                            //TODO Implement APIs and estimations
                          //   Row(children: [
                          //     SizedBox(width: Get.width  * 0.1,),
                          //   Text(cart.formatReportString("Estimated Total", 1000, 3),style: TextStyle(color: Colors.black,fontSize: cart.getFontSize("footer"),)),
                          // ],),
                            Row(children: [
                              SizedBox(width: Get.width  * 0.13,),
                              Text(cart.formatReportString("Total", cart.getPurchasedTotal(), 2),style: TextStyle(color: Colors.black,fontSize: cart.getFontSize("footer"),)),
                            ],),
                          ],)],)
                        ]))
        ))));
  }
}
