// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:app_admin_toko/core/controllers/transaction_controller.dart';
import 'package:app_admin_toko/views/pages/home/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionDetail extends StatelessWidget {
  // final transactionsController = Get.put(TransactionsController());
  TransactionDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 30.0,
                bottom: 10.0,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                    ),
                  ),
                  const Text(
                    "Recent Transactions",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFF3D538F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TransactionItem(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
