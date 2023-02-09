import 'package:app_admin_toko/routes/route_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductViewModel with ChangeNotifier {
  FirebaseAuth authInstance = FirebaseAuth.instance;

  void showProduct(BuildContext context) {
    Navigator.of(context).popAndPushNamed(RouteManager.productPage);
  }
}
