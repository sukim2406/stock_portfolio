import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;

import '../../widgets/card.dart';

class AboutDeveloperWidget extends StatelessWidget {
  const AboutDeveloperWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      height: global.getHeight(context) * .35,
      width: global.getWidth(context) * .9,
      content: SizedBox(
        height: global.getHeight(context) * .3,
        width: global.getWidth(context) * .9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Soun Sean Kim',
              style: TextStyle(
                color: global.accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Text(
              'ssk.sosodev@gmail.com',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const Text(
              'https://github.com/sukim2406',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const Text(
              'sounseankim.com',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      title: 'About Developer',
    );
  }
}
