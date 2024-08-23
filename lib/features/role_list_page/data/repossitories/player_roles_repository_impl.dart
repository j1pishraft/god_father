import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../../core/constants/constants.dart';
import '../../domain/entities/player_role_entity.dart';
import '../../domain/repositories/player_role_list_repository.dart';
import '../dataSoources/player_roles_local_data_source.dart';
import '../model/player_role_model.dart';

// typedef _ConcreteOrRandomChooser = Future<NumberTrivia?>? Function();
// typedef _ConcreteOrRandomChooser = Future<PlayerListModel?>? Function();

class PlayerRoleRepositoryImpl implements PlayerRoleRepository {
  final PlayerRoleLocalDataSource localDataSource;

  PlayerRoleRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<List<PlayerRole>> getPlayersList() async {
    // playerList = PlayerListModel.fromEntity(playerList as PlayerListModel)
    final String rolesJson = await rootBundle.loadString('assets/json/playerRolesJson/player_roles_en.json');
    final playerRoleString = await localDataSource.getString(cachedPlayersList);

    // Convert JSON string to dynamic list
    List<PlayerRoleModel>? roleList = [];
    if (rolesJson != null) {
      List<dynamic> jsonList = json.decode(rolesJson);

      // Map dynamic list to list of PlayerModel instances
      roleList = jsonList
          .map((jsonMap) => PlayerRoleModel.fromJson(jsonMap))
          .toList();



      // roleList = jsonList
      //     .map((jsonMap) => PlayerRoleModel.fromJson(jsonMap))
      //     .map<PlayerRole>((model) => PlayerRole(
      //     roleName: model.roleName,
      //     description: model.description,
      //     category: model.category,
      //     canWakeupAtNight: model.canWakeupAtNight,
      //     wakeupPriority: model.wakeupPriority,
      //     isSelected: model.isSelected,
      //     isActive: model.isActive,
      //     isCommonRole: model.isCommonRole,
      //     count: model.count))
      //     .toList();
    }
    return roleList;
  }
}
