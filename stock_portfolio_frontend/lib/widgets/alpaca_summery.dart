import 'package:flutter/material.dart';

import '../controllers/global_controllers.dart' as global;

import '../widgets/card.dart';
import '../widgets/info_text.dart';

class AlpacaSummeryWidget extends StatelessWidget {
  final Map account;
  const AlpacaSummeryWidget({
    Key? key,
    required this.account,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      height: global.getHeight(context) * .4,
      width: global.getWidth(context) * .44,
      title: 'Alpaca Account Summery',
      content: (account.isNotEmpty)
          ? Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoTextWidget(
                        label: 'Acc # ',
                        content: account['account_number'],
                      ),
                      InfoTextWidget(
                        label: 'status ',
                        content: account['status'],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoTextWidget(
                        label: 'currency ',
                        content: account['currency'],
                      ),
                      InfoTextWidget(
                        label: 'portfolio value ',
                        content: account['portfolio_value'],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoTextWidget(
                        label: 'cash ',
                        content: account['cash'],
                      ),
                      InfoTextWidget(
                        label: 'buying power ',
                        content: account['buying_power'],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoTextWidget(
                        label: 'patterned day trader ',
                        content: account['pattern_day_trader'].toString(),
                      ),
                      InfoTextWidget(
                        label: 'daytrade # ',
                        content: account['daytrade_count'].toString(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoTextWidget(
                        label: 'account blocked ',
                        content: account['account_blocked'].toString(),
                      ),
                      InfoTextWidget(
                        label: 'trading blocked ',
                        content: account['trading_blocked'].toString(),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const Text(
              'Unable to get account info.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
    );
  }
}
