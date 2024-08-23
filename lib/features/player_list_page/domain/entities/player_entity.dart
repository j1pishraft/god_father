import 'package:equatable/equatable.dart';

import '../../../role_list_page/domain/entities/player_role_entity.dart';

//ignore: must_be_immutable
class Player extends Equatable {
  final String name;
  final PlayerRole? playerRole;
  final bool isActive;
  final bool isSelected;
  final bool isVisible;

  const Player({required this.isSelected, required this.name, required this.playerRole, required this.isActive, required this.isVisible, });

  const Player.withName({
    required this.name,
    this.playerRole,
    this.isActive = true,
    this.isSelected = false,
    this.isVisible = true,
  });

  const Player.withRole({
    required this.name,
    required this.playerRole,
    this.isActive = true,
    this.isSelected = false,
    this.isVisible = true,
  });

  const Player.withIsActive({
    this.name = '',
    this.playerRole,
    required this.isActive,
    this.isSelected = false,
    this.isVisible = true,
  });

  Player copyWith({
    String? name,
    PlayerRole? playerRole,
    bool? isActive,
    bool? isSelected,
    bool? isVisible,
  }) {
    return Player(
      name: name ?? this.name,
      playerRole: playerRole ?? this.playerRole,
      isActive: isActive ?? this.isActive,
      isSelected: isSelected ?? this.isSelected,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  List<Object?> get props => [name, playerRole, isActive, isSelected, isVisible];
}
