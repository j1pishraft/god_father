
import 'package:dartz/dartz.dart';
import 'package:god_father/core/error/failures.dart';
import 'package:god_father/features/role_list_page/domain/entities/player_role_entity.dart';


abstract class PlayerRoleRepository {
 Future<List<PlayerRole>?> getPlayersList();
}