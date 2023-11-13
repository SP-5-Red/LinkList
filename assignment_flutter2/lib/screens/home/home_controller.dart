import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../MessageBox.dart';

class HomeController extends GetxController{

  final box = GetStorage();

  //Checks if invite is expired and removes it
  bool isExpired(Timestamp t) {
    return DateTime.now().toUtc().isAfter(
      DateTime.fromMillisecondsSinceEpoch(
        t.millisecondsSinceEpoch,
        isUtc: false,
      ).toUtc(),
    );
  }

  removeInv(inviteID) {
    FirebaseFirestore.instance.collection('invites').doc(inviteID).delete();
  }

  //Accept Invite
  acceptInv(currentUser, inviteID, groupName, groupID) {
    update();
    CollectionReference groups = FirebaseFirestore.instance.collection('groups');
    Map<String,dynamic> data = {
      'group_name': groupName,
      'memberList': FieldValue.arrayUnion([currentUser])
    };

    groups.doc(groupID).update(data).then((value) {
      MessageBox.showInSnackBar(Get.context!,'Invite Accepted');
      update();
    });

    FirebaseFirestore.instance.collection('invites').doc(inviteID).delete();
  }

  //Decline Invite
  declineInv(inviteID) {
    MessageBox.showInSnackBar(Get.context!, 'Invite Declined');
    FirebaseFirestore.instance.collection('invites').doc(inviteID).delete();
  }

  // leave group function
  leaveGroup(doc,name){
    Get.back();
    CollectionReference groups = FirebaseFirestore.instance.collection('groups');

    Map<String,dynamic> data = {
      'group_name':name,
      'memberList':FieldValue.arrayRemove([box.read('email')]),
    };

    groups.doc(doc).set(data).then((value) async{
      MessageBox.showInSnackBar(Get.context!,'You Left $name.');

      DocumentSnapshot tmpReference = await groups.doc(doc).get();
      if ((tmpReference.get('memberList') as List).length == 0) {
        groups.doc(doc).delete();
      }
    }).catchError((err)=>print(err));
  }

}

