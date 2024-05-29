import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

class Helpers {
  showSuccessSnackBar(
    String message, {
    SnackPosition position = SnackPosition.BOTTOM,
    EdgeInsets margin = const EdgeInsets.all(15),
  }) {
    Get.snackbar(
      "Success",
      message,
      snackPosition: position,
      margin: margin,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  showErrorSnackBar(
    String message, {
    SnackPosition position = SnackPosition.BOTTOM,
    EdgeInsets margin = const EdgeInsets.all(15),
  }) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: position,
      margin: margin,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  static writeLog(String message) {
    if (Constant.showLog) {
      log("${Constant.logIdentifier}: $message");
    }
  }

  String getInitialName(String name) {
    List<String> nameLetter = name.split(" ");
    String initialName = "";
    for (var element in nameLetter) {
      initialName += element[0].toUpperCase();
    }

    return initialName;
  }
}
