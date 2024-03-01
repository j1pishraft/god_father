import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:god_father/core/constants/constants.dart';
import 'package:god_father/core/error/exceptions.dart';
import 'package:god_father/core/error/failures.dart';
import '../../../../enums/language_enum.dart';
import '../../domain/repositories/settings_repository.dart';
import '../dataSources/settings_local_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource settingsLocalDataSource;

  SettingsRepositoryImpl({
    required this.settingsLocalDataSource,
  });

  @override
  Future<Language?> getAppLanguage() async {
    final localeString = await settingsLocalDataSource.getString(appLanguageLocale);
    Language? appLanguage;
    if (localeString != null) {
      // var jsonResponse = json.decode(localeString);


      appLanguage = languageFromJson(localeString);
      // appLanguage = Language.values[jsonResponse['value']];

    }
    return appLanguage;
  }

  @override
  Future<Either<Failure, Language?>> changeAppLanguage(Language appLanguage) async {
    try {
      // final jsonString = json.encode(appLanguage.toJson());
      final jsonString = json.encode(languageToJson(appLanguage));
      settingsLocalDataSource.cacheSelectedAppLanguage(jsonString);
      final result = await getAppLanguage();
      return Right(result);
    } on CacheException {
      return const Left(CacheFailure(message: 'Something went wrong'));
    }
  }
}
