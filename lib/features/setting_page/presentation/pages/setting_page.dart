import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:god_father/core/appThemes/custom_style.dart';
import 'package:god_father/core/constants/color_const.dart';
import 'package:god_father/features/setting_page/presentation/bloc/setting_bloc.dart';
import 'package:god_father/features/setting_page/presentation/widgets/choose_language_bottom_sheet.dart';
import 'package:inner_drawer/inner_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/appThemes/app_themes.dart';
import '../../../../core/appThemes/gf_app_themes.dart';
import '../../../side_drawer/presentation/pages/side_drawer.dart';
import 'package:provider/provider.dart' as provider;
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fontSize = Theme.of(context).textTheme;


    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            innerDrawerKey.currentState?.toggle(direction: InnerDrawerDirection.start);
          },
          icon: const Icon(Icons.menu),
        ),
        centerTitle: true,
        // title: Assets.brand.image(height: 32.0),
        title: Text(l10n.settings),
      ),
      body: SafeArea(
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
                  return Switch(
                    trackOutlineColor: MaterialStateProperty.all(customColor.trackOutlineColor),
                    activeColor: customColor.switchActiveColor,
                    activeTrackColor: customColor.switchActiveTrackColor,
                    inactiveTrackColor: customColor.switchInactiveTrackColor,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(ThemeChangePressed(isDark: value));
                      GFThemeNotifier.of(context,listen: false).changeThemes();
                    },
                    value: isDarkTheme,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                // child: Text(l10n.chooseLanguage, style: TextStyle(fontSize: fontSize.bodyLarge?.fontSize, color: BPThemeNotifier.of(context).theme.colorScheme.testColor)),
                child: Text(l10n.chooseLanguage, style: TextStyle(fontSize: fontSize.bodyLarge?.fontSize, color: context.read<SettingsBloc>().state.themeMode == ThemeMode.dark ? Colors.red : Colors.green,)),
              ),
              const ChooseLanguageBottomSheet(),
              // Expanded(child: Assets.onboarding.svg()),
            ],
          ),
        ),
      ),
    );
  }
}
