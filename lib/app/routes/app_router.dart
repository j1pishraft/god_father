import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// import 'package:gorouter_auth/app/routes/route_utils.dart';
// import 'package:gorouter_auth/app/routes/screens/not_found_page.dart';
// import 'package:gorouter_auth/features/auth/presentation/screens/home_screen.dart';
// import '../../features/auth/presentation/controller/auth_bloc.dart';
// import '../../features/auth/presentation/screens/login_screen.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:god_father/app/routes/route_utils.dart';
import 'package:god_father/features/role_list_page/presentation/pages/assign_role_page.dart';
import 'package:god_father/features/side_drawer/presentation/pages/side_drawer_page.dart';

import '../../features/player_list_page/domain/entities/player_entity.dart';
import '../../features/role_list_page/presentation/bloc/role_list_bloc.dart';
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
          builder: (context, state) {
            final item = state.extra as List<Player>;
            return RoleListPage(players: item);
          }

      ),
      GoRoute(
          path: PAGES.assignRolesPage.screenPath,
          name: PAGES.assignRolesPage.screenName,
          builder: (context, state) {
            final item = state.extra as RoleListBloc;
            return  AssignRolesPage(roleListBloc: item,);
          }),
    ],
    // errorBuilder: (context, state) => const NotFoundScreen(),
  );

  static GoRouter get router => _router;

}