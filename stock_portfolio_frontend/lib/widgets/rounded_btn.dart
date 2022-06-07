import 'package:flutter/material.dart';

class RoundedBtnWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final VoidCallback func;
  final String label;
  final Color color;
  const RoundedBtnWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.func,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: func,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                side: BorderSide(
                  color: color,
                )),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
