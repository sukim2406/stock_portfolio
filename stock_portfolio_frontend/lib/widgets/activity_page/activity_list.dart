import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;
import '../../controllers/api_controllers.dart';

import '../../widgets/card.dart';
import '../../widgets/activity_page/activity_tile.dart';

class ActivityListWidget extends StatefulWidget {
  const ActivityListWidget({Key? key}) : super(key: key);

  @override
  State<ActivityListWidget> createState() => _ActivityListWidgetState();
}

class _ActivityListWidgetState extends State<ActivityListWidget> {
  List _activities = [];

  void initActivities() {
    ApiControllers.instance.getActivityLists().then((result) {
      setState(() {
        _activities = result;
      });
    });
  }

  @override
  void initState() {
    initActivities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      height: global.getHeight(context) * .95,
      width: global.getWidth(context) * .9,
      title: 'Activities',
      content: (_activities.isEmpty)
          ? const Text(
              'No activities yet',
              style: TextStyle(
                color: Colors.white,
              ),
            )
          : SizedBox(
              height: global.getHeight(context) * .9,
              child: ListView.builder(
                shrinkWrap: true,
                // reverse: true,
                itemCount: _activities.length,
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (BuildContext context, int index) {
                  return ActivityTileWidget(
                    activity: _activities[index],
                  );
                },
              ),
            ),
    );
  }
}
