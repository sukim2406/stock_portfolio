import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;

import '../card.dart';
import 'summery_tile.dart';

class TotalSummeryWidget extends StatefulWidget {
  final List accounts;
  const TotalSummeryWidget({
    Key? key,
    required this.accounts,
  }) : super(key: key);

  @override
  State<TotalSummeryWidget> createState() => _TotalSummeryWidgetState();
}

class _TotalSummeryWidgetState extends State<TotalSummeryWidget> {
  bool checkData() {
    Map data = widget.accounts[0];
    if (data['positions'] != null) {
      if (data['cash'] != null) {
        if (data['title'] != null) {
          return true;
        }
      }
    }
    return false;
  }

  double getAccountCost(Map account) {
    double totalCost = 0;
    if (account['positions'] != null) {
      for (Map ticker in account['positions']) {
        totalCost += double.parse(ticker['cost_basis']);
      }
    }
    return totalCost;
  }

  double getPortfolioCost(List accounts) {
    double portfolioCost = 0;
    for (Map account in accounts) {
      portfolioCost += getAccountCost(account);
    }

    return portfolioCost;
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

  double getPortfolioValue(List accounts) {
    double portfolioValue = 0;
    for (Map account in accounts) {
      portfolioValue += getAccountValue(account);
    }
    return portfolioValue;
  }

  double getPortfolioCash(List accounts) {
    double portfolioCash = 0;
    for (Map account in accounts) {
      portfolioCash += double.parse(account['cash']);
    }
    return portfolioCash;
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      height: global.getHeight(context),
      width: global.getSummeryWidth(context),
      title: 'Total Portfolio Summery',
      content: (checkData())
          ? SizedBox(
              height: global.getHeight(context) * .9,
              child: Column(
                children: [
                  SizedBox(
                    height: global.getHeight(context) * .8,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                      ),
                      itemCount: widget.accounts.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map accountData = widget.accounts[index];
                        accountData['cost'] =
                            getAccountCost(widget.accounts[index]);
                        accountData['value'] =
                            getAccountValue(widget.accounts[index]);
                        return SummeryTileWidget(
                          accountData: accountData,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  SizedBox(
                    width: global.getSummeryWidth(context),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Cash : ',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                children: [
                                  TextSpan(
                                    text: getPortfolioCash(widget.accounts)
                                        .toStringAsFixed(2),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'P/L : ',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                children: [
                                  TextSpan(
                                    text: (getPortfolioValue(widget.accounts) -
                                            getPortfolioCost(widget.accounts))
                                        .toStringAsFixed(2),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: global.plColor(getPortfolioValue(
                                              widget.accounts) -
                                          getPortfolioCost(widget.accounts)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Cost : ',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                children: [
                                  TextSpan(
                                    text: getPortfolioCost(widget.accounts)
                                        .toStringAsFixed(2),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Value : ',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                children: [
                                  TextSpan(
                                    text: getPortfolioValue(widget.accounts)
                                        .toStringAsFixed(2),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(
              height: global.getHeight(context) * .9,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
