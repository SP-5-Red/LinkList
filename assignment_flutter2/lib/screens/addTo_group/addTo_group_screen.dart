import 'package:assignment_flutter/screens/addTo_group/addTo_group_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assignment_flutter/screens/user_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToGroupScreen extends StatelessWidget {
  final dynamic groupName;
  final dynamic docAccess;
  const AddToGroupScreen({Key? key, required this.groupName, required this.docAccess}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddToGroupController>(
        init: AddToGroupController(),
        builder: (member) =>
            Scaffold(
                backgroundColor: UserColors.getColor(0),
                appBar: AppBar(
                  backgroundColor: UserColors.getColor(1),
                  centerTitle: true,
                  title: Text('MEMBERS'),
                  automaticallyImplyLeading: true,
                ),
                body: SafeArea(
                  child : SingleChildScrollView (
                  child : Column (
                      children: [
                    Center( child: Column (
                    children: [
                      SizedBox(height: Get.height  * 0.05,),
                      Text('Invite New Member',style: TextStyle(color: UserColors.getColor(1),fontSize: Get.height * 0.03)),
                      SizedBox(height: Get.height  * 0.05,),
                      SizedBox(width: Get.width - (Get.width * 0.2), child: TextField(
                        controller: member.email,
                        decoration: const InputDecoration(
                            border:  OutlineInputBorder( //Outline border type for TextField
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                  width: 3,
                                )
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Email'
                        ),),),


                      SizedBox(height: Get.height  * 0.03,),

                      member.isLoad ? Center(child:CircularProgressIndicator(color: UserColors.getColor(1),)) : ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: UserColors.getColor(1),padding: EdgeInsets.all(15)),
                        onPressed: () async{
                          FocusManager.instance.primaryFocus?.unfocus();

                          if(await member.checkForm(docAccess)){
                            member.addToGroup(groupName, docAccess);
                          }

                        },child: Text('SEND INVITE'),),
                      SizedBox(height: Get.height  * 0.09,),
                      Text('Current Members',style: TextStyle(color: UserColors.getColor(1),fontSize: Get.height * 0.035, decoration: TextDecoration.underline),),
                      SizedBox(height: Get.height  * 0.01,),
                      Container (
                          height: Get.height * 0.5,
                          color: UserColors.getColor(0),
                          padding: EdgeInsets.all(15.0),
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance.collection('groups').doc(docAccess).snapshots(),
                              builder: (_, snapshot) {
                                if (snapshot.hasData) {
                                  List memberList = (snapshot.data!.data()!['memberList'] as List).map((member) => member).toList();
                                  return ListView.builder(
                                    itemCount: memberList.length,
                                    itemBuilder: (context, index) {
                                      return   Container(
                                          color: UserColors.getColor(2),child:InkWell(child:
                                      Row(
                                          children: [
                                        Container(
                                          color: UserColors.getColor(2),
                                          padding: EdgeInsets.all(15.0),
                                          child: Text(
                                            memberList[index],style: TextStyle(color: Colors.black,fontSize: Get.height * 0.02),
                                          ),
                                        ),
                                      ])));
                                    },
                                  );
                                } else {

                                  return Container(child: Text('No Group Found',style: TextStyle(color: Colors.black,fontSize: Get.height * 0.02)),);
                                }
                              })
                      )
                    ],
                  ),),
                      ] ),
                ))));
  }
}
