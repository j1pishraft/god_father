

import '../../domain/entities/player_entity.dart';

class PlayerModel extends Player {
  @override
  final String name;
  @override
  final String role;
  @override
  final bool isActive;

   const PlayerModel({
    required this.name,
    required this.role,
    this.isActive = true,
  }) : super.withRole(name: name, role: role, isActive: isActive);

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(name: json['name'], role: json['role'], isActive: json['isActive']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'role': role,
        'isActive': isActive,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [name, role, isActive];
}
