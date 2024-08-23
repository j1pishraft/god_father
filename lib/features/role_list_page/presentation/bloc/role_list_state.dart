part of 'role_list_bloc.dart';

enum RoleListStatus {
  initial,
  loading,
  loaded,
  error,
}

class RoleListState extends Equatable {
  const RoleListState({this.isNameDuplicated = false,
    this.isDeleteViewPressed = false,
    this.status = RoleListStatus.initial,
    this.roleName = '',
    this.errorMessage = '',
    this.players,
    this.playersWithRole,
    this.roles,
    this.citizenRoles,
    this.mafiaRoles,
    this.freeRoles,
    this.selectedRoleList,
    this.textFieldError = '',
    this.isSelectionError,
    this.isAllSelected,
    this.isRoleSelected,
    this.isCitizenListExpanded = true,
    this.isMafiaListExpanded = true,
    this.isFreeListExpanded = true,
    this.selectedPlayerRolesTotalCount = 0});

  final RoleListStatus status;
  final String roleName;
  final String? errorMessage;
  final String? textFieldError;
  final bool? isSelectionError;
  final bool? isNameDuplicated;
  final List<Player>? players;
  final List<Player>? playersWithRole;
  final List<PlayerRole>? roles;
  final List<PlayerRole>? citizenRoles;
  final List<PlayerRole>? mafiaRoles;
  final List<PlayerRole>? freeRoles;
  final List<PlayerRole>? selectedRoleList;
  final bool? isDeleteViewPressed;
  final bool? isAllSelected;
  final bool? isRoleSelected;
  final bool? isCitizenListExpanded;
  final bool? isMafiaListExpanded;
  final bool? isFreeListExpanded;
  final int? selectedPlayerRolesTotalCount;

  RoleListState copyWith({
    RoleListStatus? status,
    String? roleName,
    String? errorMessage,
    String? textFieldError,
    bool? isSelectionError,
    bool? isNameDuplicated,
    bool? isDeleteViewPressed,
    List<Player>? players,
    List<Player>? playersWithRole,
    List<PlayerRole>? roles,
    List<PlayerRole>? citizenRoles,
    List<PlayerRole>? mafiaRoles,
    List<PlayerRole>? freeRoles,
    List<PlayerRole>? selectedRoleList,
    bool? isAllSelected,
    bool? isRoleSelected,
    bool? isCitizenListExpanded,
    bool? isMafiaListExpanded,
    bool? isFreeListExpanded,
    int? selectedPlayerRolesTotalCount
  }) {
    return RoleListState(
        status: status ?? this.status,
        roleName: roleName ?? this.roleName,
        errorMessage: errorMessage ?? this.errorMessage,
        textFieldError: textFieldError ?? '',
        isSelectionError: isSelectionError ?? this.isSelectionError,
        isNameDuplicated: isNameDuplicated ?? false,
        isDeleteViewPressed: isDeleteViewPressed ?? this.isDeleteViewPressed,
        players: players ?? this.players,
        playersWithRole: playersWithRole ?? this.playersWithRole,
        roles: roles ?? this.roles,
        citizenRoles: citizenRoles ?? this.citizenRoles,
        mafiaRoles: mafiaRoles ?? this.mafiaRoles,
        freeRoles: freeRoles ?? this.freeRoles,
        selectedRoleList: selectedRoleList ?? this.selectedRoleList,
        isAllSelected: isAllSelected ?? this.isAllSelected,
        isRoleSelected: isRoleSelected ?? this.isRoleSelected,
        isCitizenListExpanded: isCitizenListExpanded ?? this.isCitizenListExpanded,
        isMafiaListExpanded: isMafiaListExpanded ?? this.isMafiaListExpanded,
        isFreeListExpanded: isFreeListExpanded ?? this.isFreeListExpanded,
        selectedPlayerRolesTotalCount: selectedPlayerRolesTotalCount ?? this.selectedPlayerRolesTotalCount);
  }

  @override
  List<Object?> get props =>
      [
        status,
        roleName,
        players,
        playersWithRole,
        roles,
        citizenRoles,
        mafiaRoles,
        freeRoles,
        selectedRoleList,
        isNameDuplicated,
        errorMessage,
        textFieldError,
        isSelectionError,
        isDeleteViewPressed,
        isAllSelected,
        isRoleSelected,
        isCitizenListExpanded,
        isMafiaListExpanded,
        isFreeListExpanded,
        selectedPlayerRolesTotalCount
      ];
}
