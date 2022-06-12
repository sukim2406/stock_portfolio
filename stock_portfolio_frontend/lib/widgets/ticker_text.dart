import 'package:flutter/material.dart';

import '../controllers/global_controllers.dart' as global;

class TickerTextWidget extends StatelessWidget {
  final bool plValue;
  final String text;
  final String value;
  const TickerTextWidget({
    Key? key,
    required this.plValue,
    required this.text,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: text,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(
                color: (plValue)
                    ? global.plColor(
                        double.parse(value),
                      )
                    : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
    );
  }
}
