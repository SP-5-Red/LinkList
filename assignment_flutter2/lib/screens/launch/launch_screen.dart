import 'package:assignment_flutter/screens/launch/launch_controller.dart';
import 'package:assignment_flutter/screens/login/login_screen.dart';
import 'package:assignment_flutter/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LaunchController>(
        init: LaunchController(),
        builder: (launch)=>Scaffold(
        backgroundColor: Colors.white,

        body: SafeArea(
          child:Center(child:
          launch.isLoggedIn == null ? const Center(child: CircularProgressIndicator(color: Colors.green,),)
          : launch.isLoggedIn == false ?
          ListView(
            padding: EdgeInsets.only(left: Get.width * 0.1,right: Get.width * 0.1),
            children: [
              SizedBox(height: Get.height  * 0.1,),
              Image.asset('assets/logo.png',height: Get.height * 0.25,),
              SizedBox(height: Get.height * 0.02,),
              Center(child:Text('LinkList',style: TextStyle(color: Colors.green,fontSize: Get.height * 0.03,fontWeight: FontWeight.bold),)),

              SizedBox(height: Get.height  * 0.1,),
              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: (){
                  Get.to(()=>const LoginScreen());
                },child: const Text('LOGIN'),),
              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: (){
                  Get.to(()=>const RegisterScreen());

                },child: const Text('REGISTER'),),
            ],
          ) : SizedBox()) ,
        )
    ));
  }
}
