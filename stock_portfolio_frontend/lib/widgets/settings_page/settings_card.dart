import 'package:flutter/material.dart';

import '../../widgets/card.dart';
import '../../widgets/text_input.dart';
import '../../widgets/rounded_btn.dart';

import '../../controllers/api_controllers.dart';
import '../../controllers/global_controllers.dart' as global;

import '../../pages/home.dart';

class SettingsCardWidget extends StatefulWidget {
  const SettingsCardWidget({Key? key}) : super(key: key);

  @override
  State<SettingsCardWidget> createState() => _SettingsCardWidgetState();
}

class _SettingsCardWidgetState extends State<SettingsCardWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController apiKeyController = TextEditingController();
  TextEditingController secretKeyController = TextEditingController();
  bool _paperTrade = true;

  @override
  void initState() {
    super.initState();
    ApiControllers.instance.getProfileDetail().then((result) {
      emailController.text = result['email'];
      usernameController.text = result['username'];
      apiKeyController.text = result['alpaca_api_key'];
      secretKeyController.text = result['alpaca_secret_key'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      height: global.getHeight(context) * .95,
      width: global.getWidth(context) * .9,
      title: 'Account Settings',
      content: SizedBox(
        height: global.getHeight(context) * .9,
        width: global.getWidth(context) * .8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: global.getWidth(context) * .12,
                ),
                TextInputWidget(
                  width: global.getWidth(context) * .3,
                  label: 'Email',
                  controller: emailController,
                  obsecure: false,
                  enabled: false,
                ),
                SizedBox(
                  width: global.getWidth(context) * .02,
                ),
                TextInputWidget(
                  width: global.getWidth(context) * .3,
                  label: 'Username',
                  controller: usernameController,
                  obsecure: false,
                  enabled: false,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: global.getWidth(context) * .12,
                ),
                TextInputWidget(
                  width: global.getWidth(context) * .3,
                  label: 'Password',
                  controller: passwordController,
                  obsecure: true,
                  enabled: true,
                ),
                SizedBox(
                  width: global.getWidth(context) * .02,
                ),
                TextInputWidget(
                  width: global.getWidth(context) * .3,
                  label: 'Password Confirm',
                  controller: password2Controller,
                  obsecure: true,
                  enabled: true,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: global.getWidth(context) * .12,
                ),
                TextInputWidget(
                  width: global.getWidth(context) * .3,
                  label: 'Alpaca Api Key',
                  controller: apiKeyController,
                  obsecure: false,
                  enabled: true,
                ),
                SizedBox(
                  width: global.getWidth(context) * .02,
                ),
                TextInputWidget(
                  width: global.getWidth(context) * .3,
                  label: 'Alpaca Secret Key',
                  controller: secretKeyController,
                  obsecure: false,
                  enabled: true,
                ),
              ],
            ),
            SizedBox(
              width: global.getWidth(context) * .3,
              child: CheckboxListTile(
                title: const Text(
                  'Paper Traing?',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                value: _paperTrade,
                onChanged: (value) {
                  setState(() {
                    _paperTrade = value!;
                  });
                },
              ),
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
                  if (passwordController.text == password2Controller.text) {
                    ApiControllers.instance
                        .updateProfile(
                      emailController.text,
                      usernameController.text,
                      passwordController.text,
                      password2Controller.text,
                      apiKeyController.text,
                      secretKeyController.text,
                      _paperTrade.toString(),
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
              label: 'UPDATE',
              color: Colors.lightBlueAccent,
            ),
            RoundedBtnWidget(
              height: null,
              width: null,
              func: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('DELETE PROFILE'),
                        content:
                            const Text('Are you sure to delete your profile?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'CANCEL',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              ApiControllers.instance
                                  .deleteProfile()
                                  .then((result) {
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
                                    'Profile deletion failed, something went wrong!',
                                  );
                                }
                              });
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'DELETE',
                              style: TextStyle(
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              },
              label: 'DELETE PROFILE',
              color: Colors.redAccent,
            )
          ],
        ),
      ),
    );
  }
}
