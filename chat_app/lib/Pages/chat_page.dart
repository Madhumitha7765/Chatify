// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, use_key_in_widget_constructors, must_be_immutable

import 'package:chat_app/CustomUI/CustomCard.dart';
import 'package:chat_app/Model/ChatModel.dart';
import 'package:chat_app/Screens/SelectContact.dart';
import 'package:chat_app/Utils/utils.dart';
import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatPage extends StatefulWidget {
  late List<ChatModel> chatmodel;
  final ChatModel sourceChat;
  ChatPage({required this.chatmodel , required this.sourceChat});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return SelectContact();
            }),
          );
        },
        child: Container(
          width: 60,
          height: 60,
          child: Icon(
            Icons.chat,
          ),
          decoration: kGradientDecoration,
        ),
      ),
      body: ListView.builder(
        itemCount: widget.chatmodel.length,
        itemBuilder: (context, index) {
          return CustomCard(
            chatModel: widget.chatmodel[index],
            sourceChat: widget.sourceChat,
          );
        },
      ),
    );
  }
}
