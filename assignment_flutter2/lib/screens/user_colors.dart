import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../MessageBox.dart';

class UserColors{
  static final box = GetStorage();
  static List preview_theme = [0, 0];
  static List theme = [];

  static getTheme() async {
    CollectionReference users = await FirebaseFirestore.instance.collection('users');
    QuerySnapshot user = await users.where('email', isEqualTo: box.read('email')).get();

    theme = user.docs.elementAt(0).get('theme') as List;
  }

  static setTheme() async {
    CollectionReference users = await FirebaseFirestore.instance.collection('users');
    QuerySnapshot user = await users.where('email', isEqualTo: box.read('email')).get();

    String tmpID = user.docs.elementAt(0).id;
    Map<String,dynamic> data = {
      'first_name': user.docs.elementAt(0).get('first_name'),
      'last_name': user.docs.elementAt(0).get('last_name'),
      'email': user.docs.elementAt(0).get('email'),
      'username': user.docs.elementAt(0).get('username'),
      'phone': user.docs.elementAt(0).get('phone'),
      'theme': theme
    };

    users.doc(tmpID).set(data).then((value) {
      MessageBox.showInSnackBar(Get.context!, 'Theme Updated.');
      getTheme();
    });
  }

  static getPreviewColor(int type) {
    preview_theme = theme;
    switch (type) {
      case 0:
        if (preview_theme[0] == 1) {
          return Colors.blueGrey[800];
        } else {
          return Colors.white;
        }
      case 1:
        switch (preview_theme[1]) {
          case 0:
            return Colors.green;
          case 1:
            return Colors.red[900];
          case 2:
            return Colors.pink[600];
          case 3:
            return Colors.teal[600];
          case 4:
            return Colors.deepPurple[400];
          case 5:
            return Colors.orange[700];
          default:
            return Colors.green;
        }
      case 2:
        switch (preview_theme[1]) {
          case 0:
            return Colors.green.shade50;
          case 1:
            return Colors.red.shade50;
          case 2:
            return Colors.pink.shade50;
          case 3:
            return Colors.teal.shade50;
          case 4:
            return Colors.deepPurple.shade50;
          case 5:
            return Colors.orange.shade50;
          default:
            return Colors.green.shade50;
        }
      case 3:
        if (preview_theme[0] == 1) {
          return Colors.white;
        } else {
          return Colors.black;
        }
    }
  }

  static getColor(int type) {
    /*
    Gets user preferences from database as a list, first element is light vs.
    dark modes and second is accent color
     */
    getTheme();

    switch (type) {
      case 0:
        if (theme[0] == 1) {
          return Colors.blueGrey[800];
        } else {
          return Colors.white;
        }
      case 1:
        switch (theme[1]) {
          case 0:
            return Colors.green;
          case 1:
            return Colors.red[900];
          case 2:
            return Colors.pink[600];
          case 3:
            return Colors.teal[600];
          case 4:
            return Colors.deepPurple[400];
          case 5:
            return Colors.orange[700];
          default:
            return Colors.green;
        }
      case 2:
        switch (theme[1]) {
          case 0:
            return Colors.green.shade50;
          case 1:
            return Colors.red.shade50;
          case 2:
            return Colors.pink.shade50;
          case 3:
            return Colors.teal.shade50;
          case 4:
            return Colors.deepPurple.shade50;
          case 5:
            return Colors.orange.shade50;
          default:
            return Colors.green.shade50;
        }
      case 3:
        if (theme[0] == 1) {
          return Colors.white;
        } else {
          return Colors.black;
        }
    }
  }
}

