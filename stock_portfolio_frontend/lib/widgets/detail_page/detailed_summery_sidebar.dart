import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;

import 'detailed_summery_sidebar_entry.dart';

class DetailedSummerySideBarWidget extends StatelessWidget {
  final int index;
  final void Function(int) updatePage;

  const DetailedSummerySideBarWidget({
    Key? key,
    required this.index,
    required this.updatePage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: global.getHeight(context) * .23,
      width: global.getWidth(context) * .1,
      color: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              updatePage(0);
            },
            child: DetailedSummerySideBarEntryWidget(
              title: 'Total Summery',
              selected: (index == 0) ? true : false,
            ),
          ),
          GestureDetector(
            onTap: () {
              updatePage(1);
            },
            child: DetailedSummerySideBarEntryWidget(
              title: 'New Account',
              selected: (index == 1) ? true : false,
            ),
          ),
          GestureDetector(
            onTap: () {
              updatePage(2);
            },
            child: DetailedSummerySideBarEntryWidget(
              title: 'Update ticker',
              selected: (index == 2) ? true : false,
            ),
          ),
        ],
      ),
    );
  }
}
