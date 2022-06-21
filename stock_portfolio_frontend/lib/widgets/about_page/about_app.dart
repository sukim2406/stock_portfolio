import 'package:flutter/material.dart';

import '../../controllers/global_controllers.dart' as global;

import '../../widgets/card.dart';

class AboutAppWidget extends StatelessWidget {
  const AboutAppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      height: global.getHeight(context) * .6,
      width: global.getWidth(context) * .9,
      content: Column(
        children: [
          Text(
            'Diamond Hands : stock portfolio',
            style: TextStyle(
              color: global.accentColor,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: global.getHeight(context) * .05,
          ),
          Column(
            children: [
              RichText(
                text: TextSpan(
                  text:
                      'this stock portfolio app is personal project developed with ',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: 'Flutter',
                      style: TextStyle(
                        color: global.accentColor,
                      ),
                    ),
                    const TextSpan(
                      text: ' & ',
                    ),
                    TextSpan(
                      text: 'Django',
                      style: TextStyle(
                        color: global.accentColor,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'because the stock data is being fetched from ',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: 'Alpaca Market API',
                      style: TextStyle(
                        color: global.accentColor,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'you need to register and generate API keys from ',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: 'Alpaca Market',
                      style: TextStyle(
                        color: global.accentColor,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: const TextSpan(
                  text:
                      'and provide generated keys during registration (works both for paper or live account)',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: global.getHeight(context) * .05,
          ),
          const Text(
            'Known Issues',
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Text(
            'currently reducing number of shares by selling will not update average price of stock',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          const Text(
            'because the app does not keep track of individual stocks by buying price and quantities',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          const Text(
            'however correct implementation will recalculate average price as you sell certain stock',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          const Text(
            'ex) if you buy one share of X at \$10 and another share of same stock at \$20,',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          const Text(
            'your current average should be \$15, and when you sell one share of X,',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          const Text(
            'depending on your account\'s setting it should either be \$10 or \$20 not staying at \$15',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          const Text(
            'What should be good solution to implement this correctly?',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
      title: 'About Application',
    );
  }
}
