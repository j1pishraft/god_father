
import '../../../../core/usecases/usecase.dart';
import '../entities/player_entity.dart';
import '../repositories/players_list_repository.dart';

class GetPlayersListUsecase implements UseCaseNoEither<List<Player>, NoParams> {
  final PlayerListRepository repository;

  GetPlayersListUsecase(this.repository);

  @override
  Future<List<Player>?> call(NoParams params) async {
    return await repository.getPlayersList();
  }


}


