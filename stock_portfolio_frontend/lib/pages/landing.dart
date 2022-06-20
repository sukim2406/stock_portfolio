import 'package:flutter/material.dart';

import '../controllers/global_controllers.dart' as global;

import '../widgets/side_bar.dart';

import '../pages/landing_subpages/logout.dart';
import '../pages/landing_subpages/dashboard.dart';
import '../pages/landing_subpages/detail.dart';
import '../pages/landing_subpages/activities.dart';
import '../pages/landing_subpages/settings.dart';

class LandingPage extends StatefulWidget {
  final VoidCallback updateCurUser;
  const LandingPage({
    Key? key,
    required this.updateCurUser,
  }) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _curIndex = 0;

  updatePage(int newIndex) {
    setState(() {
      _curIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const DashboardPage(),
      const DetailPage(),
      const ActivitiesPage(),
      const SettingsPage(),
      LogoutPage(updateCurUser: widget.updateCurUser),
    ];
    return Scaffold(
      body: Container(
        color: global.baseColor,
        child: Row(
          children: [
            SideBarWidget(index: _curIndex, updatePage: updatePage),
            Expanded(
              child: Center(
                child: pages[_curIndex],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
