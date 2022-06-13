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
              try {
                double.parse(cashController.text);
                ApiControllers.instance
                    .createAccount(titleController.text, cashController.text)
                    .then(
                  (result) {
                    if (result) {
                      titleController.clear();
                      cashController.clear();
                      updateAccounts();
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
            label: 'ADD',
          )
        ],
      ),
      // Column(
      //   children: [
      //     Container(
      //       height: global.getDetailedSummeryHeight(context) / 3,
      //       width: global.getDetailedSummeryWidth(context),
      //       child: Row(
      //         children: [
      //           const Text(
      //             'Title',
      //             style: TextStyle(
      //               color: Colors.grey,
      //               fontSize: 15,
      //             ),
      //           ),
      //           TextInputWidget(
      //             width: global.getDetailedSummeryWidth(context) / 2,
      //             label: '',
      //             controller: titleController,
      //             obsecure: false,
      //             enabled: true,
      //           )
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
