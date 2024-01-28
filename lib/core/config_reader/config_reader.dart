import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:god_father/core/environments.dart';

abstract class ConfigReader {
  static Map<String, dynamic>? _config;

  static Future<void> initialize(String env) async {
    final String configString;
    if (env == Environment.dev) {
      configString = await rootBundle.loadString('config/app_config_dev.json');
    } else {
      configString = await rootBundle.loadString('config/app_config_prod.json');
    }
    _config = json.decode(configString) as Map<String, dynamic>;
  }

  static String getAppBarColor() {
    return _config!['appBarColor'];
  }

  static String getSecretKey() {
    return _config!['secretKey'] as String;
  }
}
