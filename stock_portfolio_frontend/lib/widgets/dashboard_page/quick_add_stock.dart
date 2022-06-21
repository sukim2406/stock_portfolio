import 'package:flutter/material.dart';

import '../text_input.dart';
import '../rounded_btn.dart';

import '../../controllers/global_controllers.dart' as global;
import '../../controllers/api_controllers.dart';

class QuickAddStockWidget extends StatefulWidget {
  final VoidCallback newStockCallback;
  final List accounts;
  const QuickAddStockWidget({
    Key? key,
    required this.accounts,
    required this.newStockCallback,
  }) : super(key: key);

  @override
  State<QuickAddStockWidget> createState() => _QuickAddStockWidgetState();
}

class _QuickAddStockWidgetState extends State<QuickAddStockWidget> {
  late List<String> items;
  late String? selectedItem;
  TextEditingController tickerController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    items = [];
    for (Map account in widget.accounts) {
      items.add(account['title']);
    }
    selectedItem = items[0];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DropdownButton<String>(
            value: selectedItem,
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ))
                .toList(),
            onChanged: (item) => setState(() => selectedItem = item),
          ),
          (selectedItem == 'Alpaca')
              ? const Text(
                  '% CAUTION : using default account will place order as limit buy order through your connected alpaca account %',
                  style: TextStyle(color: Colors.redAccent),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextInputWidget(
                width: global.getWidth(context) * .1,
                label: 'Ticker',
                controller: tickerController,
                obsecure: false,
                enabled: true,
              ),
              TextInputWidget(
                width: global.getWidth(context) * .1,
                label: 'Qty',
                controller: qtyController,
                obsecure: false,
                enabled: true,
              ),
            ],
          ),
          TextInputWidget(
            width: global.getWidth(context) * .2,
            label: 'Price',
            controller: priceController,
            obsecure: false,
            enabled: true,
          ),
          RoundedBtnWidget(
            height: null,
            width: null,
            func: () {
              Map targetAccount = widget.accounts.firstWhere(
                (account) => account['title'] == selectedItem,
              );
              if (selectedItem == 'Alpaca') {
                ApiControllers.instance
                    .alpacaQuickBuyOrder(
                  selectedItem,
                  tickerController.text,
                  qtyController.text,
                  priceController.text,
                )
                    .then((result) {
                  if (result) {
                    setState(() {
                      selectedItem = items[0];
                    });
                    tickerController.clear();
                    priceController.clear();
                    qtyController.clear();
                    widget.newStockCallback();
                  } else {
                    global.printErrorBar(context, 'quick order error');
                  }
                });
              } else {
                if (double.parse(targetAccount['cash']) -
                        (double.parse(qtyController.text) *
                            double.parse(priceController.text)) <
                    0) {
                  global.printErrorBar(context, 'Insufficient cash balance');
                } else {
                  ApiControllers.instance
                      .addStock(
                    selectedItem,
                    tickerController.text,
                    qtyController.text,
                    priceController.text,
                  )
                      .then((result) {
                    if (result) {
                      ApiControllers.instance
                          .addActivity(
                        selectedItem,
                        'BUY',
                        tickerController.text,
                        priceController.text,
                        qtyController.text,
                        DateTime.now(),
                      )
                          .then((result) {
                        if (result) {
                          tickerController.clear();
                          qtyController.clear();
                          priceController.clear();
                          widget.newStockCallback();
                        } else {
                          global.printErrorBar(context, 'Activity not updated');
                        }
                      });
                    } else {
                      global.printErrorBar(context, 'Update unsuccessful');
                    }
                  });
                }
              }
            },
            label: 'ADD',
            color: Colors.greenAccent,
          )
        ],
      ),
    );
  }
}
