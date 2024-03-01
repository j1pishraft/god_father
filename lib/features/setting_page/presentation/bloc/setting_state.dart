part of 'setting_bloc.dart';


class SettingState extends Equatable {
  final Language selectedLanguage;
  const SettingState({
    Language? selectedLanguage,
  }) : selectedLanguage = selectedLanguage ?? Language.english;



  SettingState copyWith({Language? selectedLanguage}) {
    return SettingState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [selectedLanguage];

}

