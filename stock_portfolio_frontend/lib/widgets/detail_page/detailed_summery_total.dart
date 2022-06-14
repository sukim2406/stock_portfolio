import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;

class DetailedSummeryTotalWidget extends StatefulWidget {
  final List accounts;
  const DetailedSummeryTotalWidget({
    Key? key,
    required this.accounts,
  }) : super(key: key);

  @override
  State<DetailedSummeryTotalWidget> createState() =>
      _DetailedSummeryTotalWidgetState();
}

class _DetailedSummeryTotalWidgetState
    extends State<DetailedSummeryTotalWidget> {
  double getCostBasis() {
    double cost = 0;
    for (Map account in widget.accounts) {
      for (Map ticker in account['positions']) {
        cost += double.parse(ticker['cost_basis']);
      }
    }
    return cost;
  }

  double getCurrentValue() {
    double value = 0;
    for (Map account in widget.accounts) {
      for (Map ticker in account['positions']) {
        value += double.parse(ticker['market_value']);
      }
    }
    return value;
  }

  double getPl() {
    double cost = getCostBasis();
    double value = getCurrentValue();

    double pl = value - cost;

    return pl;
  }

  double getPLPercent() {
    double pl = getPl();
    double cost = getCostBasis();

    double plpc = (pl / cost) * 100;

    return plpc;
  }

  double getCash() {
    double cash = 0;
    for (Map account in widget.accounts) {
      cash += double.parse(account['cash']);
    }
    return cash;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: global.getDetailedSummeryHeight(context),
      width: global.getDetailedSummeryWidth(context),
      child: (widget.accounts[0]['title'] != null)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Accounts',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        widget.accounts.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Cost basis',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        getCostBasis().toStringAsFixed(2),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Current Value',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        getCurrentValue().toStringAsFixed(2),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'P & L',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        getPl().toStringAsFixed(2),
                        style: TextStyle(
                          color: global.plColor(
                            getPl(),
                          ),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'P & L %',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        getPLPercent().toStringAsFixed(2),
                        style: TextStyle(
                          color: global.plColor(
                            getPLPercent(),
                          ),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Cash Left',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        getCash().toStringAsFixed(2),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
