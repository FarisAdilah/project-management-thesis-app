import 'package:project_management_thesis_app/repository/payment/dataModel/payment_dm.dart';
import 'package:project_management_thesis_app/repository/payment/firebaseModel/payment_firebase.dart';
import 'package:project_management_thesis_app/services/repo_base.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

class PaymentRepository with RepoBase {
  static PaymentRepository get instance => PaymentRepository();

  Future<List<PaymentDM>> getAllPayment() async {
    List collection = await getDataCollection(CollectionType.payments.name);

    List<PaymentFirebase> paymentList = [];
    for (var element in collection) {
      PaymentFirebase payment = PaymentFirebase.fromFirestoreList(element);
      paymentList.add(payment);
    }

    List<PaymentDM> paymentListDM = [];
    for (var payment in paymentList) {
      PaymentDM paymentDM = PaymentDM();
      paymentDM.id = payment.id;
      paymentDM.clientName = payment.clientName;
      paymentDM.paymentAmount = payment.amount;
      paymentDM.paymentName = payment.name;
      paymentDM.vendorName = payment.vendorName;

      paymentListDM.add(paymentDM);
    }

    return paymentListDM;
  }

  Future<List<PaymentDM>> getMultiplePayment(List<String> ids) async {
    List<PaymentDM> paymentListDM = [];

    for (var id in ids) {
      PaymentDM paymentDM = await getPaymentById(id);
      paymentListDM.add(paymentDM);
    }

    return paymentListDM;
  }

  Future<PaymentDM> getPaymentById(String id) async {
    var data = await getDataDocument(CollectionType.payments.name, id);
    PaymentFirebase payment = PaymentFirebase.fromFirestoreDoc(data);

    PaymentDM paymentDM = PaymentDM();
    paymentDM.id = payment.id;
    paymentDM.clientName = payment.clientName;
    paymentDM.paymentAmount = payment.amount;
    paymentDM.paymentName = payment.name;
    paymentDM.vendorName = payment.vendorName;

    return paymentDM;
  }
}
