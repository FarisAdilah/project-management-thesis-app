import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/avatar/profile_picture.dart';
import 'package:project_management_thesis_app/globalComponent/inputCustom/custom_input_border.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/profilePage/controller_profile.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/asset_images.dart';

class MobileProfile extends StatelessWidget {
  const MobileProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Obx(
      () => Stack(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetImages.backgroundProfile),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: MediaQuery.sizeOf(context).height * 0.1,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AssetImages.iconProfileResume,
                          scale: 2,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              "See your profile here",
                              color: AssetColor.whiteBackground,
                            ),
                            Obx(
                              () => CustomText(
                                "id: ${controller.user.value.id ?? ""}",
                                color: AssetColor.whiteBackground,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 25,
                    ),
                    decoration: BoxDecoration(
                      color: AssetColor.whiteBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 125,
                          width: 125,
                          child: Obx(
                            () => ProfilePicture(
                              user: controller.user.value,
                              backgroundColor: AssetColor.blueSecondaryAccent,
                              initialNameSize: 30,
                            ),
                          ),
                        ),
                        _buildInput(
                          "Name",
                          FontAwesomeIcons.user,
                          controller: controller.nameController,
                          enabled: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildInput(
                          "Email",
                          FontAwesomeIcons.envelope,
                          controller: controller.emailController,
                          enabled: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => _buildInput(
                            "Password",
                            controller.isObscure.value
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            controller: controller.passwordController,
                            isPassword: controller.isObscure.value,
                            obscureCallback: () {
                              controller.toggleObscure();
                            },
                            onChanged: (password) {
                              controller.validateInput(
                                "password",
                                password,
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildInput(
                          "Phone Number",
                          FontAwesomeIcons.phone,
                          controller: controller.phoneController,
                          onChanged: (number) {
                            controller.validateInput(
                              "phoneNumber",
                              number,
                            );
                          },
                          enabled: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildInput(
                          "Role",
                          FontAwesomeIcons.userTag,
                          controller: controller.roleController,
                          enabled: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          controller.isLoading.value ? const Loading() : const SizedBox(),
        ],
      ),
    );
  }
}

Widget _buildInput(
  String title,
  IconData icon, {
  TextEditingController? controller,
  bool? isPassword,
  bool? enabled,
  VoidCallback? obscureCallback,
  Function(String)? onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
        title,
        color: AssetColor.grey,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      const SizedBox(
        height: 8,
      ),
      CustomInputBorder(
        icon: icon,
        controller: controller,
        isPassword: isPassword,
        enabled: enabled,
        readOnly: true,
        obscureCallback: obscureCallback,
        onChanged: onChanged != null ? (value) => onChanged(value) : null,
      ),
    ],
  );
}
