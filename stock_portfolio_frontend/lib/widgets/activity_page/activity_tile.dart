import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;

class ActivityTileWidget extends StatelessWidget {
  final Map activity;
  const ActivityTileWidget({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(activity.toString());
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      height: global.getHeight(context) * .05,
      width: global.getWidth(context) * .9,
      child: Container(
        color: Colors.grey[900],
        child: Row(
          children: [
            SizedBox(
              width: global.getWidth(context) * .2,
              child: Text(
                activity['date'].substring(0, 10) +
                    ' ' +
                    activity['date'].substring(11, 19),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: global.getWidth(context) * .2,
              child: Text(
                activity['activity'],
                style: TextStyle(
                  color: ((activity['activity'] == 'BUY') ||
                          (activity['activity'] == 'WITHDRAW'))
                      ? Colors.redAccent
                      : ((activity['activity'] == 'SELL') ||
                              activity['activity'] == 'DEPOSIT')
                          ? global.accentColor
                          : Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: global.getWidth(context) * .2,
              child: Text(
                activity['title'],
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            (activity['activity'] == 'BUY' || activity['activity'] == 'SELL')
                ? SizedBox(
                    width: global.getWidth(context) * .1,
                    child: Text(
                      activity['content'],
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                : Container(),
            (activity['activity'] == 'BUY' || activity['activity'] == 'SELL')
                ? SizedBox(
                    width: global.getWidth(context) * .05,
                    child: Text(
                      activity['qty'].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                : Container(),
            (activity['activity'] != 'ACCOUNT CREATED')
                ? SizedBox(
                    width: global.getWidth(context) * .1,
                    child: Text(
                      activity['price'],
                      style: TextStyle(
                        color: ((activity['activity'] == 'BUY') ||
                                (activity['activity'] == 'WITHDRAW'))
                            ? Colors.redAccent
                            : global.accentColor,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
