import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:god_father/core/appThemes/gf_app_themes.dart';
import 'package:god_father/core/app_envs.dart';
import 'package:god_father/enums/language_enum.dart';
import 'package:god_father/features/setting_page/presentation/bloc/setting_bloc.dart';
import 'package:god_father/routes/router.dart';
import 'core/appThemes/app_themes.dart';
import 'core/config_reader/config_reader.dart';

import 'features/player_list_page/presentation/pages/player_list_page.dart';
import 'features/side_drawer/presentation/pages/side_drawer.dart';
import 'flavor_config.dart';
import 'injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart' as provider;
import 'injection_container.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> mainCommon(String env) async {

  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initialize(env);
  FlavorConfig(env: env, settings: baseMapSettings[env]!);

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    // AppRouter appRouter = AppRouter();
    return provider.ChangeNotifierProvider<GFThemeNotifier>(
      create: (context) => GFThemeNotifier(),
      child: BlocProvider(
        create: (_) {
          final bloc = sl<SettingsBloc>();
          bloc.add(const GetAppLanguage());
          return bloc;
        },
        child: BlocSelector<SettingsBloc, SettingState, (Locale?, ThemeMode?)>(
            selector: (state) => (state.selectedLanguage?.locale, state.themeMode),
            builder: (context, item) {

              final locale = item.$1;
              final themeMode = item.$2;
              ThemeManager.toggleTheme(themeMode!);
              return MaterialApp(
                key: navigatorKey,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: locale,
                // routerConfig: appRouter.config(),
                title: 'God Father',
                debugShowCheckedModeBanner: false,
                theme: AppThemes.appThemeData[themeMode],
                // home: const PlayerListPage(),
                home: const SideDrawer(),
              );
            },
          )
      ),
    );
  }
}
