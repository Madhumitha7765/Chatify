// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, unused_import, avoid_print, sized_box_for_whitespace

import 'package:chat_app/NewScreen/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:velocity_x/velocity_x.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Welcome to Chatify",
                style: TextStyle(
                    color: Vx.orange400,
                    fontSize: 29,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 9,
              ),
              Image.asset(
                "assets/bg.png",
                color: Vx.orange400,
                height: 300,
                width: 300,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                    children: [
                      TextSpan(
                          text: "Agree and continue to accept the",
                          style: TextStyle(color: Colors.grey[600])),
                      TextSpan(
                        text: " Chatify Terms of Service and Privacy Policy.",
                        style: TextStyle(color: Vx.purple600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) {
                        return LoginPage();
                      },
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 110,
                  height: 50,
                  child: Card(
                    margin: EdgeInsets.all(0),
                    color: Colors.orangeAccent[700],
                    elevation: 8,
                    child: Center(
                      child: Text(
                        "AGREE AND CONTINUE",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
