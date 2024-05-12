// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields, unused_field, unused_import

import 'package:flutter/material.dart';
import 'package:drink_reminder_app/screens/drink_report/month_chart.dart';
import 'package:drink_reminder_app/screens/drink_report/week_chart.dart';
import 'package:drink_reminder_app/screens/drink_report/year_chart.dart';

class DrinkReportPage extends StatefulWidget {
  const DrinkReportPage({super.key});

  @override
  State<DrinkReportPage> createState() => _DrinkReportPageState();
}

class _DrinkReportPageState extends State<DrinkReportPage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    WeekChartWidget(),
    MonthChartWidget(),
    YearChartWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: TabBar(
          indicatorColor: Color.fromARGB(255, 64, 223, 72),
          unselectedLabelColor: Colors.black,
          labelColor: Color.fromARGB(255, 64, 223, 72),
          tabs: [
            Tab(text: 'Week'),
            Tab(text: 'Month'),
            Tab(text: 'Year'),
          ],
        ),
        body: TabBarView(
          children: _tabs,
        ),
      ),
    );
  }
}
