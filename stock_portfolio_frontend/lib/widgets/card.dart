import 'package:flutter/material.dart';

import '../controllers/global_controllers.dart' as global;

class CardWidget extends StatelessWidget {
  final double height;
  final double width;
  final Widget content;
  final String title;
  const CardWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.content,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      color: global.backgroundColor,
      child: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              height: global.getHeight(context) * .05,
              width: width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: global.accentColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                    15,
                  ),
                  topRight: Radius.circular(
                    15,
                  ),
                ),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content,
          ],
        ),
      ),
    );
  }
}
