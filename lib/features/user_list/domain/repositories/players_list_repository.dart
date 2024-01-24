
import 'package:dartz/dartz.dart';
import 'package:god_father/core/error/failures.dart';

import '../entities/player_entity.dart';

abstract class PlayerListRepository{
 Future<List<Player>?> getPlayersList();
 Future<Either<Failure, List<Player>>> updatePlayersList(List<Player> playerList);
 Future<Either<Failure, bool>> clearPlayerList();
}