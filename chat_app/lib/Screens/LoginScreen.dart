// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print, unused_field, prefer_final_fields, avoid_unnecessary_containers, list_remove_unrelated_type

import 'package:chat_app/CustomUI/ButtonCard.dart';
import 'package:chat_app/Model/ChatModel.dart';
import 'package:chat_app/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;
  List<ChatModel> chatModels = [
    ChatModel(
      name: "Razeen",
      icon: "person.svg",
      isGroup: false,
      time: "4:00",
      currentMessage: "Hii Everyone",
      id: 1,
    ),
    ChatModel(
      name: "Aman",
      icon: "person.svg",
      isGroup: false,
      time: "10:00",
      currentMessage: "Hii ",
      id: 2,
    ),
    ChatModel(
      name: "Alex",
      icon: "person.svg",
      isGroup: false,
      time: "9:00",
      currentMessage: "Hii Everyone",
      id: 3,
    ),
    ChatModel(
      name: "Collin",
      icon: "person.svg",
      isGroup: false,
      time: "12:00",
      currentMessage: "Hii",
      id: 4,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: chatModels.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                sourceChat = chatModels.removeAt(index);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (builder) {
                    return Homescreen(
                      chatmodels: chatModels,
                      sourceChat: sourceChat,
                    );
                  }),
                );
              },
              child: ListTile(
                leading: CircleAvatar(
                  radius: 23,
                  child: Icon(
                    Icons.person,
                    size: 26,
                    color: Colors.white,
                  ),
                  backgroundColor: Vx.orange400,
                ),
                title: Text(
                  chatModels[index].name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
