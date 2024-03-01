import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:god_father/core/app_envs.dart';
import 'package:god_father/enums/language_enum.dart';
import 'package:god_father/features/setting_page/presentation/bloc/setting_bloc.dart';
import 'package:god_father/routes/router.dart';
import 'core/config_reader/config_reader.dart';

import 'features/player_list_page/presentation/pages/player_list_page.dart';
import 'features/side_drawer/presentation/pages/side_drawer.dart';
import 'flavor_config.dart';
import 'injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'injection_container.dart';

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
    return BlocProvider(
      create: (_) {
        final bloc = sl<SettingsBloc>();
        bloc.add(const GetAppLanguage());
        return bloc;
      },
      child: BlocSelector<SettingsBloc, SettingState, Locale>(
        selector: (state) => state.selectedLanguage.locale,
        builder: (context, locale) {
          return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale,
            // routerConfig: appRouter.config(),
            title: 'God Father',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                // backgroundColor: ConfigReader.getAppBarColor == "green" ? Colors.green : Colors.red,
                backgroundColor: FlavorConfig.instance.appbarColor == Colors.green ? Colors.green : Colors.red,
                systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.blueAccent),
              ),
            ),
            // home: const PlayerListPage(),
            home: const SideDrawer(),
          );
        },
      ),
    );
  }
}
