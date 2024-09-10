import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class PendingProjectDetail extends StatelessWidget {
  final ProjectDM project;
  final List<VendorDM> vendors;
  final ClientDM client;
  final UserDM projectManager;
  final bool isAdmin;
  final bool isClosing;
  final bool isRejectClose;
  final VoidCallback? onAddBastDocument;
  final String? fileName;
  final VoidCallback? onDeleteFile;
  final VoidCallback? onBack;
  final VoidCallback? onViewBastDocument;

  const PendingProjectDetail({
    super.key,
    required this.project,
    required this.vendors,
    required this.client,
    required this.projectManager,
    this.isAdmin = false,
    this.isClosing = false,
    this.isRejectClose = false,
    this.onAddBastDocument,
    this.fileName,
    this.onDeleteFile,
    this.onBack,
    this.onViewBastDocument,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 25,
        bottom: 10,
        top: 10,
      ),
      decoration: BoxDecoration(
        color: AssetColor.whiteBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      height: MediaQuery.sizeOf(context).height * 0.75,
      width: MediaQuery.sizeOf(context).width * 0.5,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    project.name ?? "name",
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    project.description ?? "description",
                    fontSize: 20,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const CustomText(
                    "Project Manager",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    projectManager.name ?? "name",
                    fontSize: 20,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            "Start Date",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AssetColor.orange,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: CustomText(
                              Helpers().convertDateStringFormat(
                                  project.startDate ?? ""),
                              color: AssetColor.whiteBackground,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            "End Date",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AssetColor.orange,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: CustomText(
                              Helpers().convertDateStringFormat(
                                  project.endDate ?? ""),
                              color: AssetColor.whiteBackground,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const CustomText(
                    "Client",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: AssetColor.greyBackground.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        client.image != null
                            ? Expanded(
                                child: Image.network(
                                  client.image!,
                                  height: 90,
                                ),
                              )
                            : const SizedBox(),
                        client.image != null
                            ? const SizedBox(
                                width: 15,
                              )
                            : const SizedBox(),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                project.clientName ?? "Client Name",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                client.address ?? "address",
                                fontSize: 20,
                              ),
                              CustomText(
                                client.phoneNumber ?? "email",
                                fontSize: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const CustomText(
                    "Vendor",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    itemCount: vendors.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      VendorDM vendorDM = vendors[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          color: AssetColor.greyBackground.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            vendorDM.image != null
                                ? Expanded(
                                    child: Image.network(
                                      vendorDM.image!,
                                      height: 90,
                                    ),
                                  )
                                : const SizedBox(),
                            vendorDM.image != null
                                ? const SizedBox(
                                    width: 15,
                                  )
                                : const SizedBox(),
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    vendorDM.name ?? "vendorDM Name",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomText(
                                    vendorDM.address ?? "address",
                                    fontSize: 20,
                                  ),
                                  CustomText(
                                    vendorDM.phoneNumber ?? "email",
                                    fontSize: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  isAdmin
                      ? isClosing
                          ? fileName?.isEmpty ?? true
                              ? CustomButton(
                                  text: "Add BAST Document",
                                  onPressed: onAddBastDocument,
                                )
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AssetColor.greyBackground
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.filePdf,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: CustomText(
                                          fileName ?? "",
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      IconButton(
                                        icon:
                                            const Icon(FontAwesomeIcons.xmark),
                                        iconSize: 20,
                                        onPressed: onDeleteFile,
                                      ),
                                    ],
                                  ),
                                )
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 15,
                              ),
                              decoration: BoxDecoration(
                                color: AssetColor.redButton,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.circleInfo,
                                    color: AssetColor.whiteBackground,
                                    applyTextScaling: true,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: CustomText(
                                      "This project has been rejected by Supervisor. Please delete or edit to Continue.",
                                      color: AssetColor.whiteBackground,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            )
                      : isClosing
                          ? CustomButton(
                              text: "See BAST Document",
                              onPressed: () {
                                if (onViewBastDocument != null) {
                                  onViewBastDocument!();
                                }
                              },
                            )
                          : const SizedBox(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(FontAwesomeIcons.xmark),
              onPressed: () {
                Get.back();
                if (onBack != null) {
                  onBack!();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
