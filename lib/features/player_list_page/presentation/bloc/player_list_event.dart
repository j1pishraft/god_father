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

class PlayerListDeleteSelectedPlayersPressed extends PlayerListEvent {
  const PlayerListDeleteSelectedPlayersPressed();
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

class PlayerSelectedInDeleteView extends PlayerListEvent {
  final Player? player;
  const PlayerSelectedInDeleteView(this.player);
}

class InputError extends PlayerListEvent {
  final String? inputError;
  const InputError(this.inputError);
}

class PlayerListSelectAllPressed extends PlayerListEvent {
  final bool isSelected;
  const PlayerListSelectAllPressed(this.isSelected);
}

