import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';


import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/player_entity.dart';
import '../repositories/player_list_repository.dart';

class UpdatePlayerListUsecase implements UseCase<List<Player>, UpdatePlayerListUsecaseParams> {
  final PlayerListRepository repository;

  UpdatePlayerListUsecase(this.repository);

  @override
  Future<Either<Failure, List<Player>>> call(UpdatePlayerListUsecaseParams params) async {

    return await repository.updatePlayersList(params.players);
  }


}

class UpdatePlayerListUsecaseParams extends Equatable {
  final List<Player> players;

  const UpdatePlayerListUsecaseParams({required this.players});

  @override
  List<Object?> get props => [players];
}
