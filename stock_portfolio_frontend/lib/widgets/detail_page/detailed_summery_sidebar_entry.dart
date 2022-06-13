import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;

class DetailedSummerySideBarEntryWidget extends StatelessWidget {
  final String title;
  final bool selected;
  const DetailedSummerySideBarEntryWidget({
    Key? key,
    required this.title,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: global.getWidth(context) * 1,
      color: (selected) ? Colors.black : Colors.grey[900],
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
