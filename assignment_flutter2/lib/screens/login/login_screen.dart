import 'package:assignment_flutter/screens/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (login) => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(backgroundColor: Colors.green, centerTitle: true, title: Text('LOGIN'),
              automaticallyImplyLeading: true,
            ),
            body: SafeArea(
              child: Center(
                  child: ListView(
                padding: EdgeInsets.only(left: Get.width * 0.1, right: Get.width * 0.1),
                children: [
                  SizedBox(height: Get.height * 0.1,),
                  Image.asset('assets/logo.png', height: Get.height * 0.25,),
                  SizedBox(height: Get.height * 0.02,),
                  Center(child:Text('LinkList',style: TextStyle(color: Colors.green,fontSize: Get.height * 0.03,fontWeight: FontWeight.bold),)),
                  SizedBox(height: Get.height * 0.05,),
                  TextField(
                    controller: login.emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent, width: 3,)), labelText: 'Email'),
                  ),
                  SizedBox(height: Get.height * 0.02,),
                  TextField(
                    controller: login.passwordController,
                    obscureText: !login.isPasswordVisible,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(onTap: () {login.changePasswordIcon();},
                        child: Icon(login.isPasswordVisible ? Icons.visibility_off : Icons.visibility),),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent, width: 3,)), labelText: 'Password',),
                  ),
                  SizedBox(height: Get.height * 0.03,),
                  login.isLoad
                      ? const Center(child: CircularProgressIndicator(color: Colors.green,),)
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.all(15)),
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (login.checkForm()) {login.signInUser(); }
                          },
                          child: Text('LOGIN'),
                        ),
                ],
              )),
            )));
  }
}
