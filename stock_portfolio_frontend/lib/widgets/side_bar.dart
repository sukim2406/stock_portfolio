import 'package:flutter/material.dart';

import '../controllers/global_controllers.dart' as global;

import '../widgets/side_bar_entry.dart';

class SideBarWidget extends StatelessWidget {
  final int index;
  final void Function(int) updatePage;
  const SideBarWidget({
    Key? key,
    required this.index,
    required this.updatePage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: global.getHeight(context),
      width: global.getWidth(context) * .1,
      decoration: BoxDecoration(
        color: global.accentColor,
        border: Border.all(
          color: global.accentColor,
          width: 5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            20,
          ),
        ),
      ),
      // color: Colors.greenAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              updatePage(0);
            },
            child: SideBarEntryWidget(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              text: 'home',
              selected: (index == 0) ? true : false,
            ),
          ),
          GestureDetector(
            onTap: () {
              updatePage(1);
            },
            child: SideBarEntryWidget(
              icon: const Icon(Icons.add_box_outlined),
              selectedIcon: const Icon(Icons.add_box),
              text: 'add',
              selected: (index == 1) ? true : false,
            ),
          ),
          GestureDetector(
            onTap: () {
              updatePage(2);
            },
            child: SideBarEntryWidget(
              icon: const Icon(Icons.settings_outlined),
              selectedIcon: const Icon(Icons.settings),
              text: 'settings',
              selected: (index == 2) ? true : false,
            ),
          ),
          GestureDetector(
            onTap: () {
              updatePage(3);
            },
            child: SideBarEntryWidget(
              icon: const Icon(Icons.power_off_outlined),
              selectedIcon: const Icon(Icons.power_off),
              text: 'logout',
              selected: (index == 3) ? true : false,
            ),
          ),
        ],
      ),
    );
  }
}
