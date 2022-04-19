// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print, unused_field, prefer_final_fields, unused_import

import 'package:chat_app/Model/ChatModelCreateGroup.dart';
import 'package:chat_app/Model/ChatModelStatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "package:velocity_x/velocity_x.dart";

class ContactCardCreateGroup extends StatelessWidget {
  // const ContactCard({Key? key}) : super(key: key);
  // ContactCardCreateGroup({required this.contactCreateGroup});
  final ChatModelStatusCreateGroup contactCreateGroup;

  ContactCardCreateGroup(this.contactCreateGroup);
  // final index;

  @override
  Widget build(BuildContext context) {
    // print("Contact Create Group:  ${contactCreateGroup.select}");
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 23,
              child: SvgPicture.asset(
                "assets/person.svg",
                color: Colors.white,
                height: 30,
                width: 30,
              ),
              backgroundColor: Colors.blueGrey[200],
            ),
            contactCreateGroup.select
                ? Positioned(
                    bottom: 4,
                    right: 5,
                    child: CircleAvatar(
                      backgroundColor: Vx.orange400,
                      radius: 9.5,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      title: Text(
        contactCreateGroup.name,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        contactCreateGroup.status,
        style: TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }
}
