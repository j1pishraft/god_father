
import '../../../../core/usecases/usecase.dart';
import '../entities/player_entity.dart';
import '../repositories/player_list_repository.dart';

class GetPlayerListUseCase implements UseCaseNoEither<List<Player>, NoParams> {
  final PlayerListRepository repository;

  GetPlayerListUseCase(this.repository);

  @override
  Future<List<Player>?> call(NoParams params) async {
    return await repository.getPlayersList();
  }


}


