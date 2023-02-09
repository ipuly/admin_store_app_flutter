// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:app_admin_toko/misc/constants.dart';
import 'package:app_admin_toko/misc/validators.dart';
import 'package:app_admin_toko/core/view_models/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<UserViewModel>().loginFormKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              validator: validateEmail,
              controller: emailController,
              decoration: formDecoration(
                'Email Address',
                Icons.mail_outline,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              validator: validatePassword,
              controller: passwordController,
              decoration: formDecoration(
                'Password',
                Icons.lock_outline,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            CupertinoButton(
              borderRadius: const BorderRadius.all(
                Radius.circular(20.0),
              ),
              color: Colors.indigo,
              child: const Text("Login"),
              onPressed: () {
                context.read<UserViewModel>().loginUserInUI(
                      context,
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
              },
            )
          ],
        ),
      ),
    );
  }
}
