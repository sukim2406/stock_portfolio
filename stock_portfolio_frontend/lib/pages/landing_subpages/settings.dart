import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;

import '../../widgets/settings_page/settings_card.dart';

class SettingsPage extends StatefulWidget {
  final VoidCallback updateCurUser;
  const SettingsPage({
    Key? key,
    required this.updateCurUser,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: global.getHeight(context),
      width: global.getWidth(context) * .9,
      color: global.baseColor,
      child: SettingsCardWidget(
        updateCurUser: widget.updateCurUser,
      ),
    ));
  }
}
