import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;

import '../ticker_text.dart';

class DetailedTickerTileWidget extends StatelessWidget {
  final Map ticker;
  const DetailedTickerTileWidget({
    Key? key,
    required this.ticker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      width: global.getDetailedWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            ticker['symbol'],
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          TickerTextWidget(
            plValue: false,
            text: 'Qty : ',
            value: ticker['qty'],
          ),
          TickerTextWidget(
            plValue: false,
            text: 'last Price : ',
            value: ticker['lastPrice'],
          ),
          TickerTextWidget(
            plValue: false,
            text: 'avg. Price : ',
            value: ticker['avg_price'],
          ),
          TickerTextWidget(
            plValue: false,
            text: 'Cost Basis : ',
            value: ticker['cost_basis'],
          ),
          TickerTextWidget(
            plValue: false,
            text: 'Mkt Value : ',
            value: ticker['market_value'],
          ),
          TickerTextWidget(
            plValue: true,
            text: 'P&L : ',
            value: ticker['unrealized_pl'],
          ),
          TickerTextWidget(
            plValue: true,
            text: 'P&L % : ',
            value: ticker['unrealized_plpc'],
          ),
        ],
      ),
    );
  }
}
