import 'package:flutter/material.dart';

import '../text_input.dart';
import '../rounded_btn.dart';

import '../../controllers/global_controllers.dart' as global;
import '../../controllers/api_controllers.dart';
import '../../controllers/shared_preferences_controllers.dart';

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
              if (selectedItem == 'Alpaca') {
                SFControllers.instance.getCurUser().then(
                  (result) {
                    var account = result + '-' + selectedItem;
                    account = account.toLowerCase();
                    ApiControllers.instance
                        .quickOrder(
                      result,
                      account,
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
                  },
                );
              } else {
                SFControllers.instance.getCurUser().then(
                  (result) {
                    var account = result + '-' + selectedItem;
                    account = account.toLowerCase();

                    ApiControllers.instance
                        .addTicker(
                      result,
                      account,
                      tickerController.text,
                      qtyController.text,
                      priceController.text,
                    )
                        .then((statusCode) {
                      if (statusCode == 201) {
                        ApiControllers.instance
                            .updateCash(account, priceController.text,
                                qtyController.text)
                            .then((result) {
                          setState(() {
                            selectedItem = items[0];
                          });
                          tickerController.clear();
                          priceController.clear();
                          qtyController.clear();
                          widget.newStockCallback();
                        });
                      } else if (statusCode == 500) {
                        ApiControllers.instance
                            .updateTicker(
                          result,
                          account,
                          tickerController.text,
                          qtyController.text,
                          priceController.text,
                        )
                            .then((result) {
                          if (result) {
                            ApiControllers.instance
                                .updateCash(account, priceController.text,
                                    qtyController.text)
                                .then((result) {
                              if (result) {
                                setState(() {
                                  selectedItem = items[0];
                                });
                                tickerController.clear();
                                priceController.clear();
                                qtyController.clear();
                                widget.newStockCallback();
                              }
                            });
                          } else {
                            global.printErrorBar(
                                context, 'update ticker error');
                          }
                        });
                      } else {
                        global.printErrorBar(context, result.toString());
                      }
                    });
                  },
                );
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
