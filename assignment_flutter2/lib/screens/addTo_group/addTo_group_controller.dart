import 'package:assignment_flutter/MessageBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AddToGroupController extends GetxController{
  TextEditingController email = TextEditingController();
  var isLoad = false;
  final box = GetStorage();

  // form validation
  checkForm(docAccess) async{
    //Checks if input is valid
    if(email.text.trim().isEmpty || !email.text.trim().toString().contains("@")){
      MessageBox.showInSnackBar(Get.context!, 'Please Enter Valid Email');
      return false;
    }

    //Checks if user exists
    QuerySnapshot q = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email.text.trim().toString()).get();
    if(q.docs.length == 0){
      MessageBox.showInSnackBar(Get.context!, 'Please Enter A Registered Email');
      return false;
    }

    //Checks if member is in group
    DocumentSnapshot d = await FirebaseFirestore.instance.collection('groups').doc(docAccess).get();
    List currentMembers = (d.get('memberList') as List).map((member) => member).toList();
    if(currentMembers.contains(email.text.trim().toString())) {
      MessageBox.showInSnackBar(Get.context!, 'Member already in group');
      return false;
    }

    return true;
  }

  // group creation
  addToGroup(groupName, groupID) async{
    isLoad = true;
    update();
    CollectionReference invites = FirebaseFirestore.instance.collection('invites');
    QuerySnapshot user = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: box.read('email')).get();
    Map<String,dynamic> data = {
      'toUser': email.text.trim().toString(),
      'fromUser': user.docs.elementAt(0).get('username'),
      'group_name': groupName,
      'groupID': groupID,
      'expires': Timestamp.fromDate(DateTime.now().add(const Duration(days: 30)))
    };

    invites.add(data).then((value) {
      MessageBox.showInSnackBar(Get.context!,'Sent Invite.');
      isLoad = false;
      update();
    });
  }
}