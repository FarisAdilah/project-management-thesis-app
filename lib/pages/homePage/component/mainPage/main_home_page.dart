import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class MainHomePage extends StatelessWidget {
  final List<UserDM> users;

  const MainHomePage({
    super.key,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text("Ini Halaman Untuk Semua Data"),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => ListView.builder(
              itemCount: users.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                UserDM user = users[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  color: Colors.grey[300],
                  child: ListTile(
                    title: Text("${user.name}"),
                    subtitle: Text("Role: ${user.role}"),
                    onTap: () {
                      Helpers().showSuccessSnackBar("${user.id}");
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
