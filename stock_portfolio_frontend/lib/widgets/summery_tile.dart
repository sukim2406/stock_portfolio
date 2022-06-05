import 'dart:core';

import 'package:flutter/material.dart';

import '../controllers/global_controllers.dart' as global;

import '../widgets/summery_ticker_tile.dart';

class SummeryTileWidget extends StatefulWidget {
  final String title;
  final List positions;
  const SummeryTileWidget({
    Key? key,
    required this.title,
    required this.positions,
  }) : super(key: key);

  @override
  State<SummeryTileWidget> createState() => _SummeryTileWidgetState();
}

class _SummeryTileWidgetState extends State<SummeryTileWidget> {
  double _totalCost = 0;
  double _marketValue = 0;
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    for (Map ticker in widget.positions) {
      _totalCost += double.parse(ticker['cost_basis']);
      _marketValue += double.parse(ticker['market_value']);
    }
    return Container(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      width: global.getSummeryWidth(context),
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
              width: global.getSummeryWidth(context),
              height: global.getHeight(context) * .05,
              alignment: Alignment.centerLeft,
              color: Colors.grey,
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          (_expanded)
              ? SizedBox(
                  width: global.getSummeryWidth(context),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.positions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SummeryTickerTileWidget(
                        ticker: widget.positions[index]['symbol'],
                        pl: double.parse(
                            widget.positions[index]['unrealized_pl']),
                        plpc: double.parse(
                            widget.positions[index]['unrealized_plpc']),
                        qty: int.parse(widget.positions[index]['qty']),
                      );
                    },
                  ),
                )
              : Container(),
          Container(
            width: global.getSummeryWidth(context),
            alignment: Alignment.bottomRight,
            color: Colors.grey,
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Total Cost : ',
                    children: [
                      TextSpan(
                        text: _totalCost.toStringAsFixed(2),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Market Value : ',
                    children: [
                      TextSpan(
                        text: _marketValue.toStringAsFixed(2),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Total P/L : ',
                    children: [
                      TextSpan(
                        text: (_marketValue - _totalCost).toStringAsFixed(2),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ((_marketValue - _totalCost) > 0)
                              ? Colors.greenAccent
                              : Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
