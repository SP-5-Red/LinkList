import 'package:assignment_flutter/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../MessageBox.dart';
import '../home/home_controller.dart';
import '../user_colors.dart';

class LoginController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isLoad = false;
  final box = GetStorage();
  var isPasswordVisible = false;

  // form validation
  checkForm(){
    if(emailController.text.trim().isEmpty){
      MessageBox.showInSnackBar(Get.context!, 'Please Enter Email');
      return false;
    }
    if(!isEmail(emailController.text.toString())){
      MessageBox.showInSnackBar(Get.context!, 'Please Enter Valid Email');
      return false;
    }
    if(passwordController.text.trim().toString().isEmpty){
      MessageBox.showInSnackBar(Get.context!, 'Please Enter Password');
      return false;
    }
    return true;
  }
  // icon state change
  changePasswordIcon(){
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  // authenticate user with email and password
  signInUser() async {
    isLoad = true;
    update();
    try {
     await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString()
      );

     box.write('email', emailController.text.toString().toLowerCase());
     box.write('password', passwordController.text.toString());
     UserColors.getTheme();
     box.write('theme', UserColors.theme);

      isLoad = false;
      update();
      Get.delete<HomeController>();
      Get.offAll(()=>HomeScreen());
    } on FirebaseAuthException catch (e) {
      isLoad = false;
      update();
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {
      }
      else{MessageBox.showInSnackBar(Get.context!, e.code);}}
  }
  bool isEmail(String email) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp =  RegExp(p);
    return regExp.hasMatch(email);
  }
}