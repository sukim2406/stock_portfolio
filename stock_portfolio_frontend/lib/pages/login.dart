import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stock_portfolio_frontend/controllers/api_controllers.dart';

import '../controllers/global_controllers.dart' as global;

import '../widgets/text_input.dart';
import '../widgets/rounded_btn.dart';

import '../pages/home.dart';
import '../pages/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: global.getHeight(context),
          width: global.getWidth(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: global.getHeight(context),
                width: global.getWidth(context) * .6,
                color: Colors.red,
              ),
              SizedBox(
                height: global.getHeight(context),
                width: global.getWidth(context) * .4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputWidget(
                      width: global.getWidth(context) * .3,
                      label: 'Email',
                      controller: emailController,
                      obsecure: false,
                      enabled: true,
                    ),
                    SizedBox(
                      height: global.getHeight(context) * .03,
                    ),
                    TextInputWidget(
                      width: global.getWidth(context) * .3,
                      label: 'Password',
                      controller: passwordController,
                      obsecure: true,
                      enabled: true,
                    ),
                    SizedBox(
                      height: global.getHeight(context) * .06,
                    ),
                    RoundedBtnWidget(
                      height: null,
                      width: global.getWidth(context) * .3,
                      func: () {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          ApiControllers.instance
                              .login(
                                  emailController.text, passwordController.text)
                              .then(
                            (result) {
                              if (result) {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const HomePage()),
                                  (route) => false,
                                );
                              } else {
                                global.printErrorBar(
                                    context, 'Unable to login');
                              }
                            },
                          );
                        } else {
                          global.printErrorBar(context, 'Empty field detected');
                        }
                      },
                      label: 'LOG IN',
                      color: Colors.lightBlueAccent,
                    ),
                    SizedBox(
                      height: global.getHeight(context) * .06,
                    ),
                    SizedBox(
                      width: global.getWidth(context) * .3,
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: 'new to Stock Portfolio? ',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(
                              text: 'REGISTER',
                              style: const TextStyle(
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = (() {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const RegisterPage(),
                                    ),
                                    (route) => false,
                                  );
                                }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
