import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class PendingProjectItemContent extends StatelessWidget {
  final ProjectDM pendingProject;
  final VoidCallback onPressed;
  final bool isAdmin;

  const PendingProjectItemContent({
    super.key,
    required this.pendingProject,
    required this.onPressed,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: AssetColor.whiteBackground,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: isAdmin ? AssetColor.redButton : AssetColor.orange,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AssetColor.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            pendingProject.name ?? "name",
            color: AssetColor.blackPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
          const Divider(
            color: AssetColor.grey,
            thickness: 1,
          ),
          const CustomText(
            "Client",
            color: AssetColor.blackPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          CustomText(
            pendingProject.clientName ?? "client",
            color: AssetColor.blackPrimary,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      "Start Date",
                      color: AssetColor.blackPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      Helpers().convertDateStringFormat(
                        pendingProject.startDate ?? "start date",
                      ),
                      color: AssetColor.blackPrimary,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      "End Date",
                      color: AssetColor.blackPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      Helpers().convertDateStringFormat(
                        pendingProject.endDate ?? "start date",
                      ),
                      color: AssetColor.blackPrimary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const CustomText(
            "Description",
            color: AssetColor.blackPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          CustomText(
            pendingProject.description ?? "description",
            color: AssetColor.blackPrimary,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: pendingProject.status ==
                          ProjectStatusType.rejectClose.name
                      ? AssetColor.redButton
                      : AssetColor.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomText(
                  Helpers().getProjectStatus(pendingProject.status ?? ""),
                  color: AssetColor.whiteBackground,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  maxLines: 2,
                ),
              ),
              CustomButton(
                text: "See Detail",
                borderRadius: 8,
                color: AssetColor.orangeButton,
                textColor: AssetColor.whiteBackground,
                onPressed: onPressed,
              ),
            ],
          )
        ],
      ),
    );
  }
}
