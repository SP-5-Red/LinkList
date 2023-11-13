import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../MessageBox.dart';

class ReportController extends GetxController{
  List groupPrice = [];
  List groupAmounts = [];
  List<TextEditingController> priceControllers = [];
  List<TextEditingController> amountControllers = [];
  final box = GetStorage();

  getFontSize(String type) {
    if (type == "item") {
      return Get.height * 0.02;
    }
    if (type == "subnote") {
      return Get.height * 0.014;
    }
    if(type == "footer"){
      return Get.height * 0.025;
    }

    return 0.1;
  }

  getStringWidth(String s, int type) {
    TextStyle ts;
    if(type == 0) {
      ts = TextStyle(fontSize: getFontSize("item"), color: Colors.black);
    }else if (type == 1){
      ts = TextStyle(fontSize: getFontSize("subnote"), color: Colors.black);
    }else if (type == 2) {
      ts = TextStyle(fontSize: getFontSize("footer"), color: Colors.black);
    }else{
      ts = TextStyle(fontSize: getFontSize("item"), color: Colors.black);
    }

    TextSpan input = TextSpan(
      text: s.removeAllWhitespace,
      style: ts,
    );

    TextPainter inputTP = TextPainter(text:input, textDirection: TextDirection.ltr);
    inputTP.layout();

    return inputTP.width;
  }

  formatReportString(String name, double price, int type) {
    double maxWidth;
    double inputWidth;
    double periodWidth;
    String tmp = "";

    //Checks if name is too long for formatting
    if (name.length >= 12) {
      name = name.substring(0, 12);
    }

    //Checks what type of input and sets maxWidth accordingly
    if(type == 0) {
      maxWidth = (Get.width * 0.35);
    }else if (type == 1){
      maxWidth = (Get.width * 0.4);
    }else if (type == 2) {
      maxWidth = (Get.width * 0.63);
    }else{
      maxWidth = (Get.width * 0.5);
    }

    //Sets the initial widths
    inputWidth = getStringWidth(name.removeAllWhitespace + "\$", type);
    periodWidth = getStringWidth(".", type);

    //Adds a "." until string is correct width
    while (inputWidth + periodWidth <= maxWidth) {
      tmp += ".";
      inputWidth = getStringWidth(name.removeAllWhitespace + tmp + "\$", type);
    }

    if(type == 1) {
      return name + tmp + price.toInt().toString();
    }else{
      return name + tmp + "\$" + price.toStringAsFixed(2);
    }
  }

  //Sets all variables for cart items
  setItemLists(doc) async {
    update();
    CollectionReference groups = FirebaseFirestore.instance.collection('groups');
    DocumentSnapshot groupAccess = await groups.doc(doc).get();

    groupPrice = groupAccess.get('purchased_cost');
    groupAmounts = groupAccess.get('purchased_quantity');

    for(int i = 0; i < priceControllers.length; i++) {
      dynamic tmpPrice = double.tryParse(priceControllers[i].text.trim());
      dynamic tmpAmount = double.tryParse(amountControllers[i].text.trim());

      if(tmpPrice != null) {
        groupPrice[i] = tmpPrice;
      }

      if(tmpAmount != null) {
        groupAmounts[i] = tmpAmount;
      }
    };

    Map<String,dynamic> data = {
      'purchased_cost' : groupPrice,
      'purchased_quantity' : groupAmounts,
    };
    groups.doc(doc).update(data).then((value) {
      MessageBox.showInSnackBar(Get.context!,'Values Updated');
      update();
    });
  }

  //Returns price per item
  getPrice(List p, List a, int i) {
    if (a[i] == 0) {
      return 0.0;
    }

    return p[i] / a[i];
  }

  //Returns total
  getPurchasedTotal() {
    double totalSum = 0;

    groupPrice.forEach((element) {
      totalSum += element;
    });

    return totalSum;
  }
}

