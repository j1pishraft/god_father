part of 'role_list_bloc.dart';

enum RoleListStatus {
  initial,
  loading,
  loaded,
  error,
}

class RoleListState extends Equatable {
  const RoleListState(
      {this.isNameDuplicated = false,
      this.isDeleteViewPressed = false,
      this.status = RoleListStatus.initial,
      this.playerName = '',
      this.errorMessage = '',
      this.textFieldError = '',
      /*this.players,*/ this.isAllSelected});

  final RoleListStatus status;
  final String playerName;
  final String? errorMessage;
  final String? textFieldError;
  final bool? isNameDuplicated;
  final bool? isDeleteViewPressed;

  // final List<Player>? players;
  final bool? isAllSelected;

  RoleListState copyWith({
    RoleListStatus? status,
    String? playerName,
    String? errorMessage,
    String? textFieldError,
    bool? isNameDuplicated,
    bool? isDeleteViewPressed,
    // List<Player>? players,
    bool? isAllSelected,
  }) {
    return RoleListState(
        status: status ?? this.status,
        playerName: playerName ?? this.playerName,
        errorMessage: errorMessage ?? this.errorMessage,
        textFieldError: textFieldError ?? '',
        isNameDuplicated: isNameDuplicated ?? false,
        isDeleteViewPressed: isDeleteViewPressed ?? this.isDeleteViewPressed,
        // players: players ?? this.players,
        isAllSelected: isAllSelected ?? this.isAllSelected);
  }

  @override
  List<Object?> get props => [status, playerName, /*players,*/ isNameDuplicated, errorMessage, textFieldError, isDeleteViewPressed, isAllSelected];
}
