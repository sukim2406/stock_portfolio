import 'package:flutter/material.dart';

import '../controllers/global_controllers.dart' as global;

import '../widgets/card.dart';
import '../widgets/detailed_account_tile.dart';

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
  @override
  Widget build(BuildContext context) {
    print(widget.accounts);
    return CardWidget(
      height: global.getHeight(context) * .68,
      width: global.getDetailedWidth(context),
      title: 'Detailed Portfolio',
      content: Column(
        children: [
          SizedBox(
            height: global.getHeight(context) * .58,
            child: ListView.builder(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
              ),
              itemCount: widget.accounts.length,
              itemBuilder: (BuildContext context, int index) {
                return DetailedAccountTileWidget();
              },
            ),
          ),
        ],
        // children: [
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: const [
        //       Text(
        //         'Account',
        //         style: TextStyle(
        //           color: Colors.white,
        //         ),
        //       ),
        //       Text(
        //         'Cash',
        //         style: TextStyle(
        //           color: Colors.white,
        //         ),
        //       ),
        //       Text(
        //         'Account P&L',
        //         style: TextStyle(
        //           color: Colors.white,
        //         ),
        //       ),
        //       Text(
        //         'Account P&L %',
        //         style: TextStyle(
        //           color: Colors.white,
        //         ),
        //       ),
        //       Text(
        //         'Mkt Value',
        //         style: TextStyle(
        //           color: Colors.white,
        //         ),
        //       ),
        //     ],
        //   ),
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: const [
        //       Text(
        //         'Ticker',
        //         style: TextStyle(
        //           color: Colors.white,
        //         ),
        //       ),
        //       Text(
        //         'Quantity',
        //         style: TextStyle(
        //           color: Colors.white,
        //         ),
        //       ),
        //       Text(
        //         'Mkt Value',
        //         style: TextStyle(
        //           color: Colors.white,
        //         ),
        //       ),
        //       Text(
        //         'Open P&L',
        //         style: TextStyle(
        //           color: Colors.white,
        //         ),
        //       ),
        //       Text(
        //         'Open P&L %',
        //         style: TextStyle(
        //           color: Colors.white,
        //         ),
        //       ),
        //       Text(
        //         'Last Price',
        //         style: TextStyle(
        //           color: Colors.white,
        //         ),
        //       ),
        //       Text(
        //         'Avg Price',
        //         style: TextStyle(
        //           color: Colors.white,
        //         ),
        //       ),
        //     ],
        //   ),
        // ],
      ),
    );
  }
}
