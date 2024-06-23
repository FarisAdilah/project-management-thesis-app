import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class MobileProjectContent extends StatelessWidget {
  final ProjectDM project;

  const MobileProjectContent({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            project.name ?? "",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 5),
          CustomText(
            "id: ${project.id ?? ""}",
            color: AssetColor.grey,
          ),
          const Divider(
            color: AssetColor.grey,
            thickness: 1,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      "Start Date",
                      color: AssetColor.grey,
                    ),
                    CustomText(
                      Helpers().convertDateStringFormat(
                        project.startDate ?? "",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      "End Date",
                      color: AssetColor.grey,
                    ),
                    CustomText(
                      Helpers().convertDateStringFormat(
                        project.endDate ?? "",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      "Client",
                      color: AssetColor.grey,
                    ),
                    CustomText(
                      project.clientName ?? "",
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      "Status",
                      color: AssetColor.grey,
                    ),
                    _buildStatus(project.status ?? ""),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildStatus(String status) {
  Color statusColor;
  String title = "";
  if (status == ProjectStatusType.pending.name) {
    statusColor = AssetColor.orange;
    title = "Pending";
  } else if (status == ProjectStatusType.rejected.name) {
    statusColor = AssetColor.redButton;
    title = "Rejected";
  } else if (status == ProjectStatusType.ongoing.name) {
    statusColor = AssetColor.blueSecondaryAccent;
    title = "Ongoing";
  } else if (status == ProjectStatusType.closing.name) {
    statusColor = AssetColor.orange;
    title = "Closing";
  } else {
    statusColor = AssetColor.green;
    title = "Completed";
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: statusColor.withOpacity(0.3),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: statusColor,
        width: 1,
      ),
    ),
    child: CustomText(
      title,
      color: statusColor,
    ),
  );
}
