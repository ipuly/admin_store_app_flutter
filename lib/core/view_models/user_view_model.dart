// ignore_for_file: use_build_context_synchronously

import 'package:app_admin_toko/views/pages/auth/login_page.dart';
import 'package:app_admin_toko/routes/route_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserViewModel with ChangeNotifier {
  FirebaseAuth authInstance = FirebaseAuth.instance;
  final loginFormKey = GlobalKey<FormState>();

  void loginUserInUI(BuildContext context,
      {required String email, required String password}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (loginFormKey.currentState?.validate() ?? false) {
      try {
        await authInstance.signInWithEmailAndPassword(
            email: email, password: password);
        Navigator.of(context).popAndPushNamed(RouteManager.homePage);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          LoginPage.showNotif(context, "No user found for that email.");
        }
        if (e.code == 'wrong-password') {
          LoginPage.showNotif(context, "Wrong Password.");
        }
      } catch (e) {
        LoginPage.showNotif(context, "Something went wrong please try again");
      }
      notifyListeners();
    }
  }

  void logoutUserInUI(BuildContext context) async {
    await authInstance.signOut();
    notifyListeners();
  }
}
