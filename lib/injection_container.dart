import 'package:god_father/features/user_list/data/dataSources/players_list_local_data_source.dart';
import 'package:god_father/features/user_list/domain/repositories/players_list_repository.dart';
import 'package:god_father/features/user_list/domain/usecases/get_players_list_usecase.dart';
import 'package:god_father/features/user_list/domain/usecases/update_players_list_usecase.dart';
import 'package:god_father/features/user_list/presentation/bloc/player_list_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/user_list/data/repositories/players_list_repository_impl.dart';
import 'features/user_list/domain/usecases/clear_player_list_usecase.dart';

// service locator
final sl = GetIt.instance;

Future<void> init() async {
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
