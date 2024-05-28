import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';

class MainHomePage extends StatelessWidget {
  final List<UserDM> users;

  const MainHomePage({
    super.key,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Text("Ini Halaman Untuk Semua Data"),
        ],
      ),
    );
  }
}
