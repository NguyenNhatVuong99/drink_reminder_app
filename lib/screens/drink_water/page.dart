// ignore_for_file: unnecessary_const, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:drink_reminder_app/widget/ProgressBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'dart:collection';

class DrinkWaterPage extends StatefulWidget {
  const DrinkWaterPage({super.key});

  @override
  State<DrinkWaterPage> createState() => _DrinkWaterPageState();
}

class _DrinkWaterPageState extends State<DrinkWaterPage> {
  final databaseReference = FirebaseDatabase.instance.ref();
  String _currentIcon = '200ml.svg';
  int _currentId = 0;
  List currentData = [];

  void handlePrint() {
    print(databaseReference);
  }

  List<String> water_volume = [
    '200ml.svg',
    '300ml.svg',
    '400ml.svg',
    '500ml.svg',
    '600ml.svg',
    '700ml.svg',
    '800ml.svg',
    '900ml.svg'
  ];

  int SplitDot(text) {
    String textToShow = text.substring(0, text.lastIndexOf('ml'));
    int number = int.parse(textToShow);
    return number;
  }

  int calculateTotalVolume(List<dynamic> data) {
    int totalVolume = 0;
    for (var data in data) {
      int volume = data['volume'] ?? 0;
      totalVolume += volume;
    }
    return totalVolume;
  }

  String todayFormatted = DateFormat('dd/MM/yyyy').format(DateTime.now());

  dynamic FilterData(data) {
    List<Map<dynamic, dynamic>> filteredData = [];
    for (dynamic item in data) {
      if (item['date'] == todayFormatted) filteredData.add(item);
    }
    return filteredData;
  }

  // void filterDate(data) {
  //   List<String> uniqueDates = [];
  //   for (var item in data) {
  //     for (var item in data) {
  //       if (!uniqueDates.contains(item['date'])) {
  //         uniqueDates.add(item['date']);
  //       }
  //     }
  //   }
  //   print(uniqueDates);
  // }

  void addData(currentData, data) {
    currentData.add(data);
    databaseReference.child('water_drink').set(currentData);
    // databaseReference.child('water_drink').push().set(data);
  }

  void updateData(currentData) {
    databaseReference.child('water_drink').set(currentData);
  }

  Future<void> _dialogBuilder(BuildContext context, String product) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('ok'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: databaseReference.onValue,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }

            final dynamic rawData = snapshot.data?.snapshot.value;
            // print(rawData);
            if (rawData == null || !(rawData is Map)) {
              return Text('Data is not available or invalid.');
            }
            List data = rawData['water_drink'];
            // print(data);
            currentData = data;
            _currentId = data.length;
            List<Map> todayData = FilterData(data);
            int totalVolume = calculateTotalVolume(todayData);
            double progress = 0.0;
            if (totalVolume / 2500 < 1.0) {
              progress = totalVolume / 2500;
            } else {
              progress = 1.0;
            }
            // filterDate(data);
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 130,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 10, left: 30, right: 30, top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'DRINK TARGET',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${totalVolume} /2500 ml',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: InkWell(
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.green,
                                                  size: 16,
                                                ),
                                                onTap: () {},
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ProgressBar(progress: progress)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 400,
                              // color: Colors.red,
                              child: GridView.count(
                                crossAxisCount: 4,
                                children:
                                    List.generate(todayData.length, (index) {
                                  dynamic dataPoint = todayData[index];
                                  return InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            List<String> options = [
                                              '200',
                                              '300',
                                              '400',
                                              '500',
                                              '600',
                                              '700',
                                              '800',
                                              '900'
                                            ];
                                            String currentOption =
                                                '${dataPoint['volume']}';
                                            return AlertDialog(
                                              title: Text('Edit Volume'),
                                              content: DropdownButton<String>(
                                                value: currentOption,
                                                onChanged: (value) {
                                                  currentOption = '${value}';
                                                },
                                                items: options.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                              actions: <Widget>[
                                                InkWell(
                                                  onTap: () {
                                                    int? duplicateIndex;
                                                    for (int i = 0;
                                                        i < currentData.length;
                                                        i++) {
                                                      if (currentData[i]
                                                              ['id'] ==
                                                          dataPoint['id']) {
                                                        duplicateIndex = i;
                                                        if (duplicateIndex !=
                                                            null) {
                                                          Map modifiedMap =
                                                              currentData[
                                                                  duplicateIndex];

                                                          modifiedMap[
                                                                  'volume'] =
                                                              int.parse(
                                                                  currentOption);
                                                          modifiedMap['icon'] =
                                                              '${currentOption}ml.svg';

                                                          currentData[
                                                                  duplicateIndex] =
                                                              modifiedMap;
                                                          updateData(
                                                              currentData);
                                                        }
                                                        break;
                                                      }
                                                    }
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Edit'),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    int? duplicateIndex;
                                                    for (int i = 0;
                                                        i < currentData.length;
                                                        i++) {
                                                      if (currentData[i]
                                                              ['id'] ==
                                                          dataPoint['id']) {
                                                        duplicateIndex = i;
                                                        if (duplicateIndex !=
                                                            null) {
                                                          currentData.removeAt(
                                                              duplicateIndex);
                                                        }
                                                        updateData(currentData);
                                                      }
                                                    }
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Delete'),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Close'),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(8.0),
                                      padding: EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                          'svgs/${dataPoint['icon']}'),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 74,
                    // color: Colors.amber,
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.height,
                          // color: Colors.red,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 6,
                          height: MediaQuery.of(context).size.height,
                          // color: Colors.orange,
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                Scaffold.of(context).showBottomSheet((context) {
                                  return Container(
                                    height: 100,
                                    color: Colors.grey[200],
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: water_volume
                                          .map((
                                            item,
                                          ) =>
                                              Container(
                                                width: 72,
                                                height: 72,
                                                margin: EdgeInsets.all(8),
                                                // color: Colors.blue,
                                                child: Center(
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text('${SplitDot(item)}'),
                                                    InkWell(
                                                      child: SvgPicture.asset(
                                                        'svgs/$item',
                                                        width: 48,
                                                        height: 48,
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          _currentIcon = item;
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                    )
                                                  ],
                                                )),
                                              ))
                                          .toList(),
                                    ),
                                  );
                                });
                              },
                              child: SvgPicture.asset(
                                'svgs/$_currentIcon',
                                width: 48,
                                height: 48,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Map data = {
            'id': '$_currentId',
            'volume': SplitDot(_currentIcon),
            'icon': '$_currentIcon',
            'date': '${todayFormatted}'
          };
          addData(currentData, data);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow[400],
        elevation: 8.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
