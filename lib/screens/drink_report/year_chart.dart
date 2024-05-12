import 'package:flutter/material.dart';

class YearChartWidget extends StatefulWidget {
  const YearChartWidget({super.key});

  @override
  State<YearChartWidget> createState() => _YearChartWidgetState();
}

class _YearChartWidgetState extends State<YearChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Year Chart'),
    );
  }
}
