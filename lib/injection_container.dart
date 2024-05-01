import 'package:get_it/get_it.dart';
import 'package:god_father/features/setting_page/data/dataSources/settings_local_data_source.dart';
import 'package:god_father/features/setting_page/data/repositories/settings_repository_impl.dart';
import 'package:god_father/features/setting_page/presentation/bloc/setting_bloc.dart';
import 'package:god_father/features/side_drawer/presentation/bloc/side_drawer_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/player_list_page/data/dataSources/players_list_local_data_source.dart';
import 'features/player_list_page/data/repositories/players_list_repository_impl.dart';
import 'features/player_list_page/domain/repositories/players_list_repository.dart';
import 'features/player_list_page/domain/usecases/clear_player_list_usecase.dart';
import 'features/player_list_page/domain/usecases/get_players_list_usecase.dart';
import 'features/player_list_page/domain/usecases/update_players_list_usecase.dart';
import 'features/player_list_page/presentation/bloc/player_list_bloc.dart';
import 'features/setting_page/domain/repositories/settings_repository.dart';
import 'features/setting_page/domain/usecases/change_app_language_usecase.dart';
import 'features/setting_page/domain/usecases/get_app_language_usecase.dart';

// service locator
final sl = GetIt.instance;

Future<void> init() async {
  //! Features - SideDrawer

  sl.registerFactory(() => SideDrawerBloc());

  //! Features - Settings

  sl.registerLazySingleton(() => SettingsBloc(
        getAppLanguageUsecase: sl(),
        changeAppLanguageUsecase: sl(),
      ));

  // Use cases

  sl.registerLazySingleton(() => GetAppLanguageUsecase(sl()));
  sl.registerLazySingleton(() => ChangeAppLanguageUsecase(sl()));

  // Repository

  sl.registerLazySingleton<SettingsRepository>(() => SettingsRepositoryImpl(
        settingsLocalDataSource: sl(),
      ));

  // Data sources

  sl.registerLazySingleton<SettingsLocalDataSource>(() => SettingsLocalDataSourceImpl(
        sharedPreferences: sl(),
      ));

  //! Features - NumberTrivia
  sl.registerFactory(() => PlayerListBloc(
        getPlayersListUsecase: sl(),
        updatePlayersListUsecase: sl(),
        clearPlayersListUsecase: sl(),
      ));

  // Use cases

  sl.registerLazySingleton(() => GetPlayersListUsecase(sl()));
  sl.registerLazySingleton(() => UpdatePlayersListUsecase(sl()));
  sl.registerLazySingleton(() => ClearPlayersListUsecase(sl()));

  // Repository

  sl.registerLazySingleton<PlayerListRepository>(() => PlayerListRepositoryImpl(
        localDataSource: sl(),
      ));

  // Data sources

  sl.registerLazySingleton<PlayersListLocalDataSource>(() => PlayersListLocalDataSourceImpl(
        sharedPreferences: sl(),
      ));

  //! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
