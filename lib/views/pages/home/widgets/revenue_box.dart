import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RevenueBox extends StatelessWidget {
  const RevenueBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference revenue = firestore.collection('revenue');
    CollectionReference invoice = firestore.collection('invoice');
    return StreamBuilder<DocumentSnapshot>(
      stream: revenue.doc("TZMTT4qq8WtLngtFRtdT").snapshots(),
      builder: (context, snapshot) {
        return StreamBuilder<QuerySnapshot>(
          stream: invoice.snapshots(),
          builder: (context, snapshotIn) {
            if (snapshotIn.hasData) {
              var db = snapshotIn.data!.docs;
              double sum = 0;
              for (int i = 0; i < db.length; i++) {
                sum += (db[i]['totalPrice']);
                print(db[i]['totalPrice']);
              }
              revenue.doc("TZMTT4qq8WtLngtFRtdT").update(
                {
                  "revenue": sum.toString(),
                },
              );
              return Container(
                padding: const EdgeInsets.only(
                  top: 30.0,
                ),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      "Pendapatan Hari Ini",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Rp. ${snapshot.data!['revenue']}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            return CircularProgressIndicator();
          },
        );

        // return CircularProgressIndicator();
      },
    );
  }
}
