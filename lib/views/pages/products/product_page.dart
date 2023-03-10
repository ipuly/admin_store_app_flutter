// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings

import 'package:app_admin_toko/views/widgets/app_bar_custom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  String name = "";
  String price = "";
  String stock = "";

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference product = firestore.collection('products');
    return Scaffold(
      body: Column(
        children: [
          const AppBarCustom(
            title: "Products",
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: product.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.indigo,
                      ),
                    );
                  }
                  final data = snapshot.requireData;
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (150.0 / 250.0),
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.indigo,
                                      foregroundColor: Colors.white,
                                      radius: 80,
                                      child: Text(data.docs[index]["name"]),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                "Stock ${data.docs[index]['stock']}",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                data.docs[index]["name"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "Rp. ${data.docs[index]["price"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      final _formKey = GlobalKey<FormState>();
                                      nameController.text =
                                          data.docs[index]["name"];
                                      priceController.text =
                                          data.docs[index]["price"].toString();
                                      stockController.text =
                                          data.docs[index]["stock"].toString();
                                      // int stock = 0;
                                      showDialog(
                                          context: context,
                                          builder: (builder) {
                                            return AlertDialog(
                                              title: Text("Edit Product"),
                                              content: Form(
                                                key: _formKey,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    TextFormField(
                                                      controller:
                                                          nameController,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Name",
                                                        labelText: "Name",
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          priceController,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Price",
                                                        labelText: "Price",
                                                      ),
                                                      keyboardType:
                                                          TextInputType.number,
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          stockController,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Stock",
                                                        labelText: "Stock",
                                                      ),
                                                      keyboardType:
                                                          TextInputType.number,
                                                    ),
                                                    const SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        await product
                                                            .doc(data
                                                                .docs[index].id)
                                                            .update({
                                                          'name': nameController
                                                              .text,
                                                          'price': int.parse(
                                                              priceController
                                                                  .text),
                                                          'stock': int.parse(
                                                              stockController
                                                                  .text),
                                                        });

                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text("Update"),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: const Text("Update"),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    onPressed: () async {
                                      await product
                                          .doc(data.docs[index].id)
                                          .delete();
                                    },
                                    child: const Text(
                                      "Delete",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          final _formKey = GlobalKey<FormState>();
          showDialog(
            context: context,
            builder: (builder) {
              return AlertDialog(
                title: Text("Add Product"),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Name",
                          labelText: "Name",
                        ),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          price = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Price",
                          labelText: "Price",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          stock = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Stock",
                          labelText: "Stock",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          var docid = await product.add({
                            "name": name,
                            "price": int.parse(price),
                            "stock": int.parse(stock),
                            "quantity": 0,
                            "total": 0,
                            "select": false,
                            "date": "${DateTime.now()}",
                          }).then((value) => value.id);
                          product.doc(docid).set(
                            {"id": docid},
                            SetOptions(
                              merge: true,
                            ),
                          );
                          setState(
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                        child: const Text("Send"),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
