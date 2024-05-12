// ignore_for_file: prefer_const_constructors

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:drink_reminder_app/utils/progess.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekChartWidget extends StatefulWidget {
  const WeekChartWidget({super.key});

  @override
  State<WeekChartWidget> createState() => _WeekChartWidgetState();
}

class _WeekChartWidgetState extends State<WeekChartWidget> {
  final databaseReference = FirebaseDatabase.instance.ref();

  List filterDate(data) {
    List<String> uniqueDates = [];
    for (var item in data) {
      for (var item in data) {
        if (!uniqueDates.contains(item['date'])) {
          uniqueDates.add(item['date']);
        }
      }
    }
    return uniqueDates;
  }

  List CalculateVolumesByDate(data, dates) {
    List<double> volumes = [];
    for (var date in dates) {
      double totalVolume = 0.0;
      for (var map in data) {
        if (map['date'] == date) {
          totalVolume += map['volume'];
        }
      }
      volumes.add(totalVolume);
    }
    return volumes;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: StreamBuilder(
            stream: databaseReference.onValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }

              final dynamic rawData = snapshot.data?.snapshot.value;
              if (rawData == null || !(rawData is Map)) {
                return Text('Data is not available or invalid.');
              }
              // print(rawData['water_drink'].runtimeType);
              List data = rawData['water_drink'];
              List dates = filterDate(data);
              // print('dates = ${dates}');
              List volumes = CalculateVolumesByDate(data, dates);
              // print('volumes = ${volumes}');

              int _getVolumeForDate(String date) {
                int index = dates.indexOf(date);
                if (index != -1) {
                  return volumes[index];
                }
                return 0;
              }

              List<Map<String, dynamic>> _prepareData() {
                List<Map<String, dynamic>> preparedData = [];
                DateTime now = DateTime.now();

                for (int i = 6; i >= 0; i--) {
                  DateTime date = now.subtract(Duration(days: i));
                  String formattedDate = DateFormat("dd/MM/yyyy").format(date);
                  int volume = _getVolumeForDate(formattedDate);
                  preparedData.add({"date": formattedDate, "volume": volume});
                }
                return preparedData;
              }

              Widget _buildChart() {
                List<charts.Series<Map<String, dynamic>, String>> series = [
                  charts.Series(
                    id: "Volume",
                    data: _prepareData(),
                    domainFn: (datum, _) => datum["date"],
                    measureFn: (datum, _) => datum["volume"],
                  )
                ];

                return charts.BarChart(
                  series,
                  animate: true,
                );
              }

              return Container(
                width: MediaQuery.of(context).size.width,
                height: 1000,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 2,
                ),
                color: Colors.grey[300],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: _buildChart(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 350,
                        color: Colors.white,
                        child: ProgressCalendar(dates: dates,volumes: volumes,days: 7,),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
