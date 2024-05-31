import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/authentication/controller_auth.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class WebAuthentication extends StatelessWidget {
  const WebAuthentication({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());

    return Scaffold(
      body: Center(
        child: Obx(
          () => Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AssetColor.bluePrimaryAccent,
                      AssetColor.blueSecondaryAccent,
                      AssetColor.blueTertiaryAccent,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.penToSquare,
                          color: AssetColor.whitePrimary,
                          size: 28,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        CustomText(
                          'PenTools',
                          color: AssetColor.whitePrimary,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 325,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 25,
                      ),
                      decoration: BoxDecoration(
                        color: AssetColor.whitePrimary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CustomText(
                            "Hello",
                            fontSize: 35,
                            color: AssetColor.blackPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const CustomText(
                            'Please Login to Your Account',
                            fontSize: 15,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: controller.emailController,
                            onChanged: (value) => controller.onTyping(),
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                              labelStyle: TextStyle(
                                fontSize: 15,
                              ),
                              suffixIcon: Icon(
                                FontAwesomeIcons.envelope,
                                size: 17,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          Obx(
                            () => TextField(
                              obscureText: controller.isObscure.value,
                              controller: controller.passwordController,
                              onChanged: (value) => controller.onTyping(),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                suffixIcon: InkWell(
                                  onTap: () => controller.toggleObscure(),
                                  child: Icon(
                                    controller.isObscure.value
                                        ? FontAwesomeIcons.eyeSlash
                                        : FontAwesomeIcons.eye,
                                    size: 17,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(
                            () => CustomButton(
                              onPressed: () => controller.enableButton.value
                                  ? controller.login()
                                  : null,
                              isEnabled: controller.enableButton.value,
                              text: 'Log In',
                            ),
                          ),
                          // TextButton(
                          //   onPressed: () => controller.enableButton.value
                          //       ? controller.login()
                          //       : (),
                          //   style: ButtonStyle(
                          //     backgroundColor: MaterialStatePropertyAll(
                          //       controller.enableButton.value
                          //           ? AssetColor.bluePrimaryAccent
                          //           : AssetColor.blueDisabled,
                          //     ),
                          //   ),
                          //   child: const CustomText(
                          //     "Log In",
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //       fontWeight: FontWeight.w200,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              controller.isLoading.value
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: AssetColor.blueTertiaryAccent.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
