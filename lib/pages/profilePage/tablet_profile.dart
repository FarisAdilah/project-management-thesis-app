import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/avatar/profile_picture.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/inputCustom/custom_input_border.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/profilePage/controller_profile.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/asset_images.dart';

class TabletProfile extends StatelessWidget {
  const TabletProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Stack(
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
        Align(
          alignment: Alignment.center,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.sizeOf(context).height * 0.1,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.11,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                        padding: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).height * 0.1,
                          left: 50,
                          right: 50,
                          bottom: 25,
                        ),
                        decoration: BoxDecoration(
                          color: AssetColor.whiteBackground,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _buildInput(
                                    "Name",
                                    FontAwesomeIcons.user,
                                    controller: controller.nameController,
                                  ),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                Expanded(
                                  child: _buildInput(
                                    "Email",
                                    FontAwesomeIcons.envelope,
                                    controller: controller.emailController,
                                    enabled: false,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Obx(
                                  () => Expanded(
                                    child: _buildInput(
                                      "Password",
                                      controller.isObscure.value
                                          ? FontAwesomeIcons.eyeSlash
                                          : FontAwesomeIcons.eye,
                                      controller: controller.passwordController,
                                      isPassword: controller.isObscure.value,
                                      obscureCallback: () {
                                        controller.toggleObscure();
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                Expanded(
                                  child: _buildInput(
                                    "Phone Number",
                                    FontAwesomeIcons.phone,
                                    controller: controller.phoneController,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildInput(
                                    "Role",
                                    FontAwesomeIcons.userTag,
                                    controller: controller.roleController,
                                  ),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                const Expanded(child: SizedBox()),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              text: "Update Data",
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.sizeOf(context).height * 0.1,
                  ),
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
              )
            ],
          ),
        )
      ],
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
        obscureCallback: obscureCallback,
      ),
    ],
  );
}
