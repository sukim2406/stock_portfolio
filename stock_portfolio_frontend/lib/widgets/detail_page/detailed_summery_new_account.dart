import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;
import '../../controllers/api_controllers.dart';

import '../../widgets/text_input.dart';
import '../../widgets/rounded_btn.dart';

class DetailedSummeryNewAccountWidget extends StatelessWidget {
  final VoidCallback updateAccounts;
  const DetailedSummeryNewAccountWidget({
    Key? key,
    required this.updateAccounts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController cashController = TextEditingController();

    return SizedBox(
      height: global.getDetailedSummeryHeight(context),
      width: global.getDetailedSummeryWidth(context),
      child: Row(
        children: [
          SizedBox(
            width: global.getDetailedSummeryWidth(context) * .75,
            height: global.getDetailedSummeryHeight(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: global.getDetailedSummeryWidth(context) * .7,
                  height: global.getDetailedSummeryHeight(context) * .35,
                  child: TextInputWidget(
                    width: global.getDetailedSummeryWidth(context) * .5,
                    label: 'TITLE',
                    controller: titleController,
                    obsecure: false,
                    enabled: true,
                  ),
                ),
                SizedBox(
                  width: global.getDetailedSummeryWidth(context) * .7,
                  height: global.getDetailedSummeryHeight(context) * .35,
                  child: TextInputWidget(
                    width: global.getDetailedSummeryWidth(context) * .5,
                    label: 'INITIAL CASH',
                    controller: cashController,
                    obsecure: false,
                    enabled: true,
                  ),
                ),
              ],
            ),
          ),
          RoundedBtnWidget(
            height: global.getDetailedSummeryWidth(context) * .2,
            width: global.getDetailedSummeryWidth(context) * .2,
            color: global.accentColor,
            func: () {
              if (global.isNumber(cashController.text)) {
                if (global.accountTitleCheck(titleController.text)) {
                  ApiControllers.instance
                      .createAccount(titleController.text, cashController.text)
                      .then(
                    (result) {
                      if (result) {
                        ApiControllers.instance
                            .addActivity(
                          titleController.text,
                          'ACCOUNT CREATED',
                          titleController.text,
                          cashController.text,
                          null,
                          DateTime.now(),
                        )
                            .then(
                          (result) {
                            if (result) {
                              titleController.clear();
                              cashController.clear();
                              updateAccounts();
                            }
                          },
                        );
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
            label: 'ADD',
          )
        ],
      ),
    );
  }
}
