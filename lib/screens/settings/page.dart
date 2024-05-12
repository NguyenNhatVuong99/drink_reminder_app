// ignore_for_file: prefer_const_constructors

import 'package:drink_reminder_app/screens/reminders/page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color.fromARGB(255, 64, 223, 72),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(
              Icons.notifications,
              color: Colors.green,
            ),
            title: Text('Reminder'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReminderPage()),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.green),
            title: Text('General'),
            onTap: () {
              // Xử lý khi nhấn vào mục Notifications
            },
          ),
          ListTile(
            leading: Icon(Icons.backup, color: Colors.green),
            title: Text('Backup & Restore'),
            onTap: () {
              // Xử lý khi nhấn vào mục Security
            },
          ),
          ListTile(
            leading: Icon(Icons.link, color: Colors.green),
            title: Text('Connect Apps'),
            onTap: () {
              // Xử lý khi nhấn vào mục Language
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          ListTile(
            leading: Icon(Icons.widgets, color: Colors.green,),
            title: Text('Widgets'),
            onTap: () {
              // Xử lý khi nhấn vào mục Help & Feedback
            },
          ),
          ListTile(
            leading: Icon(Icons.star, color: Colors.orange,),
            title: Text('Rate Us'),
            onTap: () {
              // Xử lý khi nhấn vào mục Help & Feedback
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          ListTile(
            leading: Icon(Icons.restart_alt_outlined, color: Colors.green,),
            title: Text('Restore purchase'),
            onTap: () {
              // Xử lý khi nhấn vào mục Help & Feedback
            },
          ),
          ListTile(
            leading: Icon(Icons.email_outlined, color: Colors.green,),
            title: Text('Bug report & Feedback'),
            onTap: () {
              // Xử lý khi nhấn vào mục Help & Feedback
            },
          ),
          ListTile(
            leading: Icon(Icons.more_horiz, color: Colors.green,),
            title: Text('Other'),
            onTap: () {
              // Xử lý khi nhấn vào mục Help & Feedback
            },
          ),
          ListTile(
            leading: Icon(Icons.warning_amber, color: Colors.grey,),
            title: Text('Version: 4.34.273'),
            onTap: () {
              // Xử lý khi nhấn vào mục Help & Feedback
            },
          ),
        ],
      ),
    );
  }
}
