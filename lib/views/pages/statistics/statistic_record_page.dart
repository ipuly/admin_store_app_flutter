// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:app_admin_toko/core/models/transactions_model.dart';
import 'package:app_admin_toko/views/pages/home/widgets/transaction_item.dart';
import 'package:app_admin_toko/views/widgets/app_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticRecord extends StatelessWidget {
  const StatisticRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppBarCustom(
            title: "Statistics",
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Builder(
                    builder: (context) {
                      final List<Map> chartData = [
                        {
                          "date": 1,
                          "income": 40.000,
                        },
                        {
                          "date": 10,
                          "income": 90.000,
                        },
                        {
                          "date": 11,
                          "income": 30.000,
                        },
                        {
                          "date": 20,
                          "income": 80.000,
                        },
                        {
                          "date": 21,
                          "income": 90.000,
                        },
                        {
                          "date": 30,
                          "income": 40.000,
                        },
                        {
                          "date": 31,
                          "income": 40.000,
                        },
                      ];

                      return Container(
                        color: Theme.of(context).cardColor,
                        padding: const EdgeInsets.all(12.0),
                        child: SfCartesianChart(
                          series: <ChartSeries>[
                            LineSeries<Map, int>(
                              dataSource: chartData,
                              xValueMapper: (Map data, _) => data["date"],
                              yValueMapper: (Map data, _) => data["income"],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
