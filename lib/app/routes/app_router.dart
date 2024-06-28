import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:gorouter_auth/app/routes/route_utils.dart';
// import 'package:gorouter_auth/app/routes/screens/not_found_page.dart';
// import 'package:gorouter_auth/features/auth/presentation/screens/home_screen.dart';
// import '../../features/auth/presentation/controller/auth_bloc.dart';
// import '../../features/auth/presentation/screens/login_screen.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:god_father/app/routes/route_utils.dart';
import 'package:god_father/features/side_drawer/presentation/pages/side_drawer_page.dart';

import '../../features/role_list_page/presentation/pages/role_list_page.dart';

// import '../di/injector.dart';

class AppRouter {

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: PAGES.sideDrawer.screenPath,
        name: PAGES.sideDrawer.screenName,
        builder: (context, state) => const SideDrawerPage(),

      ),
      GoRoute(
        path: PAGES.selectRoles.screenPath,
        name: PAGES.selectRoles.screenName,
        builder: (context, state) => const RoleListPage(),

      ),

    ],
    // errorBuilder: (context, state) => const NotFoundScreen(),
  );

  static GoRouter get router => _router;

}