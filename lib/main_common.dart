import 'package:flutter/services.dart';
import 'package:god_father/core/environments.dart';
import 'package:god_father/features/user_list/presentation/pages/player_list_page.dart';
import 'package:god_father/routes/router.dart';
import 'core/config_reader/config_reader.dart';
import 'injection_container.dart' as di;
import 'package:flutter/material.dart';

Future<void> mainCommon(String env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initialize(env);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // AppRouter appRouter = AppRouter();
    return MaterialApp(
      // routerConfig: appRouter.config(),
      title: 'God Father',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme:  AppBarTheme(
          backgroundColor: ConfigReader.getAppBarColor() == "green" ? Colors.green : Colors.red,
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.blueAccent),
        ),
      ),
      home: const PlayerListPage(),
    );
  }
}
