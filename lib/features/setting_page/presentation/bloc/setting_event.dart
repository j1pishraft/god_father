part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class ChangeLanguagePressed extends SettingEvent {
  const ChangeLanguagePressed({required this.selectedLanguage});
  final Language selectedLanguage;

  @override
  List<Object> get props => [selectedLanguage];
}

class GetAppLanguage extends SettingEvent {
  const GetAppLanguage();

  @override
  List<Object> get props => [];
}

class ThemeChangePressed extends SettingEvent {
  const ThemeChangePressed({required this.isDark});
  final bool isDark;

  @override
  List<Object> get props => [isDark];
}
