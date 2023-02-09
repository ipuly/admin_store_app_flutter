import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference invoice = firestore.collection('invoice');

final firestoreInstance = FirebaseFirestore.instance;

void Collection() {
  firestoreInstance.collection('invoice').get().then((value) => {
        value.docs.forEach((result) {
          print(result.data());
        })
      });
}

void subCollection() {
  firestoreInstance.collection('invoice').get().then((value) {
    value.docs.forEach((result) {
      firestoreInstance
          .collection('invoice')
          .doc(result.id)
          .collection('listItem')
          .get()
          .then((subcol) {
        subcol.docs.forEach((element) {
          // print(result.data());
          print(element.data());
        });
      });
    });
  });
}
