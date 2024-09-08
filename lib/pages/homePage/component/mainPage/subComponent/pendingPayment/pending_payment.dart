import 'package:flutter/widgets.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/homePage/component/mainPage/subComponent/pendingPayment/pending_payment_item_content.dart';
import 'package:project_management_thesis_app/repository/payment/dataModel/payment_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class PendingPayment extends StatelessWidget {
  final List<PaymentDM> pendingPayments;
  final Function(PaymentDM) showPendingDetail;
  final bool isPm;

  const PendingPayment({
    super.key,
    required this.pendingPayments,
    required this.showPendingDetail,
    this.isPm = false,
  });

  @override
  Widget build(BuildContext context) {
    return pendingPayments.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                isPm ? "Pending Rejected Payment" : "Pending Payment",
                color: AssetColor.blueTertiaryAccent,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: pendingPayments.length,
                  itemBuilder: (context, index) {
                    PaymentDM pendingPayment = pendingPayments[index];

                    return PendingPaymentItemContent(
                      pendingPayment: pendingPayment,
                      onPressed: () {
                        showPendingDetail(pendingPayment);
                      },
                      isAdmin: isPm,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )
        : const SizedBox();
  }
}
