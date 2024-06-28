part of 'player_list_bloc.dart';


enum PlayerListStatus {
  initial,
  loading,
  loaded,
  error,
}


class PlayerListState extends Equatable {

  const PlayerListState( {this.isNameDuplicated = false, this.isDeleteViewPressed = false, this.status = PlayerListStatus.initial, this.playerName = '', this.errorMessage = '', this.players, this.isAllSelected});

  final PlayerListStatus status;
  final String playerName;
  final String? errorMessage;
  final bool? isNameDuplicated;
  final bool? isDeleteViewPressed;
  final List<Player>? players;
  final bool? isAllSelected;


  PlayerListState copyWith({
    PlayerListStatus? status,
    String? playerName,
    String? errorMessage,
    String? textFieldError,
    bool? isNameDuplicated,
    bool? isDeleteViewPressed,
    List<Player>? players,
    bool? isAllSelected,
}) {
    return PlayerListState(
      status: status ?? this.status,
      playerName: playerName ?? this.playerName,
      errorMessage: errorMessage ?? this.errorMessage,
      isNameDuplicated: isNameDuplicated ?? false,
      isDeleteViewPressed: isDeleteViewPressed ?? this.isDeleteViewPressed,
      players: players ?? this.players,
      isAllSelected: isAllSelected ?? this.isAllSelected
    );
}

  @override
  List<Object?> get props => [status,playerName,players,isNameDuplicated,errorMessage,isDeleteViewPressed, isAllSelected];

}
