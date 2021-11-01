// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_assets_test/utility/my_style.dart';

Future<void> normaldialogBox(BuildContext context, String string) async {
  showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            title: ListTile(
              leading: Icon(
                Icons.add_alert_outlined,
                color: MyStyle().primaryColor,
              ),
              title: Text(
                "Normal Dialog Alert",
                style: MyStyle().redBoldStyle(),
              ),
              subtitle: Text(string),
            ),
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text("OK"))
            ],
          ));
}
