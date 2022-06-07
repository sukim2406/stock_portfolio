import 'package:flutter/material.dart';

import '../widgets/text_input.dart';
import '../widgets/rounded_btn.dart';

import '../controllers/global_controllers.dart' as global;

class QuickAddStockWidget extends StatefulWidget {
  final List accounts;
  const QuickAddStockWidget({
    Key? key,
    required this.accounts,
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
                        style: TextStyle(color: Colors.blue),
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
              print(tickerController.text);
              print(qtyController.text);
              print(priceController.text);
              if (selectedItem == 'Alpaca') {
                print(' do alpaca order');
              } else {
                print(' do django addition');
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
