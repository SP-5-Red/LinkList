import 'package:assignment_flutter/screens/register/register_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (register)=>
        Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.green,
              centerTitle: true,
              title: Text('REGISTER'),automaticallyImplyLeading: true,),
            body: SafeArea(
              child:Center(child: ListView(
                padding: EdgeInsets.only(left: Get.width * 0.1,right: Get.width * 0.1,bottom: Get.height * 0.02),
                children: [
                  SizedBox(height: Get.height  * 0.1,),
                  Image.asset('assets/logo.png',height: Get.height * 0.25,),
                  SizedBox(height: Get.height * 0.02,),
                  Center(child:Text('LinkList',style: TextStyle(color: Colors.green,fontSize: Get.height * 0.03,fontWeight: FontWeight.bold),)),

                  SizedBox(height: Get.height  * 0.05,),
                   TextField(
                    controller: register.firstNameController,
                    decoration: const InputDecoration(
                        border:  OutlineInputBorder( //Outline border type for TextFeild
                            borderSide: BorderSide(
                              color:Colors.redAccent,
                              width: 3,
                            )
                        ),
                        labelText: 'First Name'
                    ),),
                  SizedBox(height: Get.height  * 0.02,),

                   TextField(
                     controller: register.lastNameController,
                     decoration: const InputDecoration(
                      border:  OutlineInputBorder( //Outline border type for TextFeild
                         borderSide: BorderSide(color:Colors.redAccent, width: 3,)), labelText: 'Last Name',),),
                  SizedBox(height: Get.height  * 0.02,),
                   TextField(
                     controller: register.userNameController,
                     decoration: const InputDecoration(
                      border:  OutlineInputBorder( //Outline border type for TextFeild
                          borderSide: BorderSide(color:Colors.redAccent, width: 3,)), labelText: 'Username',
                    ),),
                  SizedBox(height: Get.height  * 0.02,),
                  TextField(
                    controller: register.phoneController,

                    decoration: const InputDecoration(
                      border:  OutlineInputBorder( //Outline border type for TextFeild
                          borderSide: BorderSide(
                            color:Colors.redAccent,
                            width: 3,)), labelText: 'Phone',),),
                  SizedBox(height: Get.height  * 0.02,),
                   TextField(
                     controller: register.emailController,
                     decoration: const InputDecoration(
                      border:  OutlineInputBorder( //Outline border type for TextFeild
                          borderSide: BorderSide(color:Colors.redAccent, width: 3,)), labelText: 'Email',),),
                  SizedBox(height: Get.height  * 0.02,),
                   TextField(
                     controller: register.passwordController,
                     obscureText:!register.isPasswordVisible,
                     decoration:  InputDecoration(
                       suffixIcon: GestureDetector(
                         onTap: (){register.changePasswordIcon();},
                         child: Icon(register.isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                       ),
                      border: const  OutlineInputBorder( //Outline border type for TextFeild
                          borderSide: BorderSide(color:Colors.redAccent, width: 3,)), labelText: 'Password',
                    ),),
                  SizedBox(height: Get.height  * 0.03,),
                  register.isLoad ? const Center(child:CircularProgressIndicator(color: Colors.green,)) :ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green,padding: const EdgeInsets.all(15)),
                    onPressed: (){
                      FocusManager.instance.primaryFocus?.unfocus();

                      if(register.checkForm())
                      {
                        register.createAccount();
                      }

                    },child: const Text('REGISTER'),),
                ],
              )),
            )
        ));
  }
}
