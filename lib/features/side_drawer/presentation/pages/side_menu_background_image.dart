import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:god_father/enums/language_enum.dart';

import '../../../setting_page/presentation/bloc/setting_bloc.dart';

class SideMenuBackgroundImage extends StatelessWidget {
  const SideMenuBackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsBloc, SettingState, Locale?>(
        selector: (state) => state.selectedLanguage?.locale,
        builder: (context, cLocale) {
          final locale = cLocale;
          return locale?.languageCode == 'en' ? Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            child: Center(
              child: Image.asset(
                "assets/images/l_godfather.png",
              ),
            ),
          )
              : Positioned(
            left: 0,
            bottom: 0,
            top: 0,
            child: Center(
              child: Image.asset(
                "assets/images/flip_r_godfather.png",
              ),
            ),
          );
        });
  }
}
