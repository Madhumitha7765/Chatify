// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chat_app/CustomUI/StatusPage/HeadOwnStatus.dart';
import 'package:chat_app/CustomUI/StatusPage/OtherStatus.dart';
import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: FloatingActionButton(
              backgroundColor: Colors.blueGrey[100],
              onPressed: () {},
              child: Icon(
                Icons.edit,
                color: Colors.blueGrey[900],
              ),
            ),
          ),
          SizedBox(
            height: 13,
          ),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Vx.orange400,
            child: Container(
              width: 60,
              height: 60,
              child: Icon(
                Icons.camera_alt,
              ),
              decoration: kGradientDecoration,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            HeadOwnStatus(),
            label("Recent Updates"),
            OthersStatus(
              name: "Razeen Aman",
              time: "01:23",
              imageName: "assets/background.png",
              isSeen: false,
              statusNum: 5,
            ),
            OthersStatus(
              name: "Alex",
              time: "04:53",
              imageName: "assets/background.png",
              isSeen: false,
              statusNum: 3,
            ),
            OthersStatus(
              name: "Collin",
              time: "12:26",
              imageName: "assets/background.png",
              isSeen: false,
              statusNum: 3,
            ),
            SizedBox(
              height: 5,
            ),
            label("Viewed Updates"),
            OthersStatus(
              name: "Razeen Aman",
              time: "01:23",
              imageName: "assets/background.png",
              isSeen: true,
              statusNum: 1,
            ),
            OthersStatus(
              name: "Alex",
              time: "04:53",
              imageName: "assets/background.png",
              isSeen: true,
              statusNum: 2,
            ),
            OthersStatus(
              name: "Collin",
              time: "12:26",
              imageName: "assets/background.png",
              isSeen: true,
              statusNum: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget label(String labelName) {
    return Container(
      height: 33,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
        child: Text(
          labelName,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
