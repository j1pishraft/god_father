import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../player_list_page/domain/entities/player_entity.dart';
import '../../domain/entities/player_role_entity.dart';
import '../../domain/usecases/get_role_list_usecase.dart';

part 'role_list_event.dart';

part 'role_list_state.dart';

class RoleListBloc extends Bloc<RoleListEvent, RoleListState> {
  final GetRoleListUseCase getPlayerRoleListUseCase;
  ExpandedTileController expandedTileController = ExpandedTileController();
  ExpandedTileController citizenListController = ExpandedTileController(isExpanded: true);
  ExpandedTileController mafiaListController = ExpandedTileController(isExpanded: true);
  ExpandedTileController freePlayerListController = ExpandedTileController(isExpanded: true);

  RoleListBloc({required this.getPlayerRoleListUseCase}) : super(const RoleListState()) {
    on<PlayerAddedToState>(_onPlayerAddedToState);
    on<RoleListFetched>(_onRoleListFetched);
    on<PlayerRoleIsSelected>(_onPlayerRoleIsSelected);
    on<SelectedPlayerListCreated>(_onSelectedPlayerListCreated);
    on<IncreaseRoleCountPressed>(_onIncreaseRoleCountPressed);
    on<DecreaseRoleCountPressed>(_onDecreaseRoleCountPressed);
    on<PlayerRoleAssigned>(_onPlayerRoleAssigned);
    on<ToggleVisibilityPressed>(_onToggleVisibilityPressed);
    on<ListHeaderPressed>(_onListHeaderPressed);
  }

  FutureOr<void> _onPlayerAddedToState(PlayerAddedToState event, Emitter<RoleListState> emit) {
    // List<Player> players = [...event.players];
    //deep Copy to avoid referenced copy
    List<Player> players = event.players.map((player) => player.copyWith()).toList();

    emit(state.copyWith(players: players, status: RoleListStatus.initial));
  }

  FutureOr<void> _onRoleListFetched(RoleListFetched event, Emitter<RoleListState> emit) async {
    List<PlayerRole>? selectedRoleList = state.selectedRoleList ?? [];
    // debugPrint("List Length${state.roles?.length}");

    emit(state.copyWith(status: RoleListStatus.loading));
    final roles = await getPlayerRoleListUseCase(NoParams());
    var categorizedRoles = _categorizeRoles(roles ?? []);

    /// Calculate the total count of selected roles and add it to selectedRoleList
    // int currentTotalCount = roles!.where((role) => role.isSelected!).fold(0, (sum, role) => sum + role.count!);
    int currentTotalCount = 0;
    // Iterate over the roles and add selected ones to the selectedRoleList
    for (var role in roles!) {
      if (role.isSelected ?? false) {
        selectedRoleList.add(role);
        currentTotalCount++;
      }
    }
    emit(state.copyWith(
        status: RoleListStatus.loaded,
        roles: roles,
        citizenRoles: categorizedRoles['Citizen'],
        mafiaRoles: categorizedRoles['Mafia'],
        freeRoles: categorizedRoles['Free'],
        selectedRoleList: selectedRoleList,
        selectedPlayerRolesTotalCount: currentTotalCount));

    // // Shuffle the roles list randomly
    // roles?.shuffle(Random());
    //
    // for (int i = 0; i < state.players!.length; i++) {
    //   state.players![i].playerRole = roles![i % roles.length];
    // }
    // debugPrint('==================${event.players}');
  }

  bool _isAllSelected(List<PlayerRole>? roles) {
    if ((roles?.isEmpty ?? true) || (roles?.any((element) => element.isSelected == false) ?? false)) {
      return false;
    }
    return true;
  }

  // Function to categorize roles
  Map<String, List<PlayerRole>> _categorizeRoles(List<PlayerRole> roles) {
    List<PlayerRole> mafiaRoles = [];
    List<PlayerRole> citizenRoles = [];
    List<PlayerRole> freeRoles = [];

    for (var role in roles) {
      switch (role.category) {
        case 1:
          citizenRoles.add(role);
          break;
        case 2:
          mafiaRoles.add(role);
          break;
        case 3:
          freeRoles.add(role);
          break;
        default:
          // Handle roles with unknown categories if necessary
          break;
      }
    }

    return {
      'Citizen': citizenRoles,
      'Mafia': mafiaRoles,
      'Free': freeRoles,
    };
  }

  FutureOr<void> _onPlayerRoleIsSelected(PlayerRoleIsSelected event, Emitter<RoleListState> emit) async {
    // Count the number of selected roles
    final int selectedRolesCount = state.roles?.where((role) => role.isSelected ?? false).length ?? 0;

    // Check if the number of selected roles exceeds the number of players
    if (!event.playerRole!.isSelected! && selectedRolesCount >= state.players!.length) {
      // Do nothing if the selected roles exceed the number of players
      emit(state.copyWith(status: RoleListStatus.error, isSelectionError: true));
      await Future.delayed(Duration(milliseconds: 100));
      emit(state.copyWith(status: RoleListStatus.loaded, isSelectionError: false));
      return Future.value();
    }
    // Function to update if role is selected
    List<PlayerRole> updateRoles(List<PlayerRole>? roles) {
      return roles!.map((role) {
        return role.roleName == event.playerRole?.roleName ? role.copyWith(isSelected: !role.isSelected!) : role;
      }).toList();
    }

    // Update each list using the function
    final List<PlayerRole> updatedRole = updateRoles(state.roles);
    final List<PlayerRole> updatedCitizenRole = updateRoles(state.citizenRoles);
    final List<PlayerRole> updatedMafiaRole = updateRoles(state.mafiaRoles);
    final List<PlayerRole> updatedFreeRole = updateRoles(state.freeRoles);

    /// Calculate the total count of selected roles
    int currentTotalCount = updatedRole.where((role) => role.isSelected!).fold(0, (sum, role) => sum + role.count!);

    // Emit the new state
    emit(state.copyWith(
        roles: updatedRole,
        citizenRoles: updatedCitizenRole,
        mafiaRoles: updatedMafiaRole,
        freeRoles: updatedFreeRole,
        selectedPlayerRolesTotalCount: currentTotalCount));

    // Debug print statements
    debugPrint('++++++++++++++++++++++++$updatedRole');
    debugPrint('++++++++++++++++++++++++$updatedCitizenRole');
    debugPrint('++++++++++++++++++++++++$updatedMafiaRole');
    debugPrint('++++++++++++++++++++++++$updatedFreeRole');
  }

  FutureOr<void> _onSelectedPlayerListCreated(SelectedPlayerListCreated event, Emitter<RoleListState> emit) {
    emit(state.copyWith(status: RoleListStatus.loading));
    List<PlayerRole> selectedPlayerRoles = state.roles!.where((role) => role.isSelected!).toList();
    emit(state.copyWith(status: RoleListStatus.loaded, selectedRoleList: selectedPlayerRoles));
  }

  FutureOr<void> _onIncreaseRoleCountPressed(IncreaseRoleCountPressed event, Emitter<RoleListState> emit) {
    List<PlayerRole>? selectedPlayerRoles = state.selectedRoleList;

    // List<PlayerRole>? selectedPlayerRoles = List.from(state.selectedRoleList!);

    /// Get the existing total count of selected roles
    int currentTotalCount = state.selectedPlayerRolesTotalCount!;

    /// Ensure the total count doesn't exceed the number of players when increasing the count
    if (currentTotalCount < state.players!.length) {
      /// Update the count for the specific role
      for (int i = 0; i < selectedPlayerRoles!.length; i++) {
        if (i == event.index) {
          selectedPlayerRoles[i] = selectedPlayerRoles[i].copyWith(count: selectedPlayerRoles[i].count! + 1);
          // selectedPlayerRoles.add(selectedPlayerRoles[i]);
          currentTotalCount++;
        }
      }

      /// Emit the new state
      emit(state.copyWith(selectedRoleList: selectedPlayerRoles, selectedPlayerRolesTotalCount: currentTotalCount));
    }
  }

  FutureOr<void> _onDecreaseRoleCountPressed(DecreaseRoleCountPressed event, Emitter<RoleListState> emit) {
    List<PlayerRole>? selectedPlayerRoles = state.selectedRoleList;

    /// Get the existing total count of selected roles
    int currentTotalCount = state.selectedPlayerRolesTotalCount!;

    /// Ensure count does not go below 1
    PlayerRole roleToUpdate = selectedPlayerRoles![event.index];
    if (roleToUpdate.count! > 1) {
      selectedPlayerRoles[event.index] = roleToUpdate.copyWith(count: roleToUpdate.count! - 1);


      currentTotalCount--;

      /// Emit the new state
      emit(state.copyWith(selectedRoleList: selectedPlayerRoles, selectedPlayerRolesTotalCount: currentTotalCount));
    }
  }

  FutureOr<void> _onPlayerRoleAssigned(PlayerRoleAssigned event, Emitter<RoleListState> emit) {
    List<PlayerRole> rolePool = [];
    //deep Copy to avoid referenced copy
    debugPrint('test');
    List<Player> tempPlayers = state.players?.map((player) => player.copyWith()).toList() ??[];
    List<PlayerRole> tempRole = state.selectedRoleList?.map((role) => role.copyWith()).toList() ??[];


    for (var role in tempRole) {
      for (int i = 0; i < role.count!; i++) {
        rolePool.add(role);
      }
    }

    rolePool.shuffle(Random());

    for (int i = 0; i < tempPlayers.length; i++) {
      tempPlayers[i] = tempPlayers[i].copyWith(playerRole: rolePool[i % rolePool.length]);
    }

    emit(state.copyWith(playersWithRole: tempPlayers,));
  }


  FutureOr<void> _onToggleVisibilityPressed(ToggleVisibilityPressed event, Emitter<RoleListState> emit) {

    // List<Player>? playersWithRole = List<Player>.from(state.playersWithRole ?? []);
    List<Player> playersWithRole = state.playersWithRole!.map((player) => player.copyWith()).toList();
    final player = playersWithRole[event.index];
    playersWithRole[event.index] = player.copyWith(isVisible: !player.isVisible);
    // playersWithRole[event.index] = playersWithRole[event.index].copyWith(isVisible: !playersWithRole[event.index].isVisible);

    emit(state.copyWith(playersWithRole: playersWithRole));
  }

  Future<void> _onListHeaderPressed(ListHeaderPressed event, Emitter<RoleListState> emit) async {
    if (event.categoryId == 1) {
      await _toggleExpansion(citizenListController, state.isCitizenListExpanded ?? false, !event.isExpanded, emit);
    } else if(event.categoryId == 2) {
      await _toggleExpansion(mafiaListController, state.isMafiaListExpanded ?? false, !event.isExpanded, emit);
    }else{
      await _toggleExpansion(freePlayerListController, state.isFreeListExpanded ?? false, !event.isExpanded, emit);
    }
  }

  Future<void> _toggleExpansion(
      ExpandedTileController controller,
      bool currentState,
      bool newExpandedState,
      Emitter<RoleListState> emit,
      ) async {
    if (newExpandedState) {
      controller.expand();
    } else {
      controller.collapse();
    }

    if (currentState != newExpandedState) {
      emit(state.copyWith(
        isCitizenListExpanded: controller == citizenListController ? newExpandedState : state.isCitizenListExpanded,
        isMafiaListExpanded: controller == mafiaListController ? newExpandedState : state.isMafiaListExpanded,
        isFreeListExpanded: controller == freePlayerListController ? newExpandedState : state.isFreeListExpanded,
      ));
    }
  }
}
