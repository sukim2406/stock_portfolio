import 'package:flutter/material.dart';

import '../controllers/global_controllers.dart' as global;

import '../widgets/card.dart';

class QuickAddWidget extends StatefulWidget {
  const QuickAddWidget({Key? key}) : super(key: key);

  @override
  State<QuickAddWidget> createState() => _QuickAddWidgetState();
}

class _QuickAddWidgetState extends State<QuickAddWidget> {
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      height: global.getHeight(context) * .55,
      width: global.getWidth(context) * .44,
      title: 'Quick Add',
      content: Center(
        child: Text('hi'),
      ),
    );
  }
}
