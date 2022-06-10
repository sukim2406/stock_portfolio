import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controllers/url_controllers.dart';
import '../controllers/shared_preferences_controllers.dart';

class ApiControllers extends GetxController {
  static ApiControllers instance = Get.find();

  login(email, password) async {
    Map data = {
      'username': email,
      'password': password,
    };

    var response = await http.post(
      Uri.parse(
        UrlControllers.instance.getLoginUrl(),
      ),
      body: data,
    );

    var jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      SFControllers.instance.setToken(
        jsonResponse['token'],
      );
      SFControllers.instance.setCurUser(
        jsonResponse['user'],
      );
      return true;
    } else {
      return false;
    }
  }

  logout() async {
    String token = await SFControllers.instance.getToken();
    var response = await http.post(
      Uri.parse(
        UrlControllers.instance.getLogoutUrl(),
      ),
      headers: {
        HttpHeaders.authorizationHeader: 'Token $token',
      },
    );
    if (response.statusCode == 200) {
      SFControllers.instance.clearToken();
      return true;
    }
    return false;
  }

  register(
      email, username, password, password2, apiKey, secretKey, paper) async {
    Map data = {
      'email': email,
      'username': username,
      'password': password,
      'password2': password2,
      'alpaca_api_key': apiKey,
      'alpaca_secret_key': secretKey,
      'paper_account': paper,
    };

    var response = await http.post(
      Uri.parse(
        UrlControllers.instance.getRegisterUrl(),
      ),
      body: data,
    );
    var jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      SFControllers.instance.setToken(
        jsonResponse['token'],
      );
      SFControllers.instance.setCurUser(
        jsonResponse['user'],
      );
      return true;
    }
    return false;
  }

  getAlpacaAccount() async {
    String token = await SFControllers.instance.getToken();
    var response = await http.get(
      Uri.parse(
        UrlControllers.instance.getAlpacaAccountUrl(),
      ),
      headers: {
        HttpHeaders.authorizationHeader: 'Token $token',
      },
    );
    var jsonResponse = json.decode(response.body);

    return jsonResponse;
  }

  getAlpacaPositions() async {
    String token = await SFControllers.instance.getToken();
    var response = await http.get(
      Uri.parse(
        UrlControllers.instance.getAlpacaPositionUrl(),
      ),
      headers: {
        HttpHeaders.authorizationHeader: 'Token $token',
      },
    );

    var jsonResponse = json.decode(response.body);

    return jsonResponse;
  }

  createAccount(title, cash) async {
    String token = await SFControllers.instance.getToken();
    Map data = {
      'title': title,
      'cash': cash,
    };
    var response = await http.post(
      Uri.parse(
        UrlControllers.instance.getAccountCreateUrl(),
      ),
      headers: {
        HttpHeaders.authorizationHeader: 'Token $token',
      },
      body: data,
    );
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  getAccountLists() async {
    String token = await SFControllers.instance.getToken();
    String curUser = await SFControllers.instance.getCurUser();

    var response = await http.get(
      Uri.parse(
        UrlControllers.instance.getAccountListUrl(curUser),
      ),
      headers: {
        HttpHeaders.authorizationHeader: 'Token $token',
      },
    );

    var jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  addTicker(username, portfolio, ticker, qty, averagePrice) async {
    String token = await SFControllers.instance.getToken();
    Map data = {
      'username': username,
      'portfolioSlug': portfolio.toLowerCase(),
      'ticker': ticker,
      'qty': qty,
      'averagePrice': averagePrice,
    };
    var response = await http.post(
      Uri.parse(
        UrlControllers.instance.getAddTickerUrl(),
      ),
      headers: {
        HttpHeaders.authorizationHeader: 'Token $token',
      },
      body: data,
    );

    return response.statusCode;
    // if (response.statusCode == 201) {
    //   return true;
    // }
    // return false;
  }

  listTicker(account) async {
    String token = await SFControllers.instance.getToken();
    String curUser = await SFControllers.instance.getCurUser();

    var accountSlug = '$curUser-$account';
    accountSlug = accountSlug.toLowerCase();
    var response = await http.get(
      Uri.parse(
        UrlControllers.instance.getListTickerUrl(accountSlug),
      ),
      headers: {
        HttpHeaders.authorizationHeader: 'Token $token',
      },
    );

    var jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  updateCash(accountSlug, averagePrice, qty) async {
    String token = await SFControllers.instance.getToken();
    Map data = {
      'averagePrice': averagePrice,
      'qty': qty,
      'slug': accountSlug,
    };

    var response = await http.put(
      Uri.parse(
        UrlControllers.instance.getUpdateCashUrl(accountSlug),
      ),
      headers: {
        HttpHeaders.authorizationHeader: 'Token $token',
      },
      body: data,
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  quickOrder(username, portfolio, ticker, qty, averagePrice) async {
    String token = await SFControllers.instance.getToken();
    Map data = {
      'username': username,
      'portfolioSlug': portfolio.toLowerCase(),
      'ticker': ticker,
      'qty': qty,
      'averagePrice': averagePrice,
    };
    var response = await http.post(
      Uri.parse(
        UrlControllers.instance.getQuickOrderUrl(),
      ),
      headers: {
        HttpHeaders.authorizationHeader: 'Token $token',
      },
      body: data,
    );
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  updateTicker(username, portfolio, ticker, qty, averagePrice) async {
    String token = await SFControllers.instance.getToken();
    Map data = {
      'username': username,
      'portfolioSlug': portfolio.toLowerCase(),
      'ticker': ticker,
      'qty': qty,
      'averagePrice': averagePrice,
    };
    String tickerSlug = ticker + '-' + portfolio.toLowerCase();

    var response = await http.put(
      Uri.parse(
        UrlControllers.instance.getUpdateTickerUrl(tickerSlug),
      ),
      headers: {
        HttpHeaders.authorizationHeader: 'Token $token',
      },
      body: data,
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
