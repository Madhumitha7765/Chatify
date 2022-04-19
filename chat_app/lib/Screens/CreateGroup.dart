// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print, unused_field, prefer_final_fields, unused_import, prefer_is_empty

import 'package:chat_app/CustomUI/AvatarCard.dart';
import 'package:chat_app/CustomUI/ButtonCard.dart';
import 'package:chat_app/CustomUI/ContactCard.dart';
import 'package:chat_app/CustomUI/ContactCardCreateGroup.dart';
import 'package:chat_app/Model/ChatModel.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/Model/ChatModelCreateGroup.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModelStatusCreateGroup> contact = [
    ChatModelStatusCreateGroup(
      name: "Razeen",
      status: "Hey There Everyone!",
    ),
    ChatModelStatusCreateGroup(
      name: "Aman",
      status: "Welcome!",
    ),
    ChatModelStatusCreateGroup(
      name: "Alex",
      status: "Developer",
    ),
    ChatModelStatusCreateGroup(
      name: "Jake",
      status: "Flutter developer",
    ),
    ChatModelStatusCreateGroup(
      name: "Razeen",
      status: "Hey There Everyone!",
    ),
    ChatModelStatusCreateGroup(
      name: "Aman",
      status: "Welcome!",
    ),
    ChatModelStatusCreateGroup(
      name: "Alex",
      status: "Developer",
    ),
    ChatModelStatusCreateGroup(
      name: "Jake",
      status: "Flutter developer",
    ),
  ];

  List<ChatModelStatusCreateGroup> groups = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Group",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Add Participants",
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
        ],
        flexibleSpace: Container(
          decoration: kIndividualGradientDecoration,
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: contact.length,
            itemBuilder: (context, index) {
              // print("Create Group: ${contact[index].select}");
              if (index == 0) {
                return Container(
                  height: groups.length > 0 ? 90 : 5,
                  // padding: groups.length > 0 ? EdgeInsets.only(top: 50) : EdgeInsets.all(0),
                );
              } else {}
              return InkWell(
                onTap: () {
                  // print("Tapped: ${contact[index - 1].name}");

                  setState(() {
                    if (contact[index - 1].select == false) {
                      groups.add(contact[index - 1]);
                      contact[index - 1].select = true;
                      // print("Select is false");
                    } else {
                      groups.remove(contact[index - 1]);
                      contact[index - 1].select = false;
                      // print("Select is true");
                    }
                  });
                },
                child: ContactCardCreateGroup(
                  contact[index - 1],
                ),
              );
            },
          ),
          groups.length > 0
              ? Column(
                  children: [
                    Container(
                      height: 70,
                      color: Colors.white,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: contact.length,
                        itemBuilder: (context, index) {
                          if (contact[index].select == true) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  groups.remove(contact[index]);
                                  contact[index].select = false;
                                });
                              },
                              child: AvatarCard(
                                contact: contact[index],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    )
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
