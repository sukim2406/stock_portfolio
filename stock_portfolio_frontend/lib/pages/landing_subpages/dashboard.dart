import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;
import '../../controllers/api_controllers.dart';

import '../../widgets/alpaca_summery.dart';
import '../../widgets/total_summery.dart';
import '../../widgets/quick_add.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Map _alpacaAccount = {};
  List _accounts = [];
  Map _defaultAccount = {};

  void sortPositions(rawData) {
    List alpacaPositions = [];
    for (Map position in rawData) {
      Map sortedMap = {};
      sortedMap['symbol'] = position['symbol'];
      sortedMap['qty'] = position['qty'];
      sortedMap['unrealized_pl'] = position['unrealized_pl'];
      sortedMap['unrealized_plpc'] = position['unrealized_plpc'];
      sortedMap['market_value'] = position['market_value'];
      sortedMap['cost_basis'] = position['cost_basis'];
      alpacaPositions.add(sortedMap);
    }
    setState(() {
      _defaultAccount['positions'] = alpacaPositions;
    });
  }

  @override
  void initState() {
    super.initState();
    ApiControllers.instance.getAlpacaAccount().then(
      (result) {
        setState(
          () {
            _alpacaAccount = result;
            _defaultAccount['cash'] = result['cash'];
            _defaultAccount['title'] = 'Alpaca - default : Click to expand';
          },
        );
      },
    );
    ApiControllers.instance.getAlpacaPositions().then(
      (result) {
        sortPositions(result);
      },
    );
    setState(() {
      _accounts.add(_defaultAccount);
      _accounts.add(_defaultAccount);
      _accounts.add(_defaultAccount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: global.getHeight(context),
        width: global.getWidth(context) * .9,
        color: global.baseColor,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AlpacaSummeryWidget(
                  account: _alpacaAccount,
                ),
                const QuickAddWidget(),
              ],
            ),
            TotalSummeryWidget(
              accounts: _accounts,
            ),
          ],
        ),
      ),
    );
  }
}
