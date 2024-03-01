import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:god_father/enums/language_enum.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/settings_repository.dart';

class ChangeAppLanguageUsecase implements UseCase<Language, ChangeAppLanguageUsecaseParams> {
  final SettingsRepository repository;

  ChangeAppLanguageUsecase(this.repository);

  @override
  Future<Either<Failure, Language?>> call(ChangeAppLanguageUsecaseParams params) async {
    return await repository.changeAppLanguage(params.appLanguage);
  }
}

class ChangeAppLanguageUsecaseParams extends Equatable {
  final Language appLanguage;

  const ChangeAppLanguageUsecaseParams({required this.appLanguage});

  @override
  List<Object?> get props => [appLanguage];
}
