import 'package:assignment_flutter/screens/create_group/create_group_controller.dart';
import 'package:assignment_flutter/screens/user_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateGroupController>(
      init: CreateGroupController(),
        builder: (group) =>
            Scaffold(
            backgroundColor: UserColors.getColor(0),
            appBar: AppBar(
              backgroundColor: UserColors.getColor(1),
              centerTitle: true,
              title: Text('GROUP'),
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
                          controller: group.groupName,
                          decoration: const InputDecoration(
                              border:  OutlineInputBorder( //Outline border type for TextFeild
                                  borderSide: BorderSide(
                                    color:Colors.redAccent,
                                    width: 3,
                                  )
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'Group Name'
                          ),),

                        SizedBox(height: Get.height  * 0.03,),

                        group.isLoad ? Center(child:CircularProgressIndicator(color: UserColors.getColor(1),)) : ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: UserColors.getColor(1),padding: EdgeInsets.all(15)),
                          onPressed: (){
                            FocusManager.instance.primaryFocus?.unfocus();
                            if(group.checkForm()){
                              group.createGroup();
                            }

                          },child: Text('CREATE GROUP'),),
                      ],
            )))));
  }
}
