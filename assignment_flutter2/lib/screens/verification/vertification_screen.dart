import 'package:assignment_flutter/screens/verification/verification_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerificationController>(
        init: VerificationController(),
        builder: (verify) => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.green,
              centerTitle: true,
              title: Text('VERIFICATION'),
              automaticallyImplyLeading: true,
            ),
            body: SafeArea(
                child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Get.height * 0.03,),
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: Get.height * 0.04,),
                const Center(
                  child: Text('Waiting for email verification'),
                ),
                SizedBox(height: Get.height * 0.02,),
                const Center(
                  child: Text(
                      'Verification link sent to your registered email address'),
                ),
                SizedBox(height: Get.height * 0.05,),
                Center(
                  child: CountdownTimer(
                  endTime: verify.time,
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: Get.height * 0.02),
                  endWidget: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          FirebaseAuth.instance.currentUser
                              ?.sendEmailVerification();
                        },
                        child: Text(
                          'Resend Verification',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.height * 0.02),
                        ),
                      )
                    ],
                  ),
                  onEnd: () {
                    verify.otpTimeOut();
                  },
                ))
              ],
            )))));
  }
}
