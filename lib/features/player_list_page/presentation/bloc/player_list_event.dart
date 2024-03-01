part of 'player_list_bloc.dart';

abstract class PlayerListEvent extends Equatable {
  const PlayerListEvent();

  @override
  List<Object> get props => [];
}

class PlayerListStarted extends PlayerListEvent {}



class PlayerListAddPressed extends PlayerListEvent {
  const PlayerListAddPressed();
}

class PlayerListDeleteSelectedItemPressed extends PlayerListEvent {
  const PlayerListDeleteSelectedItemPressed();
}


class PlayerListNameChanged extends PlayerListEvent {
  final String playerName;
  const PlayerListNameChanged(this.playerName);
}

class PlayerListClearPressed extends PlayerListEvent {
  const PlayerListClearPressed();
}

class PlayerListDeleteViewButtonPressed extends PlayerListEvent {
  const PlayerListDeleteViewButtonPressed();
}

class PlayerListDeActiveSelected extends PlayerListEvent {
  final Player? player;
  const PlayerListDeActiveSelected(this.player);
}

class PlayerSelected extends PlayerListEvent {
  final Player? player;
  const PlayerSelected(this.player);
}

class PlayerListSelectAllPressed extends PlayerListEvent {
  final bool isSelected;
  const PlayerListSelectAllPressed(this.isSelected);
}

