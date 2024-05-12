// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class WeightReportPage extends StatefulWidget {
  const WeightReportPage({super.key});

  @override
  State<WeightReportPage> createState() => _WeightReportPageState();
}

class _WeightReportPageState extends State<WeightReportPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey[300],
        child: Center(
          child: Text('Weight report'),
        ));
  }
}
