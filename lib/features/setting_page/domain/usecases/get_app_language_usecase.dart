import 'package:god_father/enums/language_enum.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/settings_repository.dart';


class GetAppLanguageUsecase implements UseCaseNoEither<Language, NoParams> {
  final SettingsRepository repository;

  GetAppLanguageUsecase(this.repository);

  @override
  Future<Language?> call(NoParams params) async {
    return await repository.getAppLanguage();
  }


}
