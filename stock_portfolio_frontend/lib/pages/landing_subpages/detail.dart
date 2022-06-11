import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;
import '../../controllers/api_controllers.dart';

import '../../widgets/detailed_list.dart';
import '../../widgets/detailed_summery.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
    // TODO: implement initState
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DetailedListWidget(
              accounts: _accounts,
            ),
            const DetailedSummeryWidget(),
          ],
        ),
      ),
    );
  }
}
