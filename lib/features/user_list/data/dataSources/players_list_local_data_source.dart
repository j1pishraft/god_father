import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exceptions.dart';

abstract class PlayersListLocalDataSource {
  Future<String?> getString(String key);
  Future<bool> cachePlayers(String playersToCache);
  FutureOr<bool> clearCatch(String key);
}

class PlayersListLocalDataSourceImpl implements PlayersListLocalDataSource {
  final SharedPreferences sharedPreferences;

  PlayersListLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<String?> getString(String key) async {

      return sharedPreferences.getString(key);

  }

  @override
  Future<bool> cachePlayers(String playersToCache) {
    try {
      return sharedPreferences.setString(cachedPlayersList, playersToCache);
    } catch (_) {
      throw CacheException();
    }

  }

  @override
  FutureOr<bool> clearCatch(String key) {
    try {
      return sharedPreferences.remove(key);
    } catch (_) {
      throw CacheException();
    }
  }
}

