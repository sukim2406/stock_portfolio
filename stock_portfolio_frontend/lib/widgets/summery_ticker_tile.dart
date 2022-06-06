import 'dart:core';
import 'package:flutter/material.dart';

import '../controllers/global_controllers.dart' as global;

class SummeryTickerTileWidget extends StatelessWidget {
  final String ticker;
  final double pl;
  final double plpc;
  final int qty;
  const SummeryTickerTileWidget({
    Key? key,
    required this.ticker,
    required this.pl,
    required this.plpc,
    required this.qty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      width: global.getSummeryWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            ticker,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            qty.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          Column(
            children: [
              RichText(
                text: TextSpan(
                  text: 'P/L : ',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                        text: pl.toStringAsFixed(2),
                        style: TextStyle(
                          color: global.plColor(pl),
                        ))
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'P/L(%) : ',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: (plpc > 0)
                          ? '${((plpc - 1) * 100).toStringAsFixed(2)}%'
                          : '${(plpc * 100).toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: global.plColor(plpc),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
