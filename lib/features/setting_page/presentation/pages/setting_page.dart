import 'package:flutter/material.dart';
import 'package:god_father/features/setting_page/presentation/widgets/choose_language_bottom_sheet.dart';
import 'package:inner_drawer/inner_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../side_drawer/presentation/pages/side_drawer.dart';


class SettingsPage extends StatelessWidget {

  const SettingsPage({super.key});


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(l10n.chooseLanguage),
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