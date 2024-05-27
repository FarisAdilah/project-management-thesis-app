import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

class Helpers {
  showSuccessSnackBar(String message) {
    Get.snackbar(
      "Success",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.3),
      colorText: Colors.white,
    );
  }

  showErrorSnackBar(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.3),
      colorText: Colors.white,
    );
  }

  writeLog(String message) {
    if (Constant.showLog) {
      log("${Constant.logIdentifier}: $message");
    }
  }
}
