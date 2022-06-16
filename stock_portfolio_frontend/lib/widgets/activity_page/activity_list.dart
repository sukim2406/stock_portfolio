import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;
import '../../controllers/api_controllers.dart';

import '../../widgets/card.dart';

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
                reverse: true,
                padding: const EdgeInsets.all(5),
                itemCount: _activities.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        _activities[index]['date'],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _activities[index]['title'],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _activities[index]['activity'],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      (_activities[index]['activity'] != 'ACCOUNT CREATED')
                          ? Text(
                              _activities[index]['content'].toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : Container(),
                      Text(
                        _activities[index]['price'],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      (_activities[index]['activity'] != 'ACCOUNT CREATED')
                          ? Text(
                              _activities[index]['qty'].toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : Container(),
                    ],
                  );
                },
              ),
            ),
    );
  }
}
