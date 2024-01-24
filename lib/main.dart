import 'package:flutter/services.dart';
import 'package:god_father/features/user_list/presentation/pages/player_list_page.dart';
import 'package:god_father/routes/router.dart';
import 'injection_container.dart' as di;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      title: 'Gof Father',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blueAccent),
        ),
      ),
      home: const PlayerListPage(),
    );
  }
}
