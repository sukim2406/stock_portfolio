import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_size/window_size.dart';

import './controllers/url_controllers.dart';
import './controllers/shared_preferences_controllers.dart';
import './controllers/api_controllers.dart';

import './pages/home.dart';

void main() {
  Get.put(
    UrlControllers(),
  );
  Get.put(
    SFControllers(),
  );
  Get.put(
    ApiControllers(),
  );
  if (Platform.isMacOS) {
    setWindowTitle('Stock Portfolio');
    setWindowMinSize(const Size(800, 600));
    setWindowMaxSize(Size.infinite);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
