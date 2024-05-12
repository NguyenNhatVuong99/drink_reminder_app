// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, non_constant_identifier_names, prefer_final_fields, unused_field, unused_element

import 'dart:js';

import 'package:drink_reminder_app/widget/CircleButton.dart';
import 'package:flutter/material.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  bool _isContainerEnabled = true;
  double _currentVolume = 50;

  Color _boardColor = Colors.green;
  String _currentStateName = 'Auto reminders';

  void _changeBoardState(Color color, String title) {
    setState(() {
      _boardColor = color;
      _currentStateName = title;
    });
  }

  void showVolumeDiaLog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reminder volume'),
          content: Container(
            width: 300,
            height: 40,
            child: Slider(
              value: _currentVolume,
              divisions: 5,
              max: 100,
              label: _currentVolume.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentVolume = value;
                });
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic dialog title'),
          content: const Text(
            'The reminder will remind you at fixed times'
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('APPLY'),
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                color: _boardColor,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      child: InkWell(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      top: 10,
                      left: 10,
                    ),
                    Positioned(
                        child: Text(
                      _currentStateName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    Positioned(
                      child: Padding(
                        padding:
                            EdgeInsets.only(bottom: 10, left: 20, right: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          // color: Colors.blue,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleButton(
                                icon: Icons.notifications_off,
                                onPressed: () => _changeBoardState(
                                    Colors.red, 'Reminder is turned off'),
                                isCorect: _boardColor == Colors.red,
                                iconColor: Colors.red,
                              ),
                              CircleButton(
                                icon: Icons.notifications_paused_outlined,
                                onPressed: () => _changeBoardState(
                                    Colors.orange, 'No reminders'),
                                isCorect: _boardColor == Colors.orange,
                                iconColor: Colors.orange,
                              ),
                              CircleButton(
                                icon: Icons.volume_mute,
                                onPressed: () => _changeBoardState(
                                    Colors.yellowAccent.shade400, 'Mute'),
                                isCorect:
                                    _boardColor == Colors.yellowAccent.shade400,
                                iconColor: Colors.yellowAccent.shade400,
                              ),
                              CircleButton(
                                icon: Icons.notifications_active,
                                onPressed: () => _changeBoardState(
                                    Colors.green, 'Auto Reminders'),
                                isCorect: _boardColor == Colors.green,
                                iconColor: Colors.green,
                              ),
                            ],
                          ),
                        ),
                      ),
                      left: 20,
                      bottom: 10,
                      right: 20,
                    )
                  ],
                )),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.orange,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: _boardColor != Colors.red,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 50,
                            height: 120,
                            // color: Colors.red,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Reminders times',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    InkWell(
                                      child: Icon(
                                        Icons.mode_edit_outline,
                                        color: Colors.green,
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  '9:00 - 21:00',
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'every 60 minutes',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: InkWell(
                                    onTap: () {
                                      _dialogBuilder(context);
                                    },
                                    child: Text(
                                      'MANUALLY SET REMINDERS',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.green),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: Colors.grey[300],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "Reminder sound",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: Colors.grey[300],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                showVolumeDiaLog(context);
                              },
                              child: Text('Reminder volumne',
                                  style: TextStyle(color: Colors.grey)),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: Colors.grey[300],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Reminder does not work?',
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
