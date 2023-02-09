// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:app_admin_toko/routes/route_manager.dart';
import 'package:app_admin_toko/core/view_models/user_view_model.dart';
import 'package:app_admin_toko/views/widgets/app_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppBarCustom(
            title: "Settings",
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    const CircleAvatar(
                      radius: 100.0,
                      backgroundImage: NetworkImage(
                        "https://i.ibb.co/S32HNjD/no-image.jpg",
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Card(
                      child: ListTile(
                        title: const Text("Logout"),
                        trailing: IconButton(
                          onPressed: () {
                            context
                                .read<UserViewModel>()
                                .logoutUserInUI(context);
                            Navigator.of(context)
                                .popAndPushNamed(RouteManager.loginPage);
                          },
                          icon: const Icon(
                            Icons.logout,
                            size: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
