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

  register(email, username, password, password2, apiKey, secretKey) async {
    Map data = {
      'email': email,
      'username': username,
      'password': password,
      'password2': password2,
      'alpaca_api_key': apiKey,
      'alpaca_secret_key': secretKey,
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
      return true;
    }
    return false;
  }
}
