import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';

class CreateForm extends StatelessWidget {
  final Function(UserDM)? onSubmit;
  final VoidCallback? onTap;
  final File image;
  final Uint8List imageWeb;

  const CreateForm({
    super.key,
    this.onSubmit,
    this.onTap,
    required this.image,
    required this.imageWeb,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
