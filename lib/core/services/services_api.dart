import 'package:app_admin_toko/core/models/product_model.dart';
import 'package:app_admin_toko/core/models/transactions_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreDB {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addData(Product productModel) {
    return _firebaseFirestore.collection("products").add(productModel.toMap());
  }

  Stream<List<Product>> getAllProducts() {
    return _firebaseFirestore
        .collection("products")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  Future<void> updateData(Product updatedProduct, String id) {
    return _firebaseFirestore
        .collection("products")
        .doc(id)
        .update(updatedProduct.toMap());
    // .get().then(
    //       (QuerySnapshot) => {QuerySnapshot.get()},
    // );
  }

  Future<void> deleteProduct(Product deletedProduct, String id) {
    return _firebaseFirestore.collection("product").doc(id).delete();
  }

  Stream<List<Invoice>> getAllInvoice() {
    return _firebaseFirestore.collection("invoice").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Invoice.fromSnapshot(doc)).toList();
    });
  }

  Future<String> addInvoice(Map<String, dynamic> data) {
    return _firebaseFirestore
        .collection("invoice")
        .add(data)
        .then((value) => value.id);
  }

  Future addSubInvoice(ListItem listItemModel, String id) {
    return _firebaseFirestore
        .collection("Invoice")
        .doc(id)
        .collection("listItem")
        .add(listItemModel.toMap());
  }
}
