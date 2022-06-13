import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;

import '../card.dart';
import 'quick_add_account.dart';
import 'quick_add_stock.dart';

class QuickAddWidget extends StatefulWidget {
  final List accounts;
  final VoidCallback newAccountCallback;
  const QuickAddWidget({
    Key? key,
    required this.newAccountCallback,
    required this.accounts,
  }) : super(key: key);

  @override
  State<QuickAddWidget> createState() => _QuickAddWidgetState();
}

class _QuickAddWidgetState extends State<QuickAddWidget>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late TextEditingController titleController = TextEditingController();
  late TextEditingController cashController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);

    cashController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      height: global.getHeight(context) * .55,
      width: global.getWidth(context) * .44,
      title: 'Quick Add',
      content: Column(
        children: [
          TabBar(
            controller: tabController,
            indicatorColor: Colors.greenAccent,
            tabs: [
              SizedBox(
                height: global.getHeight(context) * .05,
                child: const Center(
                  child: Text(
                    'Create New Account',
                  ),
                ),
              ),
              SizedBox(
                height: global.getHeight(context) * .05,
                child: const Center(
                  child: Text(
                    'Add Stock',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: global.getHeight(context) * .43,
            child: TabBarView(
              controller: tabController,
              children: [
                QuickAddAccountWidget(
                  titleController: titleController,
                  cashController: cashController,
                  newAccountCallback: widget.newAccountCallback,
                ),
                QuickAddStockWidget(
                  accounts: widget.accounts,
                  newStockCallback: widget.newAccountCallback,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
