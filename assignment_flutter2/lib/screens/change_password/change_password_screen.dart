import 'package:assignment_flutter/screens/change_password/change_password_controller.dart';
import 'package:assignment_flutter/screens/user_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
        init: ChangePasswordController(),
        builder: (password)=>
            Scaffold(
                backgroundColor: UserColors.getColor(0),
                appBar: AppBar(
                  backgroundColor: UserColors.getColor(1),
                  centerTitle: true,
                  title: Text('PASSWORD'),
                  automaticallyImplyLeading: true,
                ),
                body: SafeArea(
                    child: Center(
                        child: ListView(
                          padding: EdgeInsets.only(
                              left: Get.width * 0.1,
                              right: Get.width * 0.1,
                              bottom: Get.height * 0.02),
                          children: [
                            SizedBox(height: Get.height  * 0.1,),
                            TextField(
                              controller: password.oldPasswordController,
                              obscureText:!password.isPasswordVisible,

                              decoration:  InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: (){
                                      password.changePasswordIcon();
                                    },
                                    child: Icon(password.isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                                  ),
                                  border:  const OutlineInputBorder( //Outline border type for TextField
                                      borderSide: BorderSide(
                                        color:Colors.redAccent,
                                        width: 3,
                                      )
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelText: 'Old Password'
                              ),),
                            SizedBox(height: Get.height  * 0.02,),
                            TextField(
                              controller: password.newPasswordController,
                              obscureText:!password.isNewPasswordVisible,

                              decoration:  InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: (){
                                      password.changeNewPasswordIcon();
                                    },
                                    child: Icon(password.isNewPasswordVisible ? Icons.visibility_off : Icons.visibility),
                                  ),
                                  border: const OutlineInputBorder( //Outline border type for TextField
                                      borderSide: BorderSide(
                                        color:Colors.redAccent,
                                        width: 3,
                                      )
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelText: 'New Password'
                              ),),
                            SizedBox(height: Get.height  * 0.02,),
                            TextField(
                              controller: password.confirmPasswordController,
                              obscureText:!password.isConfirmNewPasswordVisible,
                              decoration:  InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: (){
                                      password.changeConfirmPasswordIcon();
                                    },
                                    child: Icon(password.isConfirmNewPasswordVisible ? Icons.visibility_off : Icons.visibility),
                                  ),
                                  border: const   OutlineInputBorder( //Outline border type for TextField
                                      borderSide: BorderSide(
                                        color:Colors.redAccent,
                                        width: 3,
                                      )
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelText: 'Confirm Password'
                              ),),

                            SizedBox(height: Get.height  * 0.03,),
                            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: UserColors.getColor(1),padding: EdgeInsets.all(15)),
                              onPressed: (){
                                FocusManager.instance.primaryFocus?.unfocus();
                                if(password.checkForm()){
                                  password.updatePassword();
                                }
                              },child: Text('SAVE'),),
                          ],
                        )))));
  }
}
