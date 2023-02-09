// ignore_for_file:prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, prefer_typing_uninitialized_variables

import 'package:app_admin_toko/views/pages/auth/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static void showNotif(BuildContext context, String msg) {
    final snackBar = SnackBar(
      backgroundColor: Theme.of(context).errorColor,
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logo.png",
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    "TOKO ABC",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Center(
                      child: SingleChildScrollView(
                        child: LoginForm(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
