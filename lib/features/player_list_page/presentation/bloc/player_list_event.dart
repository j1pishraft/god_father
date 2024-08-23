part of 'player_list_bloc.dart';

abstract class PlayerListEvent extends Equatable {
  const PlayerListEvent();

  @override
  List<Object> get props => [];
}

class PlayerListFetched extends PlayerListEvent {}



class PlayerListAddButtonPressed extends PlayerListEvent {
  const PlayerListAddButtonPressed();
}

class PlayerListDeleteSelectedPlayersPressed extends PlayerListEvent {
  const PlayerListDeleteSelectedPlayersPressed();
}


class PlayerNameChanged extends PlayerListEvent {
  final String playerName;
  const PlayerNameChanged(this.playerName);
}

class PlayerListClearPressed extends PlayerListEvent {
  const PlayerListClearPressed();
}

class PlayerListDeleteViewButtonPressed extends PlayerListEvent {
  const PlayerListDeleteViewButtonPressed();
}

class PlayerListIsActiveSelected extends PlayerListEvent {
  final Player? player;
  final bool inActiveTile;
  final int index;

  const PlayerListIsActiveSelected(this.player, this.inActiveTile, this.index);
}

class PlayerSelectedInDeleteView extends PlayerListEvent {
  final Player? player;
  final bool inActiveTile;
  final bool checkboxValue;
  final int index;
  const PlayerSelectedInDeleteView(this.player, this.inActiveTile, this.index, this.checkboxValue);
}

class ListHeaderPressed extends PlayerListEvent {
  final bool isExpanded;
  final bool isActiveList;
  const ListHeaderPressed(this.isExpanded, this.isActiveList);
}

class InputError extends PlayerListEvent {
  final String? inputError;
  const InputError(this.inputError);
}

class PlayerListSelectAllPressed extends PlayerListEvent {
  final bool isSelected;
  const PlayerListSelectAllPressed(this.isSelected);
}

