import "package:flutter/material.dart";
import 'package:velocity_x/velocity_x.dart';

const kGradientDecoration = BoxDecoration(
  shape: BoxShape.circle,
  gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Vx.orange400, Vx.purple500]),
);

const kIndividualGradientDecoration = BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Vx.orange400, Vx.purple500]),
);
