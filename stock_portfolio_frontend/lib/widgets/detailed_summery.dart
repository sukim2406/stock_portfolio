import 'package:flutter/material.dart';

import '../controllers/global_controllers.dart' as global;

import '../widgets/card.dart';

class DetailedSummeryWidget extends StatefulWidget {
  const DetailedSummeryWidget({Key? key}) : super(key: key);

  @override
  State<DetailedSummeryWidget> createState() => _DetailedSummeryWidgetState();
}

class _DetailedSummeryWidgetState extends State<DetailedSummeryWidget> {
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      height: global.getHeight(context) * .28,
      width: global.getWidth(context) * .88,
      content: Text('hi'),
      title: 'Detailed Summery',
    );
  }
}
