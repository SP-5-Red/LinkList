import 'package:assignment_flutter/screens/change_password/change_password_screen.dart';
import 'package:assignment_flutter/screens/home/home_controller.dart';
import 'package:assignment_flutter/screens/home/home_screen.dart';
import 'package:assignment_flutter/screens/user_colors.dart';
import 'package:assignment_flutter/screens/setting/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
        init: SettingController(),
        builder: (setting)=>Scaffold(
        backgroundColor: UserColors.getColor(0),
        appBar: AppBar(
          backgroundColor: UserColors.getColor(1),
          centerTitle: true,
          title: Text('SETTINGS'),
        leading: IconButton(
          onPressed: (){
            Get.delete<HomeController>();
            Get.offAll(()=>HomeScreen());
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          GestureDetector(onTap: (){
          setting.logoutUser();
          },
          child: Icon(Icons.logout),),
          SizedBox(width: 15,)
        ],
        ),
        body: SafeArea(
          child:Center(child: setting.isLoad ? const CircularProgressIndicator(color: Colors.green,) : ListView(
            padding: EdgeInsets.only(left: Get.width * 0.1,right: Get.width * 0.1,bottom: Get.height * 0.02),
            children: [
                SizedBox(height: Get.height  * 0.1,),
                 TextField(
                  controller: setting.firstNameController,
                  decoration: const InputDecoration(
                      border:  OutlineInputBorder( //Outline border type for TextFeild
                          borderSide: BorderSide(
                            color:Colors.redAccent,
                            width: 3,
                          )
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'First Name'
                  ),),
              SizedBox(height: Get.height  * 0.02,),

              TextField(
                controller: setting.phoneController,
                decoration: const InputDecoration(
                    border:  OutlineInputBorder( //Outline border type for TextFeild
                        borderSide: BorderSide(
                          color:Colors.redAccent,
                          width: 3,
                        )
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Phone'
                ),),
              SizedBox(height: Get.height  * 0.02,),

               TextField(
                 controller: setting.lastNameController,
                decoration: const InputDecoration(
                  border:  OutlineInputBorder( //Outline border type for TextFeild
                      borderSide: BorderSide(
                        color:Colors.redAccent,
                        width: 3,
                      )
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Last Name',

                ),),
              SizedBox(height: Get.height  * 0.02,),

               TextField(
                 controller: setting.userNameController,

                 decoration: const InputDecoration(
                  border:  OutlineInputBorder( //Outline border type for TextFeild
                      borderSide: BorderSide(
                        color:Colors.redAccent,
                        width: 3,
                      )
                  ),
                   fillColor: Colors.white,
                   filled: true,
                  labelText: 'Username',

                ),),
              SizedBox(height: Get.height  * 0.02,),
               TextField(
                 controller: setting.emailController,
                 decoration: const InputDecoration(
                  border:  OutlineInputBorder( //Outline border type for TextFeild
                      borderSide: BorderSide(
                        color:Colors.redAccent,
                        width: 3,
                      )
                  ),
                   fillColor: Colors.white,
                   filled: true,
                  labelText: 'Email',

                ),),


              SizedBox(height: Get.height  * 0.03,),
              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: UserColors.getColor(1),padding: EdgeInsets.all(15)),
                onPressed: (){
            setting.updateProfile();
                },child: Text('UPDATE PROFILE'),),
              SizedBox(height: Get.height  * 0.02,),

              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: UserColors.getColor(1),padding: EdgeInsets.all(15)),
                onPressed: (){

                 Get.to(()=>ChangePasswordScreen());

                },child: Text('CHANGE PASSWORD'),),
            ],
          )),
        )
    ));
  }
}
