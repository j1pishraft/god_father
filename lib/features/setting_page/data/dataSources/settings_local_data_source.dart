import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exceptions.dart';

abstract class SettingsLocalDataSource {
  Future<String?> getString(String key);

  Future<bool> cacheSelectedAppLanguage(String languageToCache);
// Future<bool> cachePlayers(String playersToCache);
// FutureOr<bool> clearCatch(String key);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;

  SettingsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<String?> getString(String key) async {
    return sharedPreferences.getString(key);
  }

  @override
  Future<bool> cacheSelectedAppLanguage(String languageToCache) {
    try {
      return sharedPreferences.setString(appLanguageLocale, languageToCache);
    } catch (_) {
      throw CacheException();
    }
  }

}
