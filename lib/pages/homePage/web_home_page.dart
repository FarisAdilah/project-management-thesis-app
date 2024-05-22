import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/pages/homePage/controller_home_page.dart';

class WebHomePage extends StatelessWidget {
  const WebHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomePageController());

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'HomePage',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey[900],
        ),
        drawer: Drawer(
          backgroundColor: Colors.grey[300],
          child: const Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text("Test")
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("HomePage"),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => controller.goToProjectPage(),
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red),
                ),
                child: const Text(
                  "Project Page",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => controller.logout(),
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red),
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
