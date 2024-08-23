part of 'player_list_bloc.dart';

enum PlayerListStatus {
  initial,
  loading,
  loaded,
  error,
}

class PlayerListState extends Equatable {
  const PlayerListState({
    this.isNameDuplicated = false,
    this.isInputIsDiffLang = false,
    this.isInputContainSpecialChar = false,
    this.isDeleteViewPressed = false,
    this.isActiveListExpanded = true,
    this.isInactiveListExpanded = true,
    this.status = PlayerListStatus.initial,
    this.playerName = '',
    this.errorMessage = '',
    this.players = const [],
    this.activePlayers = const [],
    this.inactivePlayers = const [],
    this.isAllSelected,
    this.activePlayersCount,
  });

  final PlayerListStatus status;
  final String playerName;
  final String? errorMessage;
  final bool? isNameDuplicated;
  final bool? isInputIsDiffLang;
  final bool? isInputContainSpecialChar;
  final bool? isDeleteViewPressed;
  final bool? isActiveListExpanded;
  final bool? isInactiveListExpanded;
  final List<Player>? players;
  final List<Player>? activePlayers;
  final List<Player>? inactivePlayers;
  final bool? isAllSelected;
  final int? activePlayersCount;

  PlayerListState copyWith({
    PlayerListStatus? status,
    String? playerName,
    String? errorMessage,
    String? textFieldError,
    bool? isNameDuplicated,
    bool? isInputIsDiffLang,
    bool? isInputContainSpecialChar,
    bool? isDeleteViewPressed,
    bool? isActiveListExpanded,
    bool? isInactiveListExpanded,
    List<Player>? players,
    List<Player>? activePlayers,
    List<Player>? inactivePlayers,
    bool? isAllSelected,
    int? activePlayersCount,
  }) {
    return PlayerListState(
        status: status ?? this.status,
        playerName: playerName ?? this.playerName,
        errorMessage: errorMessage ?? this.errorMessage,
        isNameDuplicated: isNameDuplicated ?? false,
        isInputIsDiffLang: isInputIsDiffLang ?? this.isInputIsDiffLang,
        isInputContainSpecialChar: isInputContainSpecialChar ?? this.isInputContainSpecialChar,
        isDeleteViewPressed: isDeleteViewPressed ?? this.isDeleteViewPressed,
        isActiveListExpanded: isActiveListExpanded ?? this.isActiveListExpanded,
        isInactiveListExpanded: isInactiveListExpanded ?? this.isInactiveListExpanded,
        players: players ?? this.players,
        activePlayers: activePlayers ?? this.activePlayers,
        inactivePlayers: inactivePlayers ?? this.inactivePlayers,
        isAllSelected: isAllSelected ?? this.isAllSelected,
        activePlayersCount: activePlayersCount ?? this.activePlayersCount);
  }

  @override
  List<Object?> get props => [
        status,
        playerName,
        players,
        activePlayers,
        inactivePlayers,
        isNameDuplicated,
        isInputIsDiffLang,
        isInputContainSpecialChar,
        errorMessage,
        isDeleteViewPressed,
        isActiveListExpanded,
        isInactiveListExpanded,
        isAllSelected,
        activePlayersCount
      ];
}
