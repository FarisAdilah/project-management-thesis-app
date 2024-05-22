import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/pages/authentication/controller_auth.dart';

class WebAuthentication extends StatelessWidget {
  const WebAuthentication({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        // backgroundColor:  Color(0x00000000),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFB3E5FC),
                Color(0xFFBA68C8),
                Color(0xFF9576CD),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'PenTools',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 330,
                width: 325,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Hello",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Please Login to Your Account',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: controller.emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                          suffixIcon: Icon(
                            Icons.email,
                            size: 17,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        obscureText: true,
                        controller: controller.passwordController,
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            suffixIcon: Icon(
                              Icons.password,
                              size: 17,
                            )),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: 150,
                      child: TextButton(
                        onPressed: () {
                          controller.login();
                        },
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
