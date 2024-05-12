// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProgressCalendar extends StatelessWidget {
  final List dates;
  final List volumes;
  final int days;
  ProgressCalendar(
      {required this.dates, required this.volumes, required this.days});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> preparedData = [];
    DateTime now = DateTime.now();
    List<Map<String, dynamic>> dataToChart =
        List.generate(dates.length, (index) {
      return {"date": dates[index], "volume": volumes[index]};
    });
    int _getVolumeForDate(String date) {
      int index = dates.indexOf(date);
      if (index != -1) {
        return volumes[index];
      }
      return 0;
    }

    for (int i = days - 1; i >= 0; i--) {
      DateTime date = now.subtract(Duration(days: i));
      String formattedDate = DateFormat("dd/MM/yyyy").format(date);
      int volume = _getVolumeForDate(formattedDate);
      preparedData.add({"date": formattedDate, "volume": volume});
    }

    return Container(
      padding: EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
        ),
        itemCount: preparedData.length,
        itemBuilder: (context, index) {
          double progress = 0.0;
          if (preparedData[index]['volume'] < 2500) {
            progress = preparedData[index]['volume'] / 2500;
          } else {
            progress = 1.0;
          }
          return DayProgressIndicator(day:  preparedData[index]['date'], progress: progress);
        },
      ),
    );
  }
}

class DayProgressIndicator extends StatelessWidget {
  final String day;
  final double progress;

  DayProgressIndicator({required this.day, required this.progress});

  @override
  Widget build(BuildContext context) {
    List<String> parts = day.split("/");
    String formattedDay = parts[0];
    return Container(
      width: 50.0,
      height: 50.0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Text(
              '$formattedDay',
            ),
          ),
          CircularProgressIndicator(
            value: progress, // Convert progress to a value between 0 and 1
            strokeWidth: 3.0,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ],
      ),
    );
  }
}
