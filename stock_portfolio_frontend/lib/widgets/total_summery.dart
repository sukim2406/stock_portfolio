import 'package:flutter/material.dart';

import '../controllers/global_controllers.dart' as global;

import '../widgets/card.dart';
import '../widgets/summery_tile.dart';

class TotalSummeryWidget extends StatelessWidget {
  final List alpacaPositions;
  const TotalSummeryWidget({
    Key? key,
    required this.alpacaPositions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      height: global.getHeight(context),
      width: global.getSummeryWidth(context),
      title: 'Total Portfolio Summery',
      content: SizedBox(
        child: Column(
          children: [
            SummeryTileWidget(
              title: 'Alpaca - default : Click to expand',
              positions: alpacaPositions,
            ),
          ],
        ),
      ),
    );
  }
}
