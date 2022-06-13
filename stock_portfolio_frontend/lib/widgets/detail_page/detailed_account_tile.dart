import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;

import 'detailed_ticker_tile.dart';
import '../ticker_text.dart';

class DetailedAccountTileWidget extends StatefulWidget {
  final Map account;
  const DetailedAccountTileWidget({
    Key? key,
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
