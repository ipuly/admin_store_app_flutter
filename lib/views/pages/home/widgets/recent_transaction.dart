import 'package:app_admin_toko/core/controllers/transaction_controller.dart';
import 'package:app_admin_toko/core/models/item_model.dart';
import 'package:app_admin_toko/views/pages/home/widgets/transaction_detail.dart';
import 'package:app_admin_toko/views/pages/home/widgets/transaction_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentTransaction extends StatelessWidget {
  RecentTransaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(
          top: 50.0,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(45),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 0,
                top: 40,
                right: 25,
                left: 25,
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Recent Transactions",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFF3D538F),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext ctx) {
                          return TransactionDetail();
                        },
                        isScrollControlled: true,
                      );
                    },
                    child: const Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF3D538F),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TransactionItem(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
