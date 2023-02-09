import 'package:get/get.dart';
import 'package:app_admin_toko/core/models/transactions_model.dart';
import 'package:app_admin_toko/core/services/services_api.dart';

class TransactionsController extends GetxController {
  final FireStoreDB fireStoreDB = FireStoreDB();

  var invoice = <Invoice>[].obs;

  var newInvoice = {}.obs;

  @override
  void onInit() {
    invoice.bindStream(FireStoreDB().getAllInvoice());
    super.onInit();
  }
}
