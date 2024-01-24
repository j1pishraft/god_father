import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:god_father/features/user_list/domain/repositories/players_list_repository.dart';


import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/player_entity.dart';

class UpdatePlayersListUsecase implements UseCase<List<Player>, UpdatePlayersListUsecaseParams> {
  final PlayerListRepository repository;

  UpdatePlayersListUsecase(this.repository);

  @override
  Future<Either<Failure, List<Player>>> call(UpdatePlayersListUsecaseParams params) async {

    return await repository.updatePlayersList(params.players);
  }


}

class UpdatePlayersListUsecaseParams extends Equatable {
  final List<Player> players;

  const UpdatePlayersListUsecaseParams({required this.players});

  @override
  List<Object?> get props => [players];
}
