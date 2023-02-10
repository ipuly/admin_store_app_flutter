// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:app_admin_toko/core/controllers/transaction_controller.dart';
import 'package:app_admin_toko/core/models/item_model.dart';
import 'package:app_admin_toko/views/pages/home/widgets/detail_transaction_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class TransactionItem extends StatelessWidget {
  // final TransactionsController transactionsController = Get.find();
  // final int index;
  const TransactionItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference invoiceCol = firestore.collection('invoice');
    return StreamBuilder<QuerySnapshot>(
      stream: invoice.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot invoice = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailTransactionItem(
                        id: snapshot.data!.docs[index].id,
                        date: invoice['date'],
                        total: invoice['totalPrice'],
                      ),
                    ),
                  );
                },
                child: Dismissible(
                  key: UniqueKey(),
                  onDismissed: (detail) {},
                  confirmDismiss: (direction) async {
                    bool confirm = false;
                    await showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const <Widget>[
                                Text(
                                    'Are you sure you want to delete this item?'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("No"),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                confirm = true;
                                Navigator.pop(context);
                              },
                              child: const Text("Yes"),
                            ),
                          ],
                        );
                      },
                    );
                    if (confirm) {
                      invoiceCol.doc(invoice.id).delete();
                      invoiceCol
                          .doc(invoice.id)
                          .collection('listItem')
                          .get()
                          .then((QuerySnapshot querySnapshot) {
                        querySnapshot.docs.forEach((doc) {
                          doc.reference.delete();
                        });
                      });
                      return Future.value(true);
                    }
                    return Future.value(false);
                  },
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 20,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.only(
                              right: 10.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.indigo.shade800,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SizedBox(
                              width: 35,
                              height: 35,
                              child: Center(
                                child: Text(
                                  (index + 1).toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Tanggal Transaksi",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  '${invoice['date']}',
                                  style: const TextStyle(
                                    color: Color(0xFF3D538F),
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "Total",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'Rp. ${invoice['totalPrice']}',
                                style: const TextStyle(
                                  color: Color(0xFF3D538F),
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text("No Transaction"),
          );
        }
      },
    );
  }
}
