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
    String addTickerUrl = '$baseUrl/api/ticker/create/';
    return addTickerUrl;
  }

  getListTickerUrl(accountSlug) {
    String listTickerUrl = '$baseUrl/api/ticker/$accountSlug/list/';
    return listTickerUrl;
  }

  getUpdateCashUrl(accountSlug) {
    String updateCashUrl = '$baseUrl/api/portfolio/$accountSlug/update/';
    return updateCashUrl;
  }

  getAlpacaQuickBuyUrl() {
    String quickOrderUrl = '$baseUrl/api/ticker/alpaca-quickbuy/';
    return quickOrderUrl;
  }

  getAlpacaQuickSellUrl() {
    String quickOrderUrl = '$baseUrl/api/ticker/alpaca-quicksell/';
    return quickOrderUrl;
  }

  getUpdateTickerUrl(tickerSlug) {
    String updateTickerUrl = '$baseUrl/api/ticker/$tickerSlug/update/';
    return updateTickerUrl;
  }

  getDeleteTickerUrl(tickerSlug) {
    String deleteTickerUrl = '$baseUrl/api/ticker/$tickerSlug/delete/';
    return deleteTickerUrl;
  }

  getDeleteAccountUrl(accountSlug) {
    String deleteAccountUrl = '$baseUrl/api/portfolio/$accountSlug/delete/';
    return deleteAccountUrl;
  }

  getCreateActivityUrl() {
    String createActivityUrl = '$baseUrl/api/activity/create/';
    return createActivityUrl;
  }

  getActivityListUrl(username) {
    String activityListUrl = '$baseUrl/api/activity/$username/list/';
    return activityListUrl;
  }
}
