import 'package:flutter/material.dart';
import 'package:stock_portfolio_frontend/controllers/api_controllers.dart';

import '../../controllers/global_controllers.dart' as global;

import 'detailed_ticker_tile.dart';
import '../ticker_text.dart';

class DetailedAccountTileWidget extends StatefulWidget {
  final VoidCallback updateAccounts;
  final Map account;
  const DetailedAccountTileWidget({
    Key? key,
    required this.updateAccounts,
    required this.account,
  }) : super(key: key);

  @override
  State<DetailedAccountTileWidget> createState() =>
      _DetailedAccountTileWidgetState();
}

class _DetailedAccountTileWidgetState extends State<DetailedAccountTileWidget> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      width: global.getDetailedWidth(context),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(
                () {
                  _expanded = !_expanded;
                },
              );
            },
            child: Container(
              width: global.getDetailedWidth(context),
              height: global.getHeight(context) * .05,
              color: Colors.grey[900],
              child: Row(
                children: [
                  SizedBox(
                    width: global.getWidth(context) * .025,
                  ),
                  Text(
                    widget.account['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: global.getWidth(context) * .025,
                  ),
                  (widget.account['title'] == 'Alpaca')
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Delete account'),
                                    content: const Text(
                                        'Are you sure to delete this account?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          ApiControllers.instance
                                              .deleteAccount(
                                                  widget.account['title'])
                                              .then(
                                            (result) {
                                              if (result) {
                                                widget.updateAccounts();
                                              } else {
                                                global.printErrorBar(context,
                                                    'Delete account failed');
                                              }
                                            },
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                        ),
                  Expanded(
                    child: Container(),
                  ),
                  (_expanded)
                      ? const Icon(Icons.arrow_upward)
                      : const Icon(Icons.arrow_downward),
                  SizedBox(
                    width: global.getWidth(context) * .025,
                  ),
                ],
              ),
            ),
          ),
          (_expanded)
              ? SizedBox(
                  width: global.getDetailedWidth(context),
                  child: (widget.account['positions'] != null &&
                          widget.account['positions'].isNotEmpty)
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.account['positions'].length,
                          itemBuilder: (BuildContext context, int index) {
                            return DetailedTickerTileWidget(
                                ticker: widget.account['positions'][index]);
                          },
                        )
                      : const Center(
                          child: Text(
                            'No tickers yet',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                )
              : Container(),
          GestureDetector(
            onTap: () {
              setState(
                () {
                  _expanded = !_expanded;
                },
              );
            },
            child: Container(
              width: global.getDetailedWidth(context),
              height: global.getHeight(context) * .05,
              color: Colors.grey[900],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TickerTextWidget(
                    plValue: false,
                    text: 'Cash : ',
                    value: widget.account['cash'],
                  ),
                  TickerTextWidget(
                    plValue: false,
                    text: 'Acct. cost : ',
                    value: widget.account['account_cost'],
                  ),
                  TickerTextWidget(
                    plValue: false,
                    text: 'Acct. value : ',
                    value: widget.account['account_value'],
                  ),
                  TickerTextWidget(
                    plValue: true,
                    text: 'Acct. P&L : ',
                    value: widget.account['account_pl'],
                  ),
                  TickerTextWidget(
                    plValue: true,
                    text: 'Acct. P&L % : ',
                    value: widget.account['account_plpc'],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
