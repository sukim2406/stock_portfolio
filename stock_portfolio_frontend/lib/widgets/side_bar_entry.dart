import 'package:flutter/material.dart';

class SideBarEntryWidget extends StatelessWidget {
  final Icon icon;
  final Icon selectedIcon;
  final String text;
  final bool selected;
  const SideBarEntryWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.selectedIcon,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (selected) ? selectedIcon : icon,
        (selected) ? Container() : Text(text),
      ],
    );
  }
}
