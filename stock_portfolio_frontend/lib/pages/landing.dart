import 'package:flutter/material.dart';

import '../widgets/side_bar.dart';

import '../pages/landing_subpages/logout.dart';

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
      const Text('home'),
      const Text('hi'),
      const Text('bye'),
      LogoutPage(updateCurUser: widget.updateCurUser),
    ];
    return Scaffold(
      body: SizedBox(
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
