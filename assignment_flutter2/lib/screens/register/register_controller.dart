import 'package:assignment_flutter/MessageBox.dart';
import 'package:assignment_flutter/screens/verification/vertification_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{

TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController userNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController phoneController = TextEditingController();


var isLoad = false;
// form validation
checkForm(){
  if(firstNameController.text.trim().toString().isEmpty){
    MessageBox.showInSnackBar(Get.context!, 'Please Enter First Name');
    return false;
  }
  if(lastNameController.text.trim().toString().isEmpty){
    MessageBox.showInSnackBar(Get.context!, 'Please Enter Last Name');
    return false;
  }
  if(userNameController.text.trim().toString().isEmpty){
    MessageBox.showInSnackBar(Get.context!, 'Please Enter Username');
    return false;
  }
  if(userNameController.text.toString().contains(' ')){
    MessageBox.showInSnackBar(Get.context!, 'Username does not contain empty space');
    return false;
  }
  if(phoneController.text.trim().toString().isEmpty){
    MessageBox.showInSnackBar(Get.context!, 'Please Enter Phone');

    return false;
  }
  if(emailController.text.trim().toString().isEmpty || !emailController.text.trim().toString().contains("@")){
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
  if(emailController.text.trim().toString().length < 8){
    MessageBox.showInSnackBar(Get.context!, 'Password must be 8 characters long');
    return false;
  }
  return true;
}
// create new user, store data in firestore and register email in firebase auth
createAccount() async{
  isLoad = true;
  update();
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.toString(),
      password: passwordController.text.toString(),
    );
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Map<String,String> data = {
      'first_name':firstNameController.text.toString(), 'last_name':lastNameController.text.toString(),
      'email':emailController.text.toString(), 'username':userNameController.text.toString(),
      'phone':phoneController.text.toString()
    };
    users.add(data).then((value) {
      MessageBox.showInSnackBar(Get.context!,'Account Created. Please Login');
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
      Get.to(()=>const VerificationScreen(),arguments: ['signup']);
      isLoad = false;
      update();
    });
  } on FirebaseAuthException catch (e) {
    isLoad = false;
    update();
    if (e.code == 'weak-password') {
      MessageBox.showInSnackBar(Get.context!,'The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      MessageBox.showInSnackBar(Get.context!,'The account already exists for that email.');
    }
  } catch (e) {
    isLoad = false;
    update();
    MessageBox.showInSnackBar(Get.context!,e.toString());
  }
}


var isPasswordVisible = false;
// change icon state
changePasswordIcon(){
  isPasswordVisible = !isPasswordVisible;
  update();
}
// email regex
bool isEmail(String email) {
  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp =  RegExp(p);
  return regExp.hasMatch(email);
}
}