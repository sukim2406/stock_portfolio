import 'package:flutter/material.dart';
import 'package:stock_portfolio_frontend/controllers/shared_preferences_controllers.dart';

import '../controllers/global_controllers.dart' as global;

import '../pages/login.dart';
import '../pages/landing.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String token = '';
  String curUser = '';

  @override
  void initState() {
    super.initState();
    SFControllers.instance.getToken().then(
      (value) {
        setState(
          () {
            token = value;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    updateCurUser() {
      setState(
        () {
          SFControllers.instance.getToken().then(
            (value) {
              token = value;
            },
          );
        },
      );
      SFControllers.instance.getSharedPreferences().then(
        (value) {
          value.clear();
        },
      );
    }

    return Scaffold(
      body: SizedBox(
        height: global.getHeight(context),
        width: global.getWidth(context),
        child: (token.isEmpty)
            ? const LoginPage()
            : LandingPage(
                updateCurUser: updateCurUser,
              ),
      ),
    );
  }
}
