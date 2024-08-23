part of 'role_list_bloc.dart';

abstract class RoleListEvent extends Equatable {
  const RoleListEvent();
  @override
  List<Object> get props => [];
}


class RoleListFetched extends RoleListEvent {
  final List<Player> players;

  const RoleListFetched({required this.players});

}

class PlayerRoleIsSelected extends RoleListEvent {
  final PlayerRole? playerRole;
  const PlayerRoleIsSelected(this.playerRole);
}

class PlayerAddedToState extends RoleListEvent {
  final List<Player> players;
  const PlayerAddedToState(this.players);
}

class SelectedPlayerListCreated extends RoleListEvent {}

class IncreaseRoleCountPressed extends RoleListEvent {
  final int index;
  const IncreaseRoleCountPressed(this.index);
}

class DecreaseRoleCountPressed extends RoleListEvent {
  final int index;
  const DecreaseRoleCountPressed(this.index);
}

class PlayerRoleAssigned extends RoleListEvent {
  const PlayerRoleAssigned();
}

class ToggleVisibilityPressed extends RoleListEvent {
  final int index;

  const ToggleVisibilityPressed(this.index);
}

class StatusSetToInitial extends RoleListEvent {
  const StatusSetToInitial();
}

class ListHeaderPressed extends RoleListEvent {
  final bool isExpanded;
  final int categoryId;
  const ListHeaderPressed(this.isExpanded, this.categoryId);
}