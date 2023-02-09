// ignore_for_file: constant_identifier_names

import 'package:app_admin_toko/views/pages/home/home.dart';
import 'package:app_admin_toko/views/pages/products/product_page.dart';
import 'package:app_admin_toko/views/pages/settings/settings_page.dart';
import 'package:app_admin_toko/views/pages/auth/login_page.dart';
import 'package:app_admin_toko/views/pages/loading/loading_page.dart';
import 'package:app_admin_toko/views/pages/statistics/statistic_record_page.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static const String loadingPage = "/";
  static const String loginPage = "/login";
  static const String homePage = "/home";
  static const String productPage = "/product";
  static const String statisticPage = "/statistic";
  static const String settingPage = "/profile";

  static Route<dynamic>? onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case loadingPage:
        return MaterialPageRoute(
          builder: (context) => const LoadingPage(),
        );
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case homePage:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );

      case productPage:
        return MaterialPageRoute(
          builder: (context) => const ProductPage(),
        );
      case '/productPage':
        return MaterialPageRoute(builder: (_) => ProductPage());
      case statisticPage:
        return MaterialPageRoute(
          builder: (context) => const StatisticRecord(),
        );
      case settingPage:
        return MaterialPageRoute(
          builder: (context) => const SettingPage(),
        );

      default:
        throw Exception("No Route Found");
    }
  }
}
