import 'package:cloud_firestore/cloud_firestore.dart';

class Invoice {
  final String id;
  final String date;
  final String totalPrice;

  Invoice({
    required this.id,
    required this.date,
    required this.totalPrice,
  });

  Map<String, String> toMap() {
    return {"id": id, "date": date, "totalPrice": totalPrice};
  }

  static Invoice fromSnapshot(DocumentSnapshot snap) {
    Invoice invoice = Invoice(
      id: snap.id,
      date: snap["date"],
      totalPrice: snap["totalPrice"],
    );
    return invoice;
  }
}

class ListItem {
  final String name;
  final String price;
  final String total;

  ListItem({
    required this.name,
    required this.price,
    required this.total,
  });

  Map<String, String> toMap() {
    return {
      "name": name,
      "price": price,
      "total": total,
    };
  }

  static ListItem fromSnapshot(DocumentSnapshot snap) {
    ListItem listItem = ListItem(
      name: snap["name"],
      price: snap["price"],
      total: snap["total"],
    );
    return listItem;
  }
}
