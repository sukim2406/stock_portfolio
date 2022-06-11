import 'package:flutter/material.dart';

import '../controllers/global_controllers.dart' as global;

class DetailedAccountTileWidget extends StatefulWidget {
  const DetailedAccountTileWidget({Key? key}) : super(key: key);

  @override
  State<DetailedAccountTileWidget> createState() =>
      _DetailedAccountTileWidgetState();
}

class _DetailedAccountTileWidgetState extends State<DetailedAccountTileWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      width: global.getDetailedWidth(context),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState() {
                _expanded = !_expanded;
              }
            },
            child: Container(
              width: global.getDetailedWidth(context),
              height: global.getHeight(context) * .05,
              color: Colors.grey,
              child: Text('Title here'),
            ),
          ),
        ],
      ),
    );
  }
}
