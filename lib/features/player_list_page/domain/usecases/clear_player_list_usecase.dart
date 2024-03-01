import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/players_list_repository.dart';


class ClearPlayersListUsecase implements UseCase<bool, NoParams> {
  final PlayerListRepository repository;

  ClearPlayersListUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.clearPlayerList();
  }
}

