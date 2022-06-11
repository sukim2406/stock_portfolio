import 'package:flutter/material.dart';

getHeight(context) {
  return MediaQuery.of(context).size.height;
}

getWidth(context) {
  return MediaQuery.of(context).size.width;
}

printErrorBar(context, text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text(text),
    ),
  );
}

Color accentColor = Colors.greenAccent;
Color baseColor = Colors.black87;
Color backgroundColor = Colors.black;
Color profitColor = Colors.greenAccent;
Color lossColor = Colors.redAccent;
Color evenColor = Colors.blueGrey;

double getSummeryWidth(context) {
  return getWidth(context) * .44;
}

Color plColor(double value) {
  return (value > 0)
      ? profitColor
      : (value == 0)
          ? evenColor
          : lossColor;
}

double getDetailedWidth(context) {
  return getWidth(context) * .88;
}
