import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;
import '../../controllers/api_controllers.dart';

import '../../widgets/rounded_btn.dart';
import '../../widgets/alpaca_summery.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Map alpacaAccount = {};
  @override
  void initState() {
    super.initState();
    ApiControllers.instance.getAlpacaAccount().then((result) {
      setState(() {
        alpacaAccount = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(alpacaAccount.toString());
    return Scaffold(
      body: Container(
        height: global.getHeight(context),
        width: global.getWidth(context) * .9,
        color: global.baseColor,
        child: Column(
          children: [
            Row(
              children: [
                AlpacaSummeryWidget(
                  account: alpacaAccount,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
