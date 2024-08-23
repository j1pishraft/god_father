import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exceptions.dart';

abstract class PlayerRoleLocalDataSource {
  Future<String?> getString(String key);
  // Future<bool> cachePlayers(String playersToCache);
  // FutureOr<bool> clearCatch(String key);
}

class PlayerRoleLocalDataSourceImpl implements PlayerRoleLocalDataSource{
  final SharedPreferences sharedPreferences;

  PlayerRoleLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<String?> getString(String key) async {

      return sharedPreferences.getString(key);

  }
}

