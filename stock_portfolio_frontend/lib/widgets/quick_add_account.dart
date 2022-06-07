import 'package:flutter/material.dart';

import '../widgets/text_input.dart';
import '../widgets/rounded_btn.dart';

import '../controllers/global_controllers.dart' as global;
import '../controllers/api_controllers.dart';

class QuickAddAccountWidget extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController cashController;
  final VoidCallback newAccountCallback;
  const QuickAddAccountWidget({
    Key? key,
    required this.titleController,
    required this.cashController,
    required this.newAccountCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextInputWidget(
            width: global.getWidth(context) * .4,
            label: 'Title',
            controller: titleController,
            obsecure: false,
            enabled: true,
          ),
          TextInputWidget(
            width: global.getWidth(context) * .4,
            label: 'Initial Cash',
            controller: cashController,
            obsecure: false,
            enabled: true,
          ),
          RoundedBtnWidget(
            height: null,
            width: null,
            func: () {
              try {
                double.parse(cashController.text);
                ApiControllers.instance
                    .createAccount(titleController.text, cashController.text)
                    .then(
                  (result) {
                    if (result) {
                      titleController.clear();
                      cashController.clear();
                      newAccountCallback();
                    } else {
                      global.printErrorBar(
                          context, 'Account Creation Unsuccessful');
                    }
                  },
                );
              } catch (e) {
                global.printErrorBar(context, 'Invalid input detected');
              }
            },
            label: 'CREATE',
            color: Colors.greenAccent,
          )
        ],
      ),
    );
  }
}
