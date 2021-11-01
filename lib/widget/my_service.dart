// ignore_for_file: prefer_const_constructors, await_only_futures, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assets_test/utility/my_style.dart';
import 'package:flutter_assets_test/widget/my_account.dart';
import 'package:flutter_assets_test/widget/show_my_coupon.dart';
import 'package:flutter_assets_test/widget/show_rtr.dart';

class MyService extends StatefulWidget {
  //const MyService({ Key? key }) : super(key: key);

  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // ignore: prefer_typing_uninitialized_variables
  var name, email;
  Widget currentWidget = ShowRTR();
  @override
  void initState() {
    // TODO: implement initState"
    super.initState();
    findNameandEmail();
  }

  Future<void> findNameandEmail() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          name = event?.displayName;
          email = event?.email;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
      ),
      drawer: buildDrawer(),
      body: currentWidget,
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              buildUserAccountsDrawerHeader(),
              buildShowListtileMyAccount(),
              buildShowListtileRestaurant(),
              buildShowListtileMyCoupon(),
            ],
          ),
          buildSignOut(),
        ],
      ),
    );
  }

  ListTile buildShowListtileRestaurant() {
    return ListTile(
      focusColor: MyStyle().primaryColor,
      hoverColor: MyStyle().lightColor,
      leading: Icon(
        Icons.food_bank_rounded,
        size: 35,
      ),
      title: Text("Shop added"),
      subtitle: Text("Show your shop added"),
      onTap: () {
        setState(() {
          currentWidget = ShowRTR();
        });
        Navigator.pop(context);
      },
    );
  }

  ListTile buildShowListtileMyCoupon() {
    return ListTile(
      focusColor: MyStyle().primaryColor,
      hoverColor: MyStyle().lightColor,
      leading: Icon(
        Icons.local_play_sharp,
        size: 35,
      ),
      title: Text("My Coupon"),
      subtitle: Text("Show your Coupon"),
      onTap: () {
        setState(() {
          currentWidget = ShowMyCoupon();
        });
        Navigator.pop(context);
      },
    );
  }

  ListTile buildShowListtileMyAccount() {
    return ListTile(
      focusColor: MyStyle().primaryColor,
      hoverColor: MyStyle().lightColor,
      leading: Icon(
        Icons.account_circle_outlined,
        size: 35,
      ),
      title: Text("My Account"),
      subtitle: Text("Show your account detail"),
      onTap: () {
        setState(() {
          currentWidget = ShowMyAccount();
        });
        Navigator.pop(context);
      },
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/anime.jpg'), fit: BoxFit.fill)),
      accountName: Row(
        children: [
          Icon(Icons.account_box_outlined),
          MyStyle().txtSty_1(name == null ? ' : ' : ' : ' + name),
        ],
      ),
      accountEmail: Row(
        children: [
          Icon(Icons.email_outlined),
          MyStyle().txtSty_1(email == null ? ' : ' : ' : ' + email),
        ],
      ),
      currentAccountPicture: Image.asset('images/accounnt.png'),
    );
  }

  Column buildSignOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            await Firebase.initializeApp().then((value) async {
              await FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/authen', (route) => false));
            });
          },
          tileColor: MyStyle().darkColor,
          leading: Icon(
            Icons.exit_to_app_outlined,
            color: Colors.black,
            size: 30,
          ),
          title: Text(
            'Sign out',
            style: MyStyle().redBoldStyle15(),
          ),
          subtitle: MyStyle().txtSty_1('Sign out & go to Authen'),
        ),
      ],
    );
  }
}
