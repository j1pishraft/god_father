import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../enums/language_enum.dart';
import '../../domain/usecases/change_app_language_usecase.dart';
import '../../domain/usecases/get_app_language_usecase.dart';

part 'setting_event.dart';
part 'setting_state.dart';


class SettingsBloc extends Bloc<SettingEvent, SettingState> {
  final GetAppLanguageUsecase getAppLanguageUseCase;
  final ChangeAppLanguageUsecase changeAppLanguageUseCase;

  SettingsBloc({required this.changeAppLanguageUseCase, required this.getAppLanguageUseCase}) : super(const SettingState()) {
    on<GetAppLanguage>(_onGetAppLanguage);
    on<ChangeLanguagePressed>(_onChangeLanguage);
    on<ThemeChangePressed>(_onThemeChangePressed);
  }

  FutureOr<void> _onGetAppLanguage(GetAppLanguage event, Emitter<SettingState> emit) async{



    final appLanguage = await getAppLanguageUseCase(NoParams());
    if(appLanguage == null){
      emit(state.copyWith(selectedLanguage: Language.values[0]));
    }else {
      emit(state.copyWith(selectedLanguage: appLanguage.locale == const Locale('fa') ? Language.values[1] : Language.values[0]));
    }
  }

  _onChangeLanguage(ChangeLanguagePressed event, Emitter<SettingState> emit) async {
    debugPrint('${state.selectedLanguage}');
    final appLocale = await changeAppLanguageUseCase(ChangeAppLanguageUsecaseParams(appLanguage: event.selectedLanguage));

    appLocale.fold(
          (failure) => emit(const SettingState()),
          (locale) {
            emit(state.copyWith(selectedLanguage: event.selectedLanguage));

      },
    );

  }



  FutureOr<void> _onThemeChangePressed(ThemeChangePressed event, Emitter<SettingState> emit) {

    emit(state.copyWith( themeMode: event.isDark ? ThemeMode.dark : ThemeMode.light));
  }
}