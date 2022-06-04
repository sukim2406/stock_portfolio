import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class SFControllers extends GetxController {
  static SFControllers instance = Get.find();

  Future getSharedPreferences() async {
    var sf = await SharedPreferences.getInstance();

    return sf;
  }

  Future getToken() async {
    var sf = await SharedPreferences.getInstance();
    var token = sf.getString('token') ?? '';

    return token;
  }

  Future setToken(token) async {
    var sf = await SharedPreferences.getInstance();
    sf.setString('token', token);
  }

  Future clearToken() async {
    var sf = await SharedPreferences.getInstance();
    sf.remove('token');
  }
}