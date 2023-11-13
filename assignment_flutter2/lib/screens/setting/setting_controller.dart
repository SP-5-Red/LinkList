import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../MessageBox.dart';
import '../launch/launch_screen.dart';

class SettingController extends GetxController{

  var isLoad = true;
  final box = GetStorage();
  bool isEmailVerified = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
var docID;
// get profile function
  getProfile() async{
    print(box.read('email'));
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email',isEqualTo:box.read('email'))
        .get();


    for (var doc in querySnapshot.docs) {
      print(doc['phone']);
      docID = doc.id;
      firstNameController.text = doc['first_name'] ?? '';
      lastNameController.text = doc['last_name'] ?? '';
      userNameController.text = doc['username'] ?? '';
      emailController.text = doc['email'] ?? '';
      box.write('email', doc['email']);
      box.write('username', doc['username']);
      phoneController.text = doc['phone'] ?? '';
      isLoad = false;
    update();
    }
  }
  Timer? timer;
  // log out user
  logoutUser(){
    FirebaseAuth.instance.signOut();
    box.erase();
    Get.offAll(()=>LaunchScreen());
  }

  // update profile function
updateProfile(){
  CollectionReference users = FirebaseFirestore.instance.collection('users');
    if (box.read('email') != emailController.text.trim().toString()) {
      checkEmailVerified();
    }
    else{
      Map<String,String> data = {
        'first_name':firstNameController.text.toString(),
        'last_name':lastNameController.text.toString(),
        'email':box.read('email'),
        'username':userNameController.text.toString(),
        'phone':phoneController.text.toString()
      };
      users.doc(docID).set(data).then((value) {
        MessageBox.showInSnackBar(Get.context!, 'Profile Updated.');
        isLoad = false;
        update();
      });
    }
}
// send email verification link
  checkEmailVerified() async {
  print(emailController.text.toString());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: box.read('email'), password: box.read('password')).then((value) async{


      value.user?.verifyBeforeUpdateEmail(emailController.text.toString()).then((val) {
        value.user?.updateEmail(emailController.text.toString()).then((value) {
          print('email updated');
        }).catchError((onerr){
          print(onerr);
        });
      });

      checkVerification(emailController.text);

      updateGroupEmail();
    });


  }

  var isVerified = false;

  // check if new email received verification email clicked the linked
  checkVerification(em) async{
    timer = Timer.periodic(Duration(seconds: 3), (t) {
      isVerified =  FirebaseAuth.instance.currentUser!.emailVerified;
     if(isVerified){
       box.write('email', emailController.text);
        updateGroupEmail();
       timer?.cancel();
     }
    });
  }

  // update group email of the logged in user
  updateGroupEmail()async{
    final querySnapshot = await FirebaseFirestore.instance
        .collection('groups')
        .where('created_by',isEqualTo:box.read('email'))
        .get();
    CollectionReference groups = FirebaseFirestore.instance.collection('groups');
    for(var a in querySnapshot.docs){
      groups.doc(a.id).set({'group_name':a['group_name'],'created_by':emailController.text.toString()});
    }
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Map<String,String> data = {
      'first_name':firstNameController.text.toString(),
      'last_name':lastNameController.text.toString(),
      'email':emailController.text.toString(),
      'username':userNameController.text.toString(),
      'phone':phoneController.text.toString()
    };
    users.doc(docID).set(data).then((value) {
      MessageBox.showInSnackBar(Get.context!, 'Profile Updated.');
      isLoad = false;
      update();
    });
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfile();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    timer?.cancel();

  }
}