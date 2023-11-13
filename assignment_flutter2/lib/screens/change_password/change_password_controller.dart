import 'package:assignment_flutter/MessageBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChangePasswordController extends GetxController{
  final box = GetStorage();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var isPasswordVisible = false;
  var isNewPasswordVisible = false;
  var isConfirmNewPasswordVisible = false;


  // icon state change
  changePasswordIcon(){
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  // icon state change
  changeNewPasswordIcon(){
    isNewPasswordVisible = !isNewPasswordVisible;
    update();
  }

  // icon state change
  changeConfirmPasswordIcon(){
    isConfirmNewPasswordVisible = !isConfirmNewPasswordVisible;
    update();
  }


// form validation
  checkForm(){
    if(oldPasswordController.text.trim().isEmpty){
      MessageBox.showInSnackBar(Get.context!, 'Please Enter Old Password');
      return false;
    }
    if(newPasswordController.text.trim().isEmpty){
      MessageBox.showInSnackBar(Get.context!, 'Please Enter New Password');
      return false;
    }
    if(confirmPasswordController.text.trim().isEmpty){
      MessageBox.showInSnackBar(Get.context!, 'Please Enter Confirm Password');
      return false;
    }
    if(newPasswordController.text.trim().toString().length < 8){
      MessageBox.showInSnackBar(Get.context!, 'Please Enter 8 digit Password');
      return false;
    }
    if(oldPasswordController.text.trim().toString() != box.read('password')){
      MessageBox.showInSnackBar(Get.context!, 'Incorrect Old Password. Try Again');
      return false;

    }
    if(newPasswordController.text.trim().toString() != confirmPasswordController.text.trim().toString()){
      MessageBox.showInSnackBar(Get.context!, 'Password and Confirm Password not matched');
      return false;
    }
    return true;
  }

  // update password function
  updatePassword() async{
    final user = await FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: box.read('email'), password: box.read('password'));

    user?.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPasswordController.text.trim().toString()).then((_) {
        //Success, do something
        MessageBox.showInSnackBar(Get.context!, 'Password Updated');
        box.write('password', newPasswordController.text.toString());
        Future.delayed(Duration(seconds: 2),(){
          Get.back();
        });
      }).catchError((error) {
        MessageBox.showInSnackBar(Get.context!, error.toString());

        //Error, show something
      });
    }).catchError((err) {
      MessageBox.showInSnackBar(Get.context!, err.toString());

    });
  }

  }
