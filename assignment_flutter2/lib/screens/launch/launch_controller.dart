import 'package:assignment_flutter/screens/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LaunchController extends GetxController{

  final box = GetStorage();
  var isLoggedIn;
  // check if user is already logged in or not
  checkLogin(){
    if(box.read('email') != null){
      isLoggedIn = true;
      update();
      Get.offAll(()=>HomeScreen());
    }
    else{
      isLoggedIn = false;
      update();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(const Duration(seconds: 1),(){
    checkLogin();
    });
  }
}