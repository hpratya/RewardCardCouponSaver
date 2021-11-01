// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Color(0xffc78b00);
  Color primaryColor = Color(0xffffbb33);
  Color lightColor = Color(0xffffed67);

  TextStyle redBoldStyle() =>
      TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 25);
  TextStyle redBoldStyle25() =>
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25);
  TextStyle redBoldStyle15() =>
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15);
  Widget show_logo() => Image.asset('images/logo.png');
  Widget show_title(String title) => Text(
        title,
        style: TextStyle(
          color: lightColor,
          fontSize: 50,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          // ignore: prefer_const_literals_to_create_immutables
        ),
      );

  Widget txtSty_1(String title) => Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          //fontStyle: FontStyle.italic,
          // ignore: prefer_const_literals_to_create_immutables
        ),
      );
  Widget txtSty_2(String title) => Text(
        title,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          //fontStyle: FontStyle.italic,
          // ignore: prefer_const_literals_to_create_immutables
        ),
      );
  MyStyle();
}
