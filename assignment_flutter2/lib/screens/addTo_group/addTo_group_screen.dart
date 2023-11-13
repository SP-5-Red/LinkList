import 'package:assignment_flutter/screens/addTo_group/addTo_group_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.green,
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
                      Text('Invite New Member',style: TextStyle(color: Colors.green,fontSize: Get.height * 0.03)),
                      SizedBox(height: Get.height  * 0.05,),
                      SizedBox(width: Get.width - (Get.width * 0.2), child: TextField(
                        controller: member.email,
                        decoration: const InputDecoration(
                            border:  OutlineInputBorder( //Outline border type for TextField
                                borderSide: BorderSide(
                                  color:Colors.redAccent,
                                  width: 3,
                                )
                            ),
                            labelText: 'Email'
                        ),),),


                      SizedBox(height: Get.height  * 0.03,),

                      member.isLoad ? const Center(child:CircularProgressIndicator(color: Colors.green,)) : ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green,padding: EdgeInsets.all(15)),
                        onPressed: () async{
                          FocusManager.instance.primaryFocus?.unfocus();

                          if(await member.checkForm(docAccess)){
                            member.addToGroup(groupName, docAccess);
                          }

                        },child: Text('SEND INVITE'),),
                      SizedBox(height: Get.height  * 0.09,),
                      Text('Current Members',style: TextStyle(color: Colors.green,fontSize: Get.height * 0.035, decoration: TextDecoration.underline),),
                      SizedBox(height: Get.height  * 0.01,),
                      Container (
                          height: Get.height * 0.5,
                          color: Colors.white,
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
                                          color: Colors.green.shade50,child:InkWell(child:
                                      Row(
                                          children: [
                                        Container(
                                          color: Colors.green.shade50,
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
