// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:camera/camera.dart';
import 'package:chat_app/NewScreen/LandingScreen.dart';
import 'package:chat_app/Screens/CameraScreen.dart';
import 'package:chat_app/Screens/LoginScreen.dart';
import 'package:chat_app/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // primaryColor: Color(0xFF075E54),
        // appBarTheme: AppBarTheme(
        //   color: Color(0xFF075E54)
        // ),
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: LandingScreen(),
    );
  }
}
