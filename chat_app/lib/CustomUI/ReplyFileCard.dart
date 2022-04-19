// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, unused_import, prefer_is_empty

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ReplyFileCard extends StatelessWidget {
  ReplyFileCard(
      {required this.message, required this.path, required this.time});
  final String path;
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Container(
          height: MediaQuery.of(context).size.height / 1.8,
          width: MediaQuery.of(context).size.width / 1.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[600],
          ),
          child: Card(
            margin: EdgeInsets.all(3),
            color: Vx.orange400,
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Expanded(
                  // child: Image.file(
                  //   File(path),
                  //   fit: BoxFit.fitHeight,
                  // ),
                  child:
                      Image.network("http://192.168.228.200:7000/uploads/$path"),
                ),
                message.length > 0
                    ? Container(
                        height: 40,
                        padding: EdgeInsets.only(
                          left: 15,
                          top: 8,
                        ),
                        child: Text(
                          message,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
