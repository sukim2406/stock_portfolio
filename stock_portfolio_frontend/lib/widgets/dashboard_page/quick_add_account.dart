import 'package:flutter/material.dart';

import '../text_input.dart';
import '../rounded_btn.dart';

import '../../controllers/global_controllers.dart' as global;
import '../../controllers/api_controllers.dart';

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
              if (global.isNumber(cashController.text)) {
                if (global.accountTitleCheck(titleController.text)) {
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
                } else {
                  global.printErrorBar(
                      context, 'Title cannot have space " " or slash "/" ');
                }
              } else {
                global.printErrorBar(context, 'Cash input must be type double');
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
