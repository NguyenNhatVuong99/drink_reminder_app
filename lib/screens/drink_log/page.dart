// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class DrinkLogPage extends StatefulWidget {
  const DrinkLogPage({super.key});

  @override
  State<DrinkLogPage> createState() => _DrinkLogPageState();
}

class _DrinkLogPageState extends State<DrinkLogPage> {
  final databaseReference = FirebaseDatabase.instance.ref();

  int SplitDot(text) {
    String textToShow = text.substring(0, text.lastIndexOf('ml'));
    int number = int.parse(textToShow);
    return number;
  }

  String formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

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

  double calculateTotalVolume(filteredList) {
    double totalVolume = 0.0;
    for (var map in filteredList) {
      totalVolume += map['volume'];
    }
    return totalVolume;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Drink Log',
            style: TextStyle(color: Colors.white),
          ),
          leading: InkWell(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Color.fromARGB(255, 64, 223, 72),
        ),
        body: StreamBuilder(
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
              List dataReverserd = rawData['water_drink'];
              List data = dataReverserd.reversed.toList();
              // print(data);
              List dates = filterDate(data);
              // print(dates.length);
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1000,
                      color: Colors.grey[300],
                      child: ListView.builder(
                        itemCount: dates.length,
                        itemBuilder: (BuildContext context, index) {
                          List filteredList = data
                              .where((map) => map['date'] == dates[index])
                              .toList();

                          double value = 0.0;
                          double totalVolume =
                              calculateTotalVolume(filteredList);
                          if (totalVolume < 2500) {
                            value = totalVolume / 2500; 
                          } else {
                            value =
                                1.0; 
                          }

                          return Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                // color: Colors.grey[400],
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      value: value,
                                      strokeWidth: 4.0,
                                    ),
                                    Text(
                                      '${totalVolume} ml',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      dates[index],
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 5),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 2,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                                color: Colors.white,
                                child: ListView.builder(
                                    itemCount: filteredList.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'svgs/${filteredList[index]['icon']}',
                                              width: 48,
                                              height: 48,
                                            ),
                                            Text(
                                                '${filteredList[index]['volume']} ml'),
                                            Text(
                                                '${filteredList[index]['date']}')
                                          ],
                                        ),
                                      );
                                    }),
                              )
                            ],
                          );
                        },
                      )),
                ),
              );
            }));
  }
}
