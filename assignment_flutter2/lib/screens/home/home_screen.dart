import 'package:assignment_flutter/screens/create_group/create_group_screen.dart';
import 'package:assignment_flutter/screens/addTo_group/addTo_group_screen.dart';
import 'package:assignment_flutter/screens/customization/customization_screen.dart';
import 'package:assignment_flutter/screens/home/home_controller.dart';
import 'package:assignment_flutter/screens/setting/setting_screen.dart';
import 'package:assignment_flutter/screens/user_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../cart/cart.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (home)=>Scaffold(
        backgroundColor: UserColors.getColor(0),
        appBar: AppBar(
          leading: GestureDetector(
            onTap: (){
              Get.to(()=>CustomizationScreen());
            },
            child: Icon(Icons.account_tree_outlined,color: Colors.white,),
          ),
          backgroundColor: UserColors.getColor(1),
          centerTitle: true,
          title: Text('LINKLIST'),automaticallyImplyLeading: true,
          actions: [
            GestureDetector(
              onTap: (){
                Get.to(()=>CreateGroupScreen());
              },
              child: Icon(Icons.add_circle,color: Colors.white,),
            ),
            SizedBox(width: 15,),

            GestureDetector(
              onTap: (){
                Get.to(()=>SettingScreen());
              },
              child: Icon(Icons.settings,color: Colors.white),
            ),
            SizedBox(width: 15,)
          ],

        ),
        body: SafeArea(
          child: SingleChildScrollView (
            child: Column (
          children: [
            SizedBox(height: Get.height  * 0.03,),
            Text('Groups',style: TextStyle(color: UserColors.getColor(1),fontSize: Get.height * 0.035, decoration: TextDecoration.underline),),
            SizedBox(height: Get.height  * 0.01,),
            Container(color: UserColors.getColor(0),
              padding: EdgeInsets.all(15.0),
                height: Get.height * 0.4,
              // get all groups
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('groups').where('memberList',arrayContains: home.box.read('email')).snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return   Container(
                              color: UserColors.getColor(2),child:InkWell(child:
                          Row(children: [
                            Container(
                              color: UserColors.getColor(2),
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                snapshot.data!.docs[index].get('group_name'),style: TextStyle(color: Colors.black,fontSize: Get.height * 0.02),
                              ),
                            ),
                            Spacer(),
                            PopupMenuButton<int>(
                                itemBuilder: (context) => [
                                  // popupmenu item 1
                                   PopupMenuItem(
                                    value: 1,
                                    // row has two child icon and text.
                                    child: InkWell(
                                      onTap: (){
                                        Get.to(()=>AddToGroupScreen(docAccess: snapshot.data!.docs[index].id, groupName: snapshot.data!.docs[index].get('group_name')));
                                      },
                                      child: const Text('Members'),
                                    ),
                                  ),
                                  PopupMenuItem( value: 2, child: const Text("Open Cart"), onTap: () {  Get.to(() => Cart( docID: snapshot.data! .docs[index].id)); }, ),
                                  // popupmenu item 2
                                  PopupMenuItem(
                                      value: 3,
                                      // row has two child icon and text.
                                      child: InkWell(
                                        onTap: (){
                                          home.leaveGroup(snapshot.data!.docs[index].id,snapshot.data!.docs[index].get('group_name'));
                                        },
                                        child: const Text('Leave Group'),
                                      )),
                                  ]),
                          ])));
                        },
                      );
                    } else {

                      return Container(child: Text('No Group Found',style: TextStyle(color: Colors.black,fontSize: Get.height * 0.02)),);
                    }
                  })),
            SizedBox(height: Get.height  * 0.04,),
            Text('Invites',style: TextStyle(color: UserColors.getColor(1),fontSize: Get.height * 0.035, decoration: TextDecoration.underline),),
            SizedBox(height: Get.height  * 0.01,),
            Container(color: UserColors.getColor(0),
                padding: EdgeInsets.all(15.0),
                height: Get.height * 0.3,
                // get all groups
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('invites').where('toUser',isEqualTo: home.box.read('email').toString()).snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            if(home.isExpired(snapshot.data!.docs[index].get('expires'))) {
                              home.removeInv(snapshot.data!.docs[index].id);
                              return Container(child: Text('Invite Expired',style: TextStyle(color: Colors.black,fontSize: Get.height * 0.02)),);
                            }
                            return   Container(
                                color: UserColors.getColor(2),child:InkWell(child:
                            Row(children: [
                              Container(
                                color: UserColors.getColor(2),
                                padding: EdgeInsets.all(15.0),
                                width: Get.width - (Get.width * 0.2),
                                child: Text(
                                    (snapshot.data!.docs[index].get('group_name') + "\nFrom: " + (snapshot.data!.docs[index].get('fromUser'))),style: TextStyle(color: Colors.black,fontSize: Get.height * 0.02),
                                ),
                              ),
                              Spacer(),
                              PopupMenuButton<int>(
                                  itemBuilder: (context) => [
                                    // popupmenu item 1
                                    PopupMenuItem(
                                      value: 1,
                                      // row has two child icon and text.
                                      child: InkWell(
                                        onTap: (){
                                          home.acceptInv(snapshot.data!.docs[index].get('toUser'), snapshot.data!.docs[index].id, snapshot.data!.docs[index].get('group_name'), snapshot.data!.docs[index].get('groupID'));
                                        },
                                        child: const Text('Accept'),
                                      ),
                                    ),
                                    // popupmenu item 2
                                    PopupMenuItem(
                                        value: 2,
                                        // row has two child icon and text.
                                        child: InkWell(
                                          onTap: (){
                                            home.declineInv(snapshot.data!.docs[index].id);
                                          },
                                          child: const Text('Decline'),
                                        )),]),
                            ])));
                          },
                        );
                      } else {
                        return Container(child: Text('No Invites Found',style: TextStyle(color: Colors.black,fontSize: Get.height * 0.02)),);
                      }
                    })),
          ],

        )))
    ));
  }
}
