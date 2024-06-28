import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:god_father/core/appThemes/custom_style.dart';
import 'package:god_father/core/constants/color_const.dart';
import 'package:god_father/enums/language_enum.dart';
import 'package:god_father/features/setting_page/presentation/bloc/setting_bloc.dart';
import 'package:god_father/features/setting_page/presentation/widgets/choose_language_bottom_sheet.dart';
import 'package:inner_drawer/inner_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/appThemes/app_themes.dart';
import '../../../../core/appThemes/gf_app_themes.dart';
import '../../../side_drawer/presentation/pages/side_drawer_page.dart';
import 'package:provider/provider.dart' as provider;

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fontSize = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      // backgroundColor: Theme.of(context).colorScheme.surface,
      backgroundColor: CustomColor.backGroundColor,
      appBar: AppBar(
        backgroundColor: CustomColor.appbarColor,
        leading: IconButton(
          onPressed: () {
            innerDrawerKey.currentState
                ?.toggle(direction: InnerDrawerDirection.start);
          },
          icon: const Icon(Icons.menu, color: Colors.yellow,),
        ),
        centerTitle: true,
        // title: Assets.brand.image(height: 32.0),
        title: Text(
          l10n.settings,
          style: CustomStyles.heading1,
        ),
      ),
      body: Stack(
        children: [
          BlocSelector<SettingsBloc, SettingState, Locale?>(
              selector: (state) => state.selectedLanguage?.locale,
              builder: (context, cLocale) {
                final locale = cLocale;
                return locale?.languageCode == 'en'
                    ? Positioned(
                        left: 0,
                        bottom: 0,
                        top: 0,
                        child: Center(
                          child: Image.asset(
                            "assets/images/r_godfather.png",
                          ),
                        ),
                      )
                    : Positioned(
                        right: 0,
                        bottom: 0,
                        top: 0,
                        child: Center(
                          child: Image.asset(
                            "assets/images/flip_l_godfather.png",
                          ),
                        ),
                      );
              }),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocSelector<SettingsBloc, SettingState, bool>(
                    selector: (state) => state.themeMode == ThemeMode.dark,
                    builder: (context, isDarkTheme) {
                      return Container(
                        // color: CustomColor.appbarColor,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                            color: Colors.transparent.withOpacity(0.3),
                            border: Border.all(color: Colors.white,)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                isDarkTheme ? l10n.darkMode : l10n.lightMode,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              Switch(
                                trackOutlineColor: WidgetStateProperty.all(
                                    customColor.trackOutlineColor),
                                activeColor: Colors.yellow.shade500,
                                activeTrackColor:
                                    customColor.switchActiveTrackColor,
                                inactiveTrackColor:
                                    customColor.switchInactiveTrackColor,
                                onChanged: (value) {
                                  context
                                      .read<SettingsBloc>()
                                      .add(ThemeChangePressed(isDark: value));
                                  GFThemeNotifier.of(context, listen: false)
                                      .changeThemes();
                                },
                                value: isDarkTheme,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.transparent.withOpacity(0.3),
                       ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(l10n.chooseLanguage,
                          style:  const TextStyle(
                            fontSize: 18,
                            color: Colors.yellow
                          )),
                    ),
                  ),
                  const ChooseLanguageBottomSheet(),
                  // Expanded(child: Assets.onboarding.svg()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
