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
  final List _accounts = [];
  final Map _defaultAccount = {};

  void initAlpacaAccount() {
    ApiControllers.instance.getAlpacaAccount().then(
      (result) {
        setState(
          () {
            _alpacaAccount = result;
            _defaultAccount['cash'] = result['cash'];
            _defaultAccount['title'] = 'Alpaca';
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
    });
  }

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

  void initCustomAccounts() {
    ApiControllers.instance.getAccountLists().then(
      (result) {
        if (result.length != 0) {
          for (Map account in result) {
            ApiControllers.instance.listTicker(account['title']).then(
              (results) {
                List positions = [];
                for (Map result in results) {
                  Map sortedMap = {
                    'symbol': result['ticker'],
                    'qty': result['qty'],
                    'cost_basis':
                        (double.parse(result['averagePrice']) * result['qty'])
                            .toString(),
                    'market_value':
                        (double.parse(result['currentPrice']) * result['qty'])
                            .toString(),
                    'unrealized_pl': ((double.parse(result['currentPrice']) *
                                result['qty']) -
                            (double.parse(result['averagePrice']) *
                                result['qty']))
                        .toString(),
                    'unrealized_plpc': (((double.parse(result['currentPrice']) *
                                    result['qty']) -
                                (double.parse(result['averagePrice']) *
                                    result['qty'])) /
                            (double.parse(result['averagePrice']) *
                                result['qty']))
                        .toString(),
                  };
                  sortedMap['qty'] = sortedMap['qty'].toString();
                  positions.add(sortedMap);
                }
                account['positions'] = positions;

                setState(
                  () {
                    _accounts.add(account);
                  },
                );
              },
            );
          }
        }
      },
    );
  }

  void clearData() {
    setState(() {
      _accounts.clear();
      _alpacaAccount.clear();
      _defaultAccount.clear();
    });
  }

  void updateAccounts() {
    clearData();
    initAlpacaAccount();
    initCustomAccounts();
  }

  @override
  void initState() {
    super.initState();
    initAlpacaAccount();
    initCustomAccounts();
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
                QuickAddWidget(
                  newAccountCallback: updateAccounts,
                  accounts: _accounts,
                ),
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
