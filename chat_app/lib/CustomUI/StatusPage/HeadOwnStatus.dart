// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';

class HeadOwnStatus extends StatefulWidget {
  const HeadOwnStatus({Key? key}) : super(key: key);

  @override
  _HeadOwnStatusState createState() => _HeadOwnStatusState();
}

class _HeadOwnStatusState extends State<HeadOwnStatus> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 27,
            backgroundColor: Colors.blueGrey[200],
            child: SvgPicture.asset("assets/person.svg"),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Vx.orange400,
              radius: 10,
              child: Icon(
                Icons.add,
                size: 17,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      title: Text(
        "My Status",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        "Tap to add status update",
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey[900],
        ),
      ),
    );
  }
}
