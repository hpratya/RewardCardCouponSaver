// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, non_constant_identifier_names, use_key_in_widget_constructors, invalid_return_type_for_catch_error

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assets_test/utility/dialog.dart';
import 'package:flutter_assets_test/utility/my_style.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double screen = 0;
  bool statusRedEye = true;
  String lgn_user = '', lgn_pass = '';
  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    //print('Screen size is : $screen');

    return Scaffold(
      floatingActionButton: buildRegister(),
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        centerTitle: true,
        title: Text("Flutter Assets Testing"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
              center: Alignment(0, -0.3),
              radius: 0.8,
              colors: <Color>[Colors.white, MyStyle().lightColor]),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildLogo(screen),
                MyStyle().show_title("Free"),
                buildUserInfo(screen),
                buildPassword(screen),
                buildLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextButton buildRegister() => TextButton(
      onPressed: () => Navigator.pushNamed(context, '/register'),
      child: Text(
        "New Register",
        style: TextStyle(color: MyStyle().darkColor),
      ));

  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: screen * 0.75,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: MyStyle().primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        onPressed: () {
          if ((lgn_user.isEmpty) || (lgn_pass.isEmpty)) {
            normaldialogBox(
                context, "Have some space?, Please fill every blank");
          } else {
            checkAuthen();
          }
        },
        child: Text("Login"),
      ),
    );
  }

  Container buildUserInfo(double screen) => Container(
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(25)),
      margin: EdgeInsets.only(top: 10),
      width: screen * 0.75,
      //height: screen * 0.1,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) => lgn_user = value.trim(),
        style: TextStyle(color: MyStyle().lightColor),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().lightColor),
          prefixIcon: Icon(
            Icons.perm_identity,
            color: MyStyle().lightColor,
          ),
          hintText: 'Username',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ));

  Container buildPassword(double screen) => Container(
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(25)),
      margin: EdgeInsets.only(top: 10),
      width: screen * 0.75,
      //height: screen * 0.15,
      child: TextField(
        onChanged: (value) => lgn_pass = value.trim(),
        obscureText: statusRedEye,
        style: TextStyle(color: MyStyle().lightColor),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              statusRedEye
                  ? Icons.remove_red_eye_sharp
                  : Icons.remove_red_eye_outlined,
              color: MyStyle().lightColor,
            ),
            onPressed: () {
              setState(() {
                statusRedEye = !statusRedEye;
              });
            },
          ),
          hintStyle: TextStyle(color: MyStyle().lightColor),
          prefixIcon: Icon(
            Icons.vpn_key_outlined,
            color: MyStyle().lightColor,
          ),
          hintText: 'Password',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ));

  Container buildLogo(double screen) =>
      Container(width: screen * 0.4, child: MyStyle().show_logo());

  Future<void> checkAuthen() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: lgn_user, password: lgn_pass)
          .then((value) => Navigator.pushNamedAndRemoveUntil(context, '/myService', (route) => false))
          .catchError((value) => normaldialogBox(context, value.message));
    });
  }
}
//suffix:IconButton(onPressed: () {}, icon: Icon(Icons.remove_red_eye))