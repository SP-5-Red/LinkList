import 'package:assignment_flutter/screens/create_group/create_group_controller.dart';
import 'package:flutter/cupertino.dart';
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
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.green,
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
                              labelText: 'Group Name'
                          ),),

                        SizedBox(height: Get.height  * 0.03,),

                        group.isLoad ? const Center(child:CircularProgressIndicator(color: Colors.green,)) : ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green,padding: EdgeInsets.all(15)),
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
