import 'package:flutter/material.dart';

class InfoTextWidget extends StatelessWidget {
  final String label;
  final String content;
  const InfoTextWidget({
    Key? key,
    required this.label,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: Colors.grey,
        ),
        children: [
          TextSpan(
            text: content,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
