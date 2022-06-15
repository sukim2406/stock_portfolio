import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;

import '../../widgets/card.dart';
import '../../widgets/detail_page/detailed_summery_sidebar.dart';
import '../../widgets/detail_page/detailed_summery_total.dart';
import '../../widgets/detail_page/detailed_summery_new_account.dart';
import '../../widgets/detail_page/detailed_summery_update_ticker.dart';

class DetailedSummeryWidget extends StatefulWidget {
  final VoidCallback updateAccounts;
  final List accounts;
  const DetailedSummeryWidget({
    Key? key,
    required this.accounts,
    required this.updateAccounts,
  }) : super(key: key);

  @override
  State<DetailedSummeryWidget> createState() => _DetailedSummeryWidgetState();
}

class _DetailedSummeryWidgetState extends State<DetailedSummeryWidget> {
  int _curIndex = 0;

  updatePage(int newIndex) {
    setState(() {
      _curIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      DetailedSummeryTotalWidget(
        accounts: widget.accounts,
      ),
      DetailedSummeryNewAccountWidget(
        updateAccounts: widget.updateAccounts,
      ),
      DetailedSummeryUpdateTicker(
        updateAccounts: widget.updateAccounts,
        accounts: widget.accounts,
      ),
    ];

    return CardWidget(
      height: global.getHeight(context) * .28,
      width: global.getWidth(context) * .88,
      title: 'Detailed Summery',
      content: Row(
        children: [
          DetailedSummerySideBarWidget(
              index: _curIndex, updatePage: updatePage),
          Expanded(
            child: Center(
              child: pages[_curIndex],
            ),
          )
        ],
      ),
    );
  }
}
