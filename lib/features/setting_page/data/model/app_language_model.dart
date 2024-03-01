import '../../domain/entities/app_language_entity.dart';

class LocaleModel extends Locale {
  final String languageCode;

  const LocaleModel({
    required this.languageCode,
  }) : super(languageCode);

  Map<String, dynamic> toJson() {
    return {
      'languageCode': languageCode,
    };
  }
}
