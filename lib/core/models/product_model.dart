import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String name;
  String price;
  String stock;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
  });

  Map<String, String> toMap() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "stock": stock,
    };
  }

  static Product fromSnapshot(DocumentSnapshot snap) {
    Product product = Product(
      id: snap.id,
      name: snap["name"],
      price: snap["price"],
      stock: snap["stock"],
    );
    return product;
  }
}
