import 'dart:core';

import 'package:flutter/material.dart';

import '../controllers/global_controllers.dart' as global;

import '../widgets/summery_ticker_tile.dart';

class SummeryTileWidget extends StatefulWidget {
  final Map accountData;
  const SummeryTileWidget({
    Key? key,
    required this.accountData,
  }) : super(key: key);

  @override
  State<SummeryTileWidget> createState() => _SummeryTileWidgetState();
}

class _SummeryTileWidgetState extends State<SummeryTileWidget> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
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
                widget.accountData['title'],
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
                    itemCount: widget.accountData['positions'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return SummeryTickerTileWidget(
                        ticker: widget.accountData['positions'][index]
                            ['symbol'],
                        pl: double.parse(widget.accountData['positions'][index]
                            ['unrealized_pl']),
                        plpc: double.parse(widget.accountData['positions']
                            [index]['unrealized_plpc']),
                        qty: int.parse(
                            widget.accountData['positions'][index]['qty']),
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
                Row(
                  children: [
                    SizedBox(
                      width: global.getSummeryWidth(context) / 2,
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: 'Account Cash : ',
                          children: [
                            TextSpan(
                              text: widget.accountData['cash'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: global.getSummeryWidth(context) / 2,
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: 'Account P/L : ',
                          children: [
                            TextSpan(
                              text: (widget.accountData['value'] -
                                      widget.accountData['cost'])
                                  .toStringAsFixed(2),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: global.plColor(
                                    widget.accountData['value'] -
                                        widget.accountData['cost']),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: global.getSummeryWidth(context) / 2,
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: 'Account Cost : ',
                          children: [
                            TextSpan(
                              text:
                                  widget.accountData['cost'].toStringAsFixed(2),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: global.getSummeryWidth(context) / 2,
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: 'Account Value : ',
                          children: [
                            TextSpan(
                              text: widget.accountData['value']
                                  .toStringAsFixed(2),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
