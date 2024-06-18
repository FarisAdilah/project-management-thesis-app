import 'package:flutter/widgets.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/project_pending_item_content.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class PendingProject extends StatelessWidget {
  final List<ProjectDM> pendingProjects;
  final Function(ProjectDM) showPendingDetail;
  final bool isAdmin;

  const PendingProject({
    super.key,
    required this.pendingProjects,
    required this.showPendingDetail,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          isAdmin ? "Pending Rejected Project" : "Pending Aprroval Project",
          color: AssetColor.blueTertiaryAccent,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 325,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: pendingProjects.length,
            itemBuilder: (context, index) {
              ProjectDM pendingProject = pendingProjects[index];

              return PendingItemContent(
                pendingProject: pendingProject,
                onPressed: () {
                  showPendingDetail(pendingProject);
                },
                isAdmin: isAdmin,
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
