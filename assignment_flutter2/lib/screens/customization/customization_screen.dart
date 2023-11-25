import 'package:assignment_flutter/screens/customization/customization_controller.dart';
import 'package:assignment_flutter/screens/user_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/home_controller.dart';
import '../home/home_screen.dart';

class CustomizationScreen extends StatelessWidget {
  const CustomizationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomizationController>(
        init: CustomizationController(),
        builder: (custom) =>
            Scaffold(
                backgroundColor: UserColors.getPreviewColor(0),
                appBar: AppBar(
                  backgroundColor: UserColors.getPreviewColor(1),
                  centerTitle: true,
                  title: Text('CUSTOMIZATION'),
                  leading: IconButton(
                    onPressed: (){
                      custom.save_selection();
                      Get.delete<HomeController>();
                      Get.offAll(()=>HomeScreen());
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  automaticallyImplyLeading: true,
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: Get.height  * 0.06,),
                          Text("Theme", style: TextStyle(color: UserColors.getPreviewColor(1),fontSize: Get.height * 0.035, decoration: TextDecoration.underline),),
                          SizedBox(height: Get.height  * 0.04,),
                          Row(
                            children: [
                              SizedBox(width: Get.width  * 0.1,),
                              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: custom.isThemeValue(1) ? Colors.white : Colors.grey[600],padding: EdgeInsets.all(15)),
                                onPressed: (){
                                  custom.set_theme_value(0);
                                },child: Text('LIGHT MODE', style: TextStyle(color: Colors.black),),),
                              SizedBox(width: Get.width  * 0.25,),
                              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: custom.isThemeValue(1) ? Colors.grey[600] : Colors.black,padding: EdgeInsets.all(15)),
                                onPressed: (){
                                  custom.set_theme_value(1);
                                },child: Text('DARK MODE', style: TextStyle(color: Colors.white)),),
                            ],
                          ),
                          SizedBox(height: Get.height  * 0.08,),
                          Text("Accent Color", style: TextStyle(color: UserColors.getPreviewColor(1),fontSize: Get.height * 0.035, decoration: TextDecoration.underline),),
                          Center(
                              child: Column(
                                children: [
                                  SizedBox(height: Get.height  * 0.04,),
                                  Row(
                                    children: [
                                      SizedBox(width: Get.width  * 0.1,),
                                      Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            custom.set_color_value(0);
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 3.0, color: custom.isColorValue(0) ? Colors.black : Colors.lightBlue),
                                                shape: BoxShape.circle,
                                                color: Colors.green
                                            ),

                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            custom.set_color_value(1);
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 3.0, color: custom.isColorValue(1) ? Colors.black : Colors.lightBlue),
                                                shape: BoxShape.circle,
                                                color: Colors.red[900]
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            custom.set_color_value(2);
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 3.0, color: custom.isColorValue(2) ? Colors.black : Colors.lightBlue),
                                                shape: BoxShape.circle,
                                                color: Colors.pink[600]
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: Get.width  * 0.1),
                                      Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            custom.set_color_value(3);
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 3.0, color: custom.isColorValue(3) ? Colors.black : Colors.lightBlue),
                                                shape: BoxShape.circle,
                                                color: Colors.teal[600]
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            custom.set_color_value(4);
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 3.0, color: custom.isColorValue(4) ? Colors.black : Colors.lightBlue),
                                                shape: BoxShape.circle,
                                                color: Colors.deepPurple[400]
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            custom.set_color_value(5);
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 3.0, color: custom.isColorValue(5) ? Colors.black : Colors.lightBlue),
                                                shape: BoxShape.circle,
                                                color: Colors.orange[700]
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                          ),
                        ],
                      )
                  ),
                )
            )
    );
  }
}
