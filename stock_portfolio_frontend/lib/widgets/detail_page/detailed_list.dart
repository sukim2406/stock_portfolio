import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;

import '../card.dart';
import 'detailed_account_tile.dart';

class DetailedListWidget extends StatefulWidget {
  final List accounts;
  const DetailedListWidget({
    Key? key,
    required this.accounts,
  }) : super(key: key);

  @override
  State<DetailedListWidget> createState() => _DetailedListWidgetState();
}

class _DetailedListWidgetState extends State<DetailedListWidget> {
  double getAccountCost(Map account) {
    double totalCost = 0;
    if (account['positions'] != null) {
      for (Map ticker in account['positions']) {
        totalCost += double.parse(ticker['cost_basis']);
      }
    }
    return totalCost;
  }

  double getAccountValue(Map account) {
    double marketValue = 0;
    if (account['positions'] != null) {
      for (Map ticker in account['positions']) {
        marketValue += double.parse(ticker['market_value']);
      }
    }
    return marketValue;
  }

  void calcAccountTotals() {
    if (widget.accounts[0]['title'] != null) {
      for (Map account in widget.accounts) {
        print(account.toString());
        account['account_cost'] = getAccountCost(account).toStringAsFixed(2);
        account['account_value'] = getAccountValue(account).toStringAsFixed(2);
        account['account_pl'] =
            (getAccountValue(account) - getAccountCost(account))
                .toStringAsFixed(2);
        account['account_plpc'] =
            ((getAccountValue(account) - getAccountCost(account)) /
                    getAccountCost(account) *
                    100)
                .toStringAsFixed(2);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    calcAccountTotals();
    return CardWidget(
      height: global.getHeight(context) * .68,
      width: global.getDetailedWidth(context),
      title: 'Detailed Portfolio',
      content: (widget.accounts[0]['title'] != null)
          ? Column(
              children: [
                SizedBox(
                  height: global.getHeight(context) * .63,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    itemCount: widget.accounts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return DetailedAccountTileWidget(
                        account: widget.accounts[index],
                      );
                    },
                  ),
                ),
              ],
            )
          : SizedBox(
              height: global.getHeight(context) * .63,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
