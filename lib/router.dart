import 'package:flutter/material.dart';
import 'package:flutter_assets_test/widget/authen.dart';
import 'package:flutter_assets_test/widget/my_service.dart';
import 'package:flutter_assets_test/widget/register.dart';
import 'package:flutter_assets_test/widget/show_rtr.dart';

final Map<String, WidgetBuilder> routes = {
  '/authen': (BuildContext context) => Authen(),
  '/register': (BuildContext context) => Register(),
  '/myService': (BuildContext context) => MyService(),
  '/showRTR':(BuildContext context)=> ShowRTR(),
};
