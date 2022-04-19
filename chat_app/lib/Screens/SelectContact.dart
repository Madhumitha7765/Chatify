// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print, unused_field, prefer_final_fields, unused_import

import 'package:chat_app/CustomUI/ButtonCard.dart';
import 'package:chat_app/CustomUI/ContactCard.dart';
import 'package:chat_app/Screens/CreateGroup.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/Model/ChatModelStatus.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {
    List<ChatModelStatus> contacts = [
      ChatModelStatus(
        name: "Razeen",
        status: "Hey There Everyone!",
        
      ),
      ChatModelStatus(
        name: "Aman",
        status: "Welcome!",
      ),
      ChatModelStatus(
        name: "Alex",
        status: "Developer",
      ),
      ChatModelStatus(
        name: "Jake",
        status: "Flutter developer",
      ),
      ChatModelStatus(
        name: "Razeen",
        status: "Hey There Everyone!",
      ),
      ChatModelStatus(
        name: "Aman",
        status: "Welcome!",
      ),
      ChatModelStatus(
        name: "Alex",
        status: "Developer",
      ),
      ChatModelStatus(
        name: "Jake",
        status: "Flutter developer",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Contact",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "256 Contacts",
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 26,
            ),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("Invite a friend"),
                  value: "Invite a friend",
                ),
                PopupMenuItem(
                  child: Text("Contacts"),
                  value: "Contacts",
                ),
                PopupMenuItem(
                  child: Text("Refresh"),
                  value: "Refresh",
                ),
                PopupMenuItem(
                  child: Text("Help"),
                  value: "Help",
                ),
              ];
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: kIndividualGradientDecoration,
        ),
      ),
      body: ListView.builder(
        itemCount: contacts.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return CreateGroup();
                  }),
                );
              },
              child: ButtonCard(
                  icon: Icons.group,
                  name: "New group",
                  contact: contacts[index]),
            );
          } else if (index == 1) {
            return ButtonCard(
                icon: Icons.person_add,
                name: "New contact",
                contact: contacts[index]);
          } else {
            return ContactCard(
              contact: contacts[index - 2],
            );
          }
        },
      ),
    );
  }
}
