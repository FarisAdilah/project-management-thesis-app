import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:url_launcher/url_launcher.dart';

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

  String getGeneratedPassword(String username) {
    String password = "";
    String firstName = username.split(" ")[0];

    password = "${firstName.toLowerCase()}#123";

    return password;
  }

  String getUserRole(String role) {
    if (role.isEmpty) {
      return "Role";
    }

    String userRole = "";

    if (role == UserType.supervisor.name) {
      userRole = "Supervisor";
    } else if (role == UserType.admin.name) {
      userRole = "Admin";
    } else if (role == UserType.projectManager.name) {
      userRole = "Project Manager";
    } else if (role == UserType.staff.name) {
      userRole = "Staff";
    }

    return userRole;
  }

  String convertDateStringFormat(String date, {String? format}) {
    if (date.isEmpty) {
      return "";
    }
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat(format ?? "d MMMM y").format(dateTime);

    return formattedDate;
  }

  String currencyFormat(String amount) {
    if (amount.isEmpty) {
      return "";
    }

    return NumberFormat.currency(
      locale: "id_ID",
      symbol: "Rp",
      decimalDigits: 0,
    ).format(
      int.parse(amount),
    );
  }

  String getTaskStatus(String status) {
    if (status.isEmpty) {
      return "Status";
    }

    String taskStatus = "";
    if (status == TaskStatusType.notStarted.name) {
      taskStatus = "Not Started";
    } else if (status == TaskStatusType.onProgress.name) {
      taskStatus = "On Progress";
    } else if (status == TaskStatusType.completed.name) {
      taskStatus = "Completed";
    } else if (status == TaskStatusType.overdue.name) {
      taskStatus = "Overdue";
    }

    return taskStatus;
  }

  Future<void> launchViaUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
