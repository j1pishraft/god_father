import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/player_list_repository.dart';


class ClearPlayerListUseCase extends UseCase<bool, NoParams> {
  final PlayerListRepository repository;

  ClearPlayerListUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.clearPlayerList();
  }
}

