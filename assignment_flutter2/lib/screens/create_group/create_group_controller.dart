import 'package:assignment_flutter/MessageBox.dart';
import 'package:assignment_flutter/screens/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CreateGroupController extends GetxController{
  TextEditingController groupName = TextEditingController();

  var isLoad = false;
  final box = GetStorage();

  // form validation
  checkForm(){
    if(groupName.text.trim().isEmpty){
      MessageBox.showInSnackBar(Get.context!, 'Please Enter Group Name');
      return false;}return true;}

  // group creation
  createGroup() async{
    isLoad = true;
    update();
    CollectionReference users = FirebaseFirestore.instance.collection('groups');
    Map<String,dynamic> data = {
      'group_name': groupName.text.toString(),
      'memberList': FieldValue.arrayUnion([box.read('email')]),
      'cart' : [],
      'purchased_items' : [],
      'purchased_cost': [],
      'purchased_quantity': []
    };

    users.add(data).then((value) {
      MessageBox.showInSnackBar(Get.context!,'Group Created.');
      isLoad = false;
      update();
      Get.offAll(()=>HomeScreen());
    });
  }
}