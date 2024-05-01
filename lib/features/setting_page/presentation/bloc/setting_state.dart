part of 'setting_bloc.dart';


class SettingState extends Equatable {
  final Language? selectedLanguage;
  final ThemeMode? themeMode;

  const SettingState({this.themeMode = ThemeMode.light,
    this.selectedLanguage = Language.english,
  }) ;



  SettingState copyWith({Language? selectedLanguage, final ThemeMode? themeMode}) {
    return SettingState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [selectedLanguage, themeMode];

}

