import 'package:app_admin_toko/views/pages/home/widgets/menu_box_widget.dart';
import 'package:app_admin_toko/views/pages/invoice/invoice_page.dart';
import 'package:app_admin_toko/views/pages/products/product_page.dart';
import 'package:app_admin_toko/views/pages/statistics/statistic_record_page.dart';
import 'package:flutter/material.dart';

class MainMenuBox extends StatelessWidget {
  const MainMenuBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 30.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          MenuWidget(
            icon: Icons.show_chart,
            text: "Statistics",
            link: StatisticRecord(),
          ),
          MenuWidget(
            icon: Icons.emoji_food_beverage,
            text: "Products",
            link: ProductPage(),
          ),
          MenuWidget(
            icon: Icons.add_shopping_cart,
            text: "Invoice",
            link: InvoicePage(),
          ),
        ],
      ),
    );
  }
}
