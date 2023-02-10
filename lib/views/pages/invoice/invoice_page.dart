// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unnecessary_brace_in_string_interps

import 'package:app_admin_toko/core/models/quantity_model.dart';
import 'package:app_admin_toko/views/pages/invoice/add_invoice_page.dart';
import 'package:app_admin_toko/views/widgets/app_bar_custom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({Key? key}) : super(key: key);

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference invoice = firestore.collection('invoice');
    CollectionReference product = firestore.collection('products');

    double total = 0;

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: product.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const AppBarCustom(
                  title: "Invoice",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Add Item",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddInvoice(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.add,
                          size: 24.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, indeks) {
                        DocumentSnapshot item = snapshot.data!.docs[indeks];
                        if (item['select'] == true) {
                          var data = snapshot.data!.docs;
                          double sum = 0;
                          for (int i = 0; i < data.length; i++) {
                            sum += (data[i]["total"]);
                          }
                          total = sum;
                          return Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
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
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey[600],
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("No"),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blueGrey,
                                          ),
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
                                  return Future.value(true);
                                }
                                return Future.value(false);
                              },
                              child: Card(
                                child: Container(
                                  margin: const EdgeInsets.all(10.0),
                                  child: ListTile(
                                    leading: Container(
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
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Rp. ${item['price']}",
                                        ),
                                        Text(
                                          "Stock ${item['stock']}",
                                        ),
                                      ],
                                    ),
                                    trailing: Consumer<Quantity>(
                                      builder: (context, quantity, child) =>
                                          Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          item['quantity'] == 1
                                              ? Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[500],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Icon(Icons.remove,
                                                      color: Colors.white),
                                                )
                                              : InkWell(
                                                  onTap: () async {
                                                    await product
                                                        .doc(item.id)
                                                        .update(
                                                      {
                                                        'stock': FieldValue
                                                            .increment(1),
                                                        'quantity': FieldValue
                                                            .increment(-1),
                                                        'total': FieldValue
                                                            .increment(
                                                                -item['price'])
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: Colors.red[500],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: Icon(Icons.remove,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                          const SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            '${item['quantity']}',
                                          ),
                                          const SizedBox(
                                            width: 10.0,
                                          ),
                                          item['stock'] == 0
                                              ? Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[500],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Icon(Icons.add,
                                                      color: Colors.white),
                                                )
                                              : InkWell(
                                                  onTap: () async {
                                                    await product
                                                        .doc(item.id)
                                                        .update({
                                                      'stock':
                                                          FieldValue.increment(
                                                              -1),
                                                      'quantity':
                                                          FieldValue.increment(
                                                              1),
                                                      'total': item['price'] *
                                                          (item['quantity'] + 1)
                                                    });
                                                    quantity.hargaPlus =
                                                        item['price'] *
                                                            item['quantity'];
                                                  },
                                                  child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: Colors.green[500],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: Icon(Icons.add,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                          const SizedBox(
                                            width: 10.0,
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              await product
                                                  .doc(item.id)
                                                  .update({
                                                'select': false,
                                              });

                                              total -= item['price'] *
                                                  (item['quantity'] + 1);
                                            },
                                            icon: Icon(Icons.delete),
                                            color: Colors.red[500],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white),
                    onPressed: () async {
                      FirebaseFirestore.instance
                          .collection('products')
                          .get()
                          .then((snapshot) {
                        for (DocumentSnapshot ds in snapshot.docs) {
                          ds.reference.update(
                            {
                              'quantity': 0,
                              'select': false,
                              'total': 0,
                            },
                          );
                        }
                      });

                      DateTime dateNow = DateTime.now();

                      var result = await invoice.add({
                        'totalPrice': total,
                        "date": "${DateFormat('yyyy-MM-dd').format(dateNow)}",
                      });
                      setState(() {
                        total;
                      });

                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        if (snapshot.data!.docs[i]['select'] == true) {
                          await addSubInvoice(
                            result.id,
                            snapshot.data!.docs[i]['name'],
                            snapshot.data!.docs[i]['price'],
                            snapshot.data!.docs[i]['quantity'],
                          );
                        }
                      }
                    },
                    child: const Text("Save"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  height: 100,
                  child: Card(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Consumer<Quantity>(
                            builder: (context, price, child) => Text(
                              "Total Belanja : Rp. ${total}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
      //       floatingActionButton: FloatingActionButton.extended(
      //         backgroundColor: Colors.indigo,
      //         foregroundColor: Colors.white,
      //         label: Row(
      //           children: const [
      //             Icon(Icons.add),
      //             SizedBox(
      //               width: 5.0,
      //             ),
      //             Text("Add Item"),
      //           ],
      //         ),
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => AddInvoice()),
      //           );
      //         },
      //         //   floatingActionButton: StreamBuilder(
      //         //     stream: product.snapshots(),
      //         //     builder: (context, snapshot) {
      //         //       if (snapshot.hasData) {
      //         //         return Container(
      //         //           child: FloatingActionButton.extended(
      //         //             backgroundColor: Colors.indigo,
      //         //             foregroundColor: Colors.white,
      //         //             label: Row(
      //         //               children: const [
      //         //                 Icon(Icons.add),
      //         //                 SizedBox(
      //         //                   width: 5.0,
      //         //                 ),
      //         //                 Text("Add Item"),
      //         //               ],
      //         //             ),
      //         //             onPressed: () {
      //         //               showDialog(
      //         //                 context: context,
      //         //                 builder: (BuildContext context) {
      //         //                   return Dialog(
      //         //                     child: Container(
      //         //                       width: double.maxFinite,
      //         //                       height: 300,
      //         //                       child: ListView.builder(
      //         //                         itemCount: snapshot.data!.docs.length,
      //         //                         itemBuilder: (context, index) {
      //         //                           return Card(
      //         //                             child: ListTile(
      //         //                               title:
      //         //                                   Text(snapshot.data!.docs[index]["name"]),
      //         //                               subtitle: Column(
      //         //                                 crossAxisAlignment:
      //         //                                     CrossAxisAlignment.start,
      //         //                                 children: [
      //         //                                   Text(snapshot.data!.docs[index]["stock"]),
      //         //                                   Text(snapshot.data!.docs[index]["price"]),
      //         //                                 ],
      //         //                               ),
      //         //                               trailing: IconButton(
      //         //                                 onPressed: () async {
      //         //                                   await product
      //         //                                       .doc(snapshot.data!.docs[index].id)
      //         //                                       .update(
      //         //                                     {
      //         //                                       'select': true,
      //         //                                       'quantity': 1,
      //         //                                       "total": snapshot.data!.docs[index]
      //         //                                           ['total']
      //         //                                     },
      //         //                                   );
      //         //                                 },
      //         //                                 icon: const Icon(
      //         //                                   Icons.add,
      //         //                                   size: 24.0,
      //         //                                 ),
      //         //                                 color: Colors.indigo,
      //         //                               ),
      //         //                             ),
      //         //                           );
      //         //                         },
      //         //                       ),
      //         //                     ),
      //         //                   );
      //         //                 },
      //         //               );
      //         //             },
      //         //           ),
      //         //         );
      //         //       } else {
      //         //         return Container();
      //         //       }
      //         //     },
      //         //   ),
      //         // );
      //       )
    );
  }

  Future addSubInvoice(String id, String name, int price, int total) async {
    CollectionReference invoice =
        FirebaseFirestore.instance.collection('invoice');
    await invoice
        .doc(id)
        .collection('listItem')
        .add({'name': name, 'price': price, 'total': total});
  }
}
