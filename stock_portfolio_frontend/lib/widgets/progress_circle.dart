import 'package:flutter/material.dart';

import '../controllers/global_controllers.dart' as global;

class ProgressCircleWidget extends StatefulWidget {
  const ProgressCircleWidget({Key? key}) : super(key: key);

  @override
  State<ProgressCircleWidget> createState() => _ProgressCircleWidgetState();
}

class _ProgressCircleWidgetState extends State<ProgressCircleWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorTween;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );
    _colorTween = _animationController.drive(ColorTween(
      begin: global.accentColor,
      end: Colors.redAccent,
    ));
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: _colorTween,
      ),
    );
  }
}
