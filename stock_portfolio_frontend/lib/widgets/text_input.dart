import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final double width;
  final String label;
  final TextEditingController controller;
  final bool obsecure;
  final bool enabled;
  const TextInputWidget({
    Key? key,
    required this.width,
    required this.label,
    required this.controller,
    required this.obsecure,
    required this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        enabled: enabled,
        obscureText: obsecure,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.lightBlueAccent,
            ),
          ),
        ),
      ),
    );
  }
}
