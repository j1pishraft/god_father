import 'package:god_father/features/role_list_page/domain/entities/player_role_entity.dart';

import '../../../role_list_page/data/model/player_role_model.dart';
import '../../domain/entities/player_entity.dart';

//ignore: must_be_immutable
class PlayerModel extends Player {
  final String newName;
   PlayerRole? newPlayerRole;
  final bool newIsActive;

   PlayerModel({
    required this.newName,
    required this.newPlayerRole,
    this.newIsActive = true,
  }) : super.withRole(name: newName, playerRole: newPlayerRole, isActive: newIsActive);

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
        newName: json['name'],
        newPlayerRole: json['playerRole'] != null ? PlayerRoleModel.fromJson(json['playerRole']) : null,
        // playerRole: json['playerRole'],
        newIsActive: json['isActive'] as bool);
  }

  Map<String, dynamic> toJson() => {
        'name': newName,
        'playerRole': {
          'roleName': playerRole?.roleName,
          'description': playerRole?.description,
          'category': playerRole?.category,
          'canWakeupAtNight': playerRole?.canWakeupAtNight,
          'wakeupPriority': playerRole?.wakeupPriority,
          'isActive': playerRole?.isActive,
          'isSelected': playerRole?.isSelected,
        },
        'isActive': newIsActive,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [newName, newPlayerRole, newIsActive];
}
