import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../controllers/global_controllers.dart' as global;
import '../controllers/api_controllers.dart';

import '../widgets/text_input.dart';
import '../widgets/rounded_btn.dart';

import '../pages/home.dart';
import '../pages/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController password2Controller = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController apiKeyController = TextEditingController();
    TextEditingController secretKeyController = TextEditingController();

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
                      height: global.getHeight(context) * .03,
                    ),
                    TextInputWidget(
                      width: global.getWidth(context) * .3,
                      label: 'Password Confirm',
                      controller: password2Controller,
                      obsecure: true,
                      enabled: true,
                    ),
                    SizedBox(
                      height: global.getHeight(context) * .03,
                    ),
                    TextInputWidget(
                      width: global.getWidth(context) * .3,
                      label: 'Username',
                      controller: usernameController,
                      obsecure: false,
                      enabled: true,
                    ),
                    SizedBox(
                      height: global.getHeight(context) * .03,
                    ),
                    TextInputWidget(
                      width: global.getWidth(context) * .3,
                      label: 'Alpaca Api Key',
                      controller: apiKeyController,
                      obsecure: false,
                      enabled: true,
                    ),
                    SizedBox(
                      height: global.getHeight(context) * .03,
                    ),
                    TextInputWidget(
                      width: global.getWidth(context) * .3,
                      label: 'Alpaca Secret Key',
                      controller: secretKeyController,
                      obsecure: false,
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
                            passwordController.text.isNotEmpty &&
                            password2Controller.text.isNotEmpty &&
                            usernameController.text.isNotEmpty &&
                            apiKeyController.text.isNotEmpty &&
                            secretKeyController.text.isNotEmpty) {
                          if (passwordController.text ==
                              password2Controller.text) {
                            ApiControllers.instance
                                .register(
                              emailController.text,
                              usernameController.text,
                              passwordController.text,
                              password2Controller.text,
                              apiKeyController.text,
                              secretKeyController.text,
                            )
                                .then(
                              (result) {
                                if (result) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const HomePage(),
                                    ),
                                    (route) => false,
                                  );
                                } else {
                                  global.printErrorBar(
                                    context,
                                    'Registration failed, something went wrong!',
                                  );
                                }
                              },
                            );
                          } else {
                            global.printErrorBar(
                              context,
                              'Password must match',
                            );
                          }
                        } else {
                          global.printErrorBar(context, 'Empty field detected');
                        }
                      },
                      label: 'REGISTER',
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
                          text: 'have an account ? ',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(
                              text: 'LOGIN',
                              style: const TextStyle(
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = (() {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const LoginPage(),
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
