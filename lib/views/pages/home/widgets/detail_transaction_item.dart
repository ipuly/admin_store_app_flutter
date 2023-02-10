// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps

import 'package:app_admin_toko/views/widgets/app_bar_custom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailTransactionItem extends StatefulWidget {
  final id;
  final date;
  final total;
  const DetailTransactionItem({
    Key? key,
    this.id,
    this.date,
    this.total,
  }) : super(key: key);

  @override
  State<DetailTransactionItem> createState() => _DetailTransactionItemState();
}

class SubCollectionData {
  late final String subCollectionName;
  late final String subCollectionData;

  SubCollectionData(
      {required this.subCollectionName, required this.subCollectionData});
}

final firestoreInstance = FirebaseFirestore.instance;

class _DetailTransactionItemState extends State<DetailTransactionItem> {
  CollectionReference invoice = firestoreInstance.collection('invoice');

  get id => widget.id;
  String get date => widget.date;
  double get total => widget.total;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('invoice/${id}/listItem')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Column(
              children: [
                AppBarCustom(
                  title: "Detail",
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Invoice",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text("Tanggal Belanja: ${date}"),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Barang"),
                                  Text("Harga")
                                ],
                              ),
                              SizedBox(height: 10),
                              ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var data = snapshot.data!.docs[index];
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '${data['name']}   X${data['total']}',
                                      ),
                                      Text(
                                        'Rp. ${data['price']}',
                                      ),
                                    ],
                                  );
                                },
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 10),
                              StreamBuilder<QuerySnapshot>(
                                  stream: invoice.snapshots(),
                                  builder: (context, snapshot) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Total",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text("Rp. ${total}"),
                                      ],
                                    );
                                  }),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
