import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:god_father/core/error/failures.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/player_entity.dart';
import '../../domain/repositories/players_list_repository.dart';
import '../dataSources/players_list_local_data_source.dart';
import '../model/player_model.dart';

// typedef _ConcreteOrRandomChooser = Future<NumberTrivia?>? Function();
// typedef _ConcreteOrRandomChooser = Future<PlayerListModel?>? Function();

class PlayerListRepositoryImpl implements PlayerListRepository {
  final PlayersListLocalDataSource localDataSource;

  PlayerListRepositoryImpl({
    required this.localDataSource,
  });


  @override
  Future<List<Player>> getPlayersList() async {
    // playerList = PlayerListModel.fromEntity(playerList as PlayerListModel)
    final playerString = await localDataSource.getString(cachedPlayersList);

    // Convert JSON string to dynamic list
    List<Player>? playerList = [];
    if (playerString != null) {
      List<dynamic> jsonList = json.decode(playerString);

      // Map dynamic list to list of PlayerModel instances
      playerList = jsonList.map((jsonMap) => PlayerModel.fromJson(jsonMap)).map<Player>((model) => Player.withRole(name: model.name, role: model.role, isActive: model.isActive)).toList();


    } return playerList;
  }

  @override
  Future<Either<Failure, List<Player>>> updatePlayersList(List<Player> playerList) async {
    try {
      List<PlayerModel> playersModels = playerList.map((player) => PlayerModel(name: player.name, role: player.role, isActive: player.isActive)).toList();
      final jsonList = json.encode(playersModels);
      localDataSource.cachePlayers(jsonList);
      final result = await getPlayersList();
      return Right(result);
    } on CacheException {
      return const Left(CacheFailure(message: 'Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, bool>> clearPlayerList() async {
    try {
      final isCleared = await localDataSource.clearCatch(cachedPlayersList);

      return Right(isCleared);
    } on CacheException {
      return const Left(CacheFailure(message: 'Something went wrong!'));
    }
  }
}
