import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pennies_from_heaven/shared/custom_animation.dart';

InputDecoration textInputDecoration = InputDecoration(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));

void easyLoadingConfigForForms() {
  EasyLoading.instance
    // ..displayDuration = const Duration(seconds: 10)
    ..indicatorType = EasyLoadingIndicatorType.wave
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.blueAccent
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.orange.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}
