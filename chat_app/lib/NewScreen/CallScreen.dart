// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: ListView(
          children: [
            callCard(
              "Razeen",
              Icons.call_made,
              Colors.green,
              "Jan 20, 18:36",
            ),
            callCard(
              "Aman",
              Icons.call_missed,
              Colors.red,
              "Jan 21, 15:36",
            ),
            callCard(
              "Alex",
              Icons.call_received,
              Colors.green,
              "Jan 21, 16:30",
            ),
            callCard(
              "Razeen",
              Icons.call_made,
              Colors.green,
              "Jan 20, 18:36",
            ),
            callCard(
              "Aman",
              Icons.call_missed,
              Colors.red,
              "Jan 21, 15:36",
            ),
            callCard(
              "Alex",
              Icons.call_received,
              Colors.green,
              "Jan 21, 16:30",
            ),
            
            callCard(
              "Razeen",
              Icons.call_made,
              Colors.green,
              "Jan 20, 18:36",
            ),
            callCard(
              "Aman",
              Icons.call_missed,
              Colors.red,
              "Jan 21, 15:36",
            ),
            callCard(
              "Alex",
              Icons.call_received,
              Colors.green,
              "Jan 21, 16:30",
            ),
          ],
        ),
      ),
    );
  }

  Widget callCard(String name, IconData icon, Color iconColor, String time) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(
        bottom: 0.5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 26,
        ),
        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              time,
              style: TextStyle(fontSize: 13),
            )
          ],
        ),
        trailing: Icon(
          Icons.call,
          size: 26,
          color: Vx.orange400,
        ),
      ),
    );
  }
}
