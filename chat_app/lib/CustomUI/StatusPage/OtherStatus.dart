// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, unused_import, avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/src/widgets/framework.dart';

class OthersStatus extends StatelessWidget {
  final String name;
  final String time;
  final String imageName;
  final bool isSeen;
  final int statusNum;

  OthersStatus({
    required this.name,
    required this.time,
    required this.imageName,
    required this.isSeen,
    required this.statusNum,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomPaint(
        painter: StatusPainter(
          isSeen: isSeen,
          statusNum: statusNum,
        ),
        child: CircleAvatar(
          radius: 26,
          backgroundColor: Colors.blueGrey[200],
          backgroundImage: AssetImage(imageName),
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        "Today at $time",
        style: TextStyle(fontSize: 14, color: Colors.grey[900]),
      ),
    );
  }
}

degreeToAngle(double degree) {
  return degree * pi / 100;
}

class StatusPainter extends CustomPainter {
  bool isSeen;
  int statusNum;

  StatusPainter({
    required this.isSeen,
    required this.statusNum,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final Paint paint = Paint();
    paint.isAntiAlias = true;
    paint.strokeWidth = 6.0;
    paint.color = isSeen ? Colors.grey : Vx.orange400;
    paint.style = PaintingStyle.stroke;
    drawArc(canvas, size, paint);
  }

  void drawArc(Canvas canvas, Size size, Paint paint) {
    // if (statusNum == 1) {
      canvas.drawArc(
        Rect.fromLTWH(0, 0, size.width, size.height),
        degreeToAngle(0),
        degreeToAngle(360),
        false,
        paint,
      );
    // } else {
    //   double degree = -90;
    //   double arc = 360 / statusNum;
    //   for (int i = 0; i < statusNum; i++) {
    //     canvas.drawArc(
    //       Rect.fromLTWH(0.0, 0.0, size.width, size.height),
    //       degreeToAngle(degree + 4),
    //       degreeToAngle(arc - 8),
    //       true,
    //       paint,
    //     );
    //     degree += arc;
    //   }
    // }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    // throw UnimplementedError();
    return true;
  }
}
