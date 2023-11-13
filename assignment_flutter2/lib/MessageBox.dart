import 'package:flutter/material.dart';

class MessageBox{
  static void showInSnackBar(BuildContext? context,String value) {
    ScaffoldMessenger.of(context!).showSnackBar(SnackBar(content: Text(value),duration: const Duration(seconds: 3),));
  }
}