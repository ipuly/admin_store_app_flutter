// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:app_admin_toko/views/widgets/app_bar_custom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddInvoice extends StatefulWidget {
  const AddInvoice({Key? key}) : super(key: key);

  @override
  State<AddInvoice> createState() => _AddInvoiceState();
}

TextEditingController inputNama = TextEditingController();
TextEditingController inputTanggal = TextEditingController();
TextEditingController itemBeli = TextEditingController();
TextEditingController total = TextEditingController();

class _AddInvoiceState extends State<AddInvoice> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference product = firestore.collection('products');
    return Scaffold(
      body: Column(
        children: [
          const AppBarCustom(
            title: "Add Item to Cart",
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: product.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot item = snapshot.data!.docs[index];
                          return Card(
                            child: ListTile(
                              leading: Container(
                                // color: Colors.indigo,
                                decoration: const BoxDecoration(
                                  color: Colors.indigo,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                width: 50,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    item["name"][0],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(item['name']),
                              subtitle: item['stock'] == 0
                                  ? const Text(
                                      "Empty Stock",
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    )
                                  : Text(
                                      "Stock ${item['stock']}",
                                    ),
                              trailing: item['stock'] == 0
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.red,
                                        size: 24,
                                      ),
                                      onPressed: () {},
                                    )
                                  : IconButton(
                                      onPressed: () async {
                                        await product.doc(item.id).update({
                                          'select': true,
                                          'quantity': 1,
                                          // 'stock': FieldValue.increment(-1),
                                          "total": item['price']
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        size: 24.0,
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
