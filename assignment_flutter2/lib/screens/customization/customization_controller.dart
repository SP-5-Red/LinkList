import 'package:assignment_flutter/screens/user_colors.dart';
import 'package:get/get.dart';

class CustomizationController extends GetxController{
  bool isThemeValue(int val) {
    return val == UserColors.theme[0];
  }

  bool isColorValue(int val) {
    return val != UserColors.theme[1];
  }

  set_theme_value(int val) {
    UserColors.theme[0] = val;
    update();
  }

  set_color_value(int val) {
    UserColors.theme[1] = val;
    update();
  }

  save_selection() {
    UserColors.setTheme();
  }
}