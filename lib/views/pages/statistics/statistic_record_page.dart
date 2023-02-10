import 'package:app_admin_toko/views/widgets/app_bar_custom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';

class StatisticRecord extends StatefulWidget {
  const StatisticRecord({Key? key}) : super(key: key);

  @override
  State<StatisticRecord> createState() => _StatisticRecordState();
}

class _StatisticRecordState extends State<StatisticRecord> {
  final streamChart = FirebaseFirestore.instance
      .collection('invoice')
      .orderBy('date', descending: false)
      .snapshots(includeMetadataChanges: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppBarCustom(
            title: "Statistics Record",
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Statistic Revenue Month',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(left: 15, right: 15),
              children: [
                StreamBuilder(
                  stream: streamChart,
                  builder: ((context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something wrong');
                    }
                    if (snapshot.data == null) {
                      return const Text('Empty wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Loading');
                    }
                    List<Map<String, dynamic>> listChart =
                        snapshot.data!.docs.map(
                      (e) {
                        String month = e.data()['date'].toString();
                        var income = e.data()['totalPrice'];
                        switch (month.split("-")[1]) {
                          case "01":
                            {
                              month = 'January';
                            }
                            break;
                          case "02":
                            {
                              month = 'February';
                            }
                            break;
                          case "03":
                            {
                              month = 'March';
                            }
                            break;
                          case "04":
                            {
                              month = 'April';
                            }
                            break;
                          case "05":
                            {
                              month = 'Mei';
                            }
                            break;
                          case "06":
                            {
                              month = 'Juni';
                            }
                            break;
                          case "07":
                            {
                              month = 'July';
                            }
                            break;
                          case "08":
                            {
                              month = 'Agustus';
                            }
                            break;
                          case "09":
                            {
                              month = 'September';
                            }
                            break;
                          case "10":
                            {
                              month = 'October';
                            }
                            break;
                          case "11":
                            {
                              month = 'November';
                            }
                            break;
                          case "12":
                            {
                              month = 'December';
                            }
                            break;
                        }
                        return {
                          'domain': month,
                          'measure': income,
                        };
                      },
                    ).toList();
                    List<String> month = [
                      '05',
                      '02',
                      '03',
                      '04',
                      '01',
                      '06',
                      '07',
                      '08',
                      '09',
                      '10',
                      '11',
                      '12',
                    ];
                    month.sort();
                    return AspectRatio(
                      aspectRatio: 10.5 / 20,
                      child: DChartBar(
                        verticalDirection: false,
                        data: [
                          {
                            'id': 'Bar',
                            'data': listChart,
                          }
                        ],
                        animationDuration: const Duration(milliseconds: 600),
                        barColor: ((barData, index, id) => Colors.indigo),
                        showBarValue: true,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
