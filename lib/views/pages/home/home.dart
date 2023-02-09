// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, prefer_typing_uninitialized_variables

import 'package:app_admin_toko/views/pages/home/widgets/header_home.dart';
import 'package:app_admin_toko/views/pages/home/widgets/main_menu_box.dart';
import 'package:app_admin_toko/views/pages/home/widgets/recent_transaction.dart';
import 'package:app_admin_toko/views/pages/home/widgets/revenue_box.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.indigo.shade800,
        ),
        child: Column(
          children: [
            HeaderHome(),
            RevenueBox(),
            MainMenuBox(),
            RecentTransaction(),
          ],
        ),
      ),
    );
  }
}
