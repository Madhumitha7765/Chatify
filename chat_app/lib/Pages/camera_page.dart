// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:chat_app/Screens/CameraScreen.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({ Key? key }) : super(key: key);
  void onImageSend(String path) {
    print("Working!!!!! $path");
  }

  @override
  Widget build(BuildContext context) {
    return CameraScreen(
      onImageSend: onImageSend,
    );
  }
}