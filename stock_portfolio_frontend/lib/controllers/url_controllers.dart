import 'package:get/get.dart';

class UrlControllers extends GetxController {
  static UrlControllers instance = Get.find();

  String baseUrl = 'http://localhost:8000';

  getRegisterUrl() {
    String registerUrl = '$baseUrl/api/account/register/';
    return registerUrl;
  }

  getLogoutUrl() {
    String logoutUrl = '$baseUrl/api/account/logout/';
    return logoutUrl;
  }

  getLoginUrl() {
    String loginUrl = '$baseUrl/api/account/login/';
    return loginUrl;
  }

  getAccountDetailUrl() {
    String accountDetailUrl = '$baseUrl/api/account/detail/';
    return accountDetailUrl;
  }

  getAccountUpdateUrl() {
    String accountUpdateUrl = '$baseUrl/api/account/update/';
    return accountUpdateUrl;
  }

  getAccountDeleteUrl() {
    String accountDeleteUrl = '$baseUrl/api/account/delete/';
    return accountDeleteUrl;
  }

  getAlpacaAccountUrl() {
    String alpacaUrl = '$baseUrl/api/account/alpaca/';
    return alpacaUrl;
  }

  getAlpacaPositionUrl() {
    String alpacaPositionUrl = '$baseUrl/api/account/alpaca-positions/';
    return alpacaPositionUrl;
  }

  getAccountCreateUrl() {
    String portfolioCreateUrl = '$baseUrl/api/portfolio/create/';
    return portfolioCreateUrl;
  }

  getAccountListUrl(username) {
    String portfolioListUrl = '$baseUrl/api/portfolio/$username/list/';
    return portfolioListUrl;
  }

  getAddTickerUrl() {
    String addTickerUrl = '$baseUrl/api/ticker/add/';
    return addTickerUrl;
  }

  getListTickerUrl(accountSlug) {
    String listTickerUrl = '$baseUrl/api/ticker/$accountSlug/list/';
    return listTickerUrl;
  }
}
