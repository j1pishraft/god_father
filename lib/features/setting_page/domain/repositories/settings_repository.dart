import 'package:dartz/dartz.dart';
import 'package:god_father/core/error/failures.dart';
import 'package:god_father/enums/language_enum.dart';

abstract class SettingsRepository {
  Future<Language?> getAppLanguage();

  Future<Either<Failure, Language?>> changeAppLanguage(Language appLocale);
}
