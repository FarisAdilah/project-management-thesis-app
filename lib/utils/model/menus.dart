import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

class Menus {
  int? id;
  String? name;
  IconData? icon;
  MenuType? type;
  bool? selected;

  Menus({
    this.id,
    this.name,
    this.icon,
    this.type,
    this.selected = false,
  });
}
