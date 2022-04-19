// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print, unused_field, prefer_final_fields, unused_import

import 'package:chat_app/Model/ChatModelStatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "package:velocity_x/velocity_x.dart";

class ContactCard extends StatelessWidget {
  // const ContactCard({Key? key}) : super(key: key);
  ContactCard({required this.contact});
  final ChatModelStatus contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 23,
        child: SvgPicture.asset(
          "assets/person.svg",
          color: Colors.white,
          height: 30,
          width: 30,
        ),
        backgroundColor: Colors.blueGrey[200],
      ),
      title: Text(
        contact.name,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        contact.status,
        style: TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }
}
