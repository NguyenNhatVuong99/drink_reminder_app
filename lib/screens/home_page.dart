// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, unused_import

import 'package:flutter/material.dart';
import 'package:drink_reminder_app/screens/drink_water/page.dart';
import 'package:drink_reminder_app/screens/drink_log/page.dart';
import 'package:drink_reminder_app/screens/drink_report/page.dart';
import 'package:drink_reminder_app/screens/weight_report/page.dart';
import 'package:drink_reminder_app/screens/reminders/page.dart';
import 'package:drink_reminder_app/screens/settings/page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    DrinkWaterPage(),
    DrinkReportPage(),
    WeightReportPage(),
  ];
  static const List<Widget> _titleOptions = <Widget>[
    Text(
      'Menu',
    ),
    Text(
      'Drink report',
    ),
    Text(
      'Weight report',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titleOptions[_selectedIndex],
        backgroundColor: Color.fromARGB(255, 64, 223, 72),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: InkWell(
              child: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReminderPage()),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: InkWell(
              child: Icon(
                Icons.calendar_month,
                color: Colors.white,
              ),
              onTap: () {},
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 5),
            child: InkWell(
              child: Icon(
                Icons.add_box,
                color: Colors.white,
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(' '),
            ),
            ListTile(
              title: const Text('Drink Water'),
              leading: Icon(Icons.local_cafe_rounded),
              selected: _selectedIndex == 0,
              selectedColor: Colors.green,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Drink log'),
              leading: Icon(Icons.format_list_bulleted_outlined),
              selectedColor: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DrinkLogPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Drink Report'),
              leading: Icon(Icons.analytics),
              selected: _selectedIndex == 1,
              selectedColor: Colors.green,
              onTap: () {
                _onItemTapped(1);

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Weight report'),
              leading: Icon(Icons.timelapse_sharp),
              selected: _selectedIndex == 2,
              selectedColor: Colors.green,
              onTap: () {
                _onItemTapped(2);

                Navigator.pop(context);
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[300],
              ),
            ),
            ListTile(
              title: const Text('Reminders'),
              leading: Icon(Icons.notifications),
              selectedColor: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReminderPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Settings'),
              leading: Icon(Icons.settings),
              selectedColor: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Water Pro'),
              leading: Icon(Icons.upgrade),
              selectedColor: Colors.green,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
