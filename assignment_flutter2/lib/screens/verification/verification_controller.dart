import 'dart:async';

import 'package:assignment_flutter/MessageBox.dart';
import 'package:assignment_flutter/screens/home/home_screen.dart';
import 'package:assignment_flutter/screens/launch/launch_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController{
  var isResendAvailable = false;
 var time = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
  bool isEmailVerified = false;
  Timer? timer;
var type;
var args = Get.arguments;
  otpTimeOut() {isResendAvailable = !isResendAvailable;update();}
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    type = args[0];
    update();
    timer = Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  // check if registered email clicked the verification link or not
  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      update();
    if (isEmailVerified) {
      timer?.cancel();
      if(type == 'signup'){
        MessageBox.showInSnackBar(Get.context!, 'Email Successfully Verified. Please Login');
        Get.offAll(()=>const LaunchScreen());}
      else{
        MessageBox.showInSnackBar(Get.context!, 'Email Successfully Verified.');
        Get.offAll(()=>HomeScreen());}
    }}
}