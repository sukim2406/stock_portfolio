import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;

import '../../widgets/card.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: global.getHeight(context),
        width: global.getWidth(context) * .9,
        color: global.baseColor,
        child: CardWidget(
          height: global.getHeight(context) * .95,
          width: global.getWidth(context) * .9,
          title: 'Activities',
          content: const Center(
            child: Text(
              'hello world',
              style: TextStyle(
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
