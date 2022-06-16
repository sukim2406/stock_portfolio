import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;
import '../../controllers/api_controllers.dart';

import '../../widgets/text_input.dart';
import '../../widgets/rounded_btn.dart';

class DetailedSummeryUpdateTicker extends StatefulWidget {
  final VoidCallback updateAccounts;
  final List accounts;
  const DetailedSummeryUpdateTicker({
    Key? key,
    required this.accounts,
    required this.updateAccounts,
  }) : super(key: key);

  @override
  State<DetailedSummeryUpdateTicker> createState() =>
      _DetailedSummeryUpdateTickerState();
}

class _DetailedSummeryUpdateTickerState
    extends State<DetailedSummeryUpdateTicker> {
  late List<String> accountList;
  List<String> actionList = [
    'buy',
    'sell',
    'deposit',
    'withdraw',
  ];
  late String? selectedAccount;
  late String? selectedAction;
  late TextEditingController tickerController;
  late TextEditingController priceController;
  late TextEditingController qtyController;

  @override
  void initState() {
    super.initState();

    accountList = [];
    for (Map account in widget.accounts) {
      accountList.add(account['title']);
    }

    selectedAccount = accountList[0];
    selectedAction = actionList[0];

    tickerController = TextEditingController();
    priceController = TextEditingController();
    qtyController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: global.getDetailedSummeryHeight(context),
      width: global.getDetailedSummeryWidth(context),
      child: Row(
        children: [
          SizedBox(
            height: global.getDetailedSummeryHeight(context),
            width: global.getDetailedSummeryWidth(context) * .25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'select account',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                DropdownButton<String>(
                  value: selectedAccount,
                  items: accountList
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (item) => setState(
                    () => selectedAccount = item,
                  ),
                ),
                const Text(
                  'select action',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                DropdownButton<String>(
                  value: selectedAction,
                  items: actionList
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (item) => setState(
                    () => selectedAction = item,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: global.getDetailedSummeryHeight(context),
            width: global.getDetailedSummeryWidth(context) * .75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (selectedAccount == 'Alpaca')
                    ? const Text(
                        '% CAUTION : Buy & Sell action using Alpaca accounts will place actual limit order through connected Alpaca Account %',
                        style: TextStyle(
                          color: Colors.redAccent,
                        ),
                      )
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextInputWidget(
                      width: global.getDetailedSummeryWidth(context) * .1,
                      label: 'Ticker',
                      controller: tickerController,
                      obsecure: false,
                      enabled:
                          (selectedAction == 'buy' || selectedAction == 'sell')
                              ? true
                              : false,
                    ),
                    TextInputWidget(
                      width: global.getDetailedSummeryWidth(context) * .1,
                      label: 'Qty',
                      controller: qtyController,
                      obsecure: false,
                      enabled:
                          (selectedAction == 'buy' || selectedAction == 'sell')
                              ? true
                              : false,
                    ),
                    TextInputWidget(
                      width: global.getDetailedSummeryWidth(context) * .1,
                      label: (selectedAction == 'deposit' ||
                              selectedAction == 'withdraw')
                          ? 'Amount'
                          : 'Price',
                      controller: priceController,
                      obsecure: false,
                      enabled: true,
                    ),
                    RoundedBtnWidget(
                      height: null,
                      width: null,
                      func: () {
                        Map targetAccount = widget.accounts.firstWhere(
                          (account) => account['title'] == selectedAccount,
                        );
                        if (selectedAction == 'buy') {
                          if (selectedAccount == 'Alpaca') {
                            ApiControllers.instance
                                .alpacaQuickBuyOrder(
                              selectedAccount,
                              tickerController.text,
                              qtyController.text,
                              priceController.text,
                            )
                                .then((result) {
                              if (result) {
                                tickerController.clear();
                                priceController.clear();
                                qtyController.clear();
                                widget.updateAccounts();
                              } else {
                                global.printErrorBar(
                                    context, 'quick order error');
                              }
                            });
                          } else {
                            if (double.parse(targetAccount['cash']) -
                                    (double.parse(qtyController.text) *
                                        double.parse(priceController.text)) <
                                0) {
                              global.printErrorBar(
                                  context, 'Insufficient cash balance');
                            } else {
                              ApiControllers.instance
                                  .addStock(
                                selectedAccount,
                                tickerController.text,
                                qtyController.text,
                                priceController.text,
                              )
                                  .then((result) {
                                if (result) {
                                  ApiControllers.instance
                                      .addActivity(
                                          selectedAccount,
                                          'STOCK BUY',
                                          tickerController.text,
                                          priceController.text,
                                          qtyController.text)
                                      .then(
                                    (result) {
                                      if (result) {
                                        tickerController.clear();
                                        qtyController.clear();
                                        priceController.clear();
                                        widget.updateAccounts();
                                      } else {
                                        global.printErrorBar(
                                            context, 'Activity update error');
                                      }
                                    },
                                  );
                                } else {
                                  global.printErrorBar(
                                      context, 'Update unsuccessful');
                                }
                              });
                            }
                          }
                        } else if (selectedAction == 'sell') {
                          Map targetTicker =
                              targetAccount['positions'].firstWhere(
                            (position) =>
                                position['symbol'] == tickerController.text,
                          );
                          if (selectedAccount == 'Alpaca') {
                            ApiControllers.instance
                                .alpacaQuickSellOrder(
                              selectedAccount,
                              tickerController.text,
                              qtyController.text,
                              priceController.text,
                            )
                                .then((result) {
                              if (result) {
                                tickerController.clear();
                                priceController.clear();
                                qtyController.clear();
                                widget.updateAccounts();
                              } else {
                                global.printErrorBar(
                                    context, 'quick order error');
                              }
                            });
                          } else {
                            if (double.parse(targetTicker['qty']) -
                                    double.parse(qtyController.text) <
                                0) {
                              global.printErrorBar(context,
                                  'Selling qty cannot be larger than current qty');
                            } else if (double.parse(targetTicker['qty']) -
                                    double.parse(qtyController.text) ==
                                0) {
                              ApiControllers.instance
                                  .deletePosition(
                                      selectedAccount,
                                      tickerController.text,
                                      qtyController.text,
                                      priceController.text)
                                  .then((result) {
                                if (result) {
                                  ApiControllers.instance
                                      .addActivity(
                                          selectedAccount,
                                          'STOCK SELL',
                                          tickerController.text,
                                          priceController.text,
                                          qtyController.text)
                                      .then(
                                    (result) {
                                      if (result) {
                                        tickerController.clear();
                                        qtyController.clear();
                                        priceController.clear();
                                        widget.updateAccounts();
                                      } else {
                                        global.printErrorBar(
                                            context, 'Activity update error');
                                      }
                                    },
                                  );
                                } else {
                                  global.printErrorBar(
                                      context, 'Update unsuccessful');
                                }
                              });
                            } else {
                              ApiControllers.instance
                                  .removeStock(
                                      selectedAccount,
                                      tickerController.text,
                                      qtyController.text,
                                      priceController.text)
                                  .then(
                                (result) {
                                  if (result) {
                                    ApiControllers.instance
                                        .addActivity(
                                            selectedAccount,
                                            'STOCK SELL',
                                            tickerController.text,
                                            priceController.text,
                                            qtyController.text)
                                        .then(
                                      (result) {
                                        if (result) {
                                          tickerController.clear();
                                          qtyController.clear();
                                          priceController.clear();
                                          widget.updateAccounts();
                                        } else {
                                          global.printErrorBar(
                                              context, 'Activity update error');
                                        }
                                      },
                                    );
                                  } else {
                                    global.printErrorBar(
                                        context, 'Update unsuccessful');
                                  }
                                },
                              );
                            }
                          }
                        } else if (selectedAction == 'deposit' &&
                            selectedAccount != 'Alpaca') {
                          ApiControllers.instance
                              .depositCash(
                                  priceController.text, selectedAccount)
                              .then((result) {
                            if (result) {
                              ApiControllers.instance
                                  .addActivity(
                                selectedAccount,
                                'DEPOSIT',
                                selectedAccount,
                                priceController.text,
                                '',
                              )
                                  .then(
                                (result) {
                                  if (result) {
                                    tickerController.clear();
                                    qtyController.clear();
                                    priceController.clear();
                                    widget.updateAccounts();
                                  } else {
                                    global.printErrorBar(
                                        context, 'Activity update error');
                                  }
                                },
                              );
                            } else {
                              global.printErrorBar(
                                  context, 'Update unsuccessful');
                            }
                          });
                        } else if (selectedAction == 'withdraw' &&
                            selectedAccount != 'Alpaca') {
                          ApiControllers.instance
                              .withdrawCash(
                                  priceController.text, selectedAccount)
                              .then((result) {
                            if (result) {
                              ApiControllers.instance
                                  .addActivity(
                                selectedAccount,
                                'WITHDRAW',
                                selectedAccount,
                                priceController.text,
                                '',
                              )
                                  .then(
                                (result) {
                                  if (result) {
                                    tickerController.clear();
                                    qtyController.clear();
                                    priceController.clear();
                                    widget.updateAccounts();
                                  } else {
                                    global.printErrorBar(
                                        context, 'Activity update error');
                                  }
                                },
                              );
                            } else {
                              global.printErrorBar(
                                  context, 'Update unsuccessful');
                            }
                          });
                        } else {
                          global.printErrorBar(context,
                              'You cannot use deposit & withdraw function with alpaca account');
                        }
                      },
                      label: 'SUBMIT',
                      color: global.accentColor,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
