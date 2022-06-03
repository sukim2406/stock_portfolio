import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;
import '../../controllers/api_controllers.dart';

import '../../widgets/rounded_btn.dart';

class LogoutPage extends StatefulWidget {
  final VoidCallback updateCurUser;
  const LogoutPage({
    Key? key,
    required this.updateCurUser,
  }) : super(key: key);

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: global.getHeight(context),
        width: global.getWidth(context) * .9,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RoundedBtnWidget(
                height: null,
                width: null,
                func: () {
                  ApiControllers.instance.logout().then(
                    (result) {
                      if (result) {
                        widget.updateCurUser();
                      }
                    },
                  );
                },
                label: 'LOG OUT',
                color: Colors.greenAccent,
              ),
              RoundedBtnWidget(
                height: null,
                width: null,
                func: () {
                  widget.updateCurUser();
                },
                label: 'Emergency',
                color: Colors.redAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
