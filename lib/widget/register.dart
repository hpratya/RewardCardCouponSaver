// ignore_for_file: avoid_print, prefer_const_constructors, use_key_in_widget_constructors,, prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assets_test/utility/dialog.dart';
import 'package:flutter_assets_test/utility/my_style.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  double screen = 0;
  var txfName, txfUserEmail, txfPassword;

  Container buildName(double screen) => Container(
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(25)),
      margin: EdgeInsets.only(top: 10),
      width: screen * 0.75,
      //height: screen * 0.15,
      child: TextField(
        onChanged: (value) => txfName = value.trim(),
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

  Container buildEmail(double screen) => Container(
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(25)),
      margin: EdgeInsets.only(top: 10),
      width: screen * 0.75,
      //height: screen * 0.15,
      child: TextField(
        onChanged: (value) => txfUserEmail = value.trim(),
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: MyStyle().lightColor),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().lightColor),
          prefixIcon: Icon(
            Icons.email_outlined,
            color: MyStyle().lightColor,
          ),
          hintText: 'Email',
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
        onChanged: (value) => txfPassword = value.trim(),
        style: TextStyle(color: MyStyle().lightColor),
        decoration: InputDecoration(
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

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: buildregister(),
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        centerTitle: true,
        title: Text("Registeration"),
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
              children: [
                buildName(screen),
                buildEmail(screen),
                buildPassword(screen),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FloatingActionButton buildregister() {
    return FloatingActionButton(
      backgroundColor: MyStyle().primaryColor,
      onPressed: () {
        print("Name is     :$txfName");
        print("Email is    :$txfUserEmail");
        print("Password is :$txfPassword");
        if ((txfName?.isEmpty ?? true) ||
            (txfUserEmail?.isEmpty ?? true) ||
            (txfPassword?.isEmpty ?? true)) {
          normaldialogBox(
              context, "You have some space ,Please fill every field.");
        } else {
          print("No space in text field");
          registerFirebase();
        }
      },
      child: Icon(
        Icons.check,
      ),
    );
  }

  Future<void> registerFirebase() async {
    await Firebase.initializeApp().then((value) async {
      print("Firebase Initialize Succes");
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: txfUserEmail, password: txfPassword)
          .then((value) async {
        print("Register succes");
        await value.user!.updateDisplayName(txfName).then((value) =>
            Navigator.pushNamedAndRemoveUntil(
                context, '/myService', (route) => false));
      }).catchError((onError) {
        normaldialogBox(context, onError.message);
      });
    });
  }
}
