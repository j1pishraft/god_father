
import 'package:god_father/features/role_list_page/domain/entities/player_role_entity.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/player_role_list_repository.dart';



class GetRoleListUseCase implements UseCaseNoEither<List<PlayerRole>, NoParams> {
  final PlayerRoleRepository repository;

  GetRoleListUseCase(this.repository);

  @override
  Future<List<PlayerRole>?> call(NoParams params) async {
    return await repository.getPlayersList();
  }


}


