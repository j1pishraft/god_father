import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/player_entity.dart';
import '../../domain/usecases/clear_player_list_usecase.dart';
import '../../domain/usecases/get_player_list_usecase.dart';
import '../../domain/usecases/update_player_list_usecase.dart';

part 'player_list_event.dart';

part 'player_list_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
const String invalidInputFailureMessage = 'Invalid Input - the number must be a positive number or zero.';

class PlayerListBloc extends Bloc<PlayerListEvent, PlayerListState> {
  final GetPlayerListUseCase getPlayersListUseCase;
  final UpdatePlayerListUsecase updatePlayersListUseCase;
  final ClearPlayerListUseCase clearPlayersListUseCase;

  TextEditingController textEditingController = TextEditingController();
  ItemScrollController activeListScrollController = ItemScrollController();
  ItemScrollController inactiveListScrollController = ItemScrollController();
  ScrollController playersListScrollController = ScrollController();

  ExpandedTileController activePlayerListController = ExpandedTileController(isExpanded: true);
  ExpandedTileController inactivePlayerListController = ExpandedTileController(isExpanded: true);
  FocusNode focusNode = FocusNode();

  PlayerListBloc(
      {required this.clearPlayersListUseCase,
      required this.getPlayersListUseCase,
      required this.updatePlayersListUseCase})
      : super(const PlayerListState()) {
    on<PlayerListFetched>(_onPlayersFetched);
    on<PlayerListAddButtonPressed>(_onPlayerAddButtonPressed);
    on<PlayerNameChanged>(_onPlayerNameChanged);
    on<PlayerListClearPressed>(_onPlayerListClearPressed);
    on<PlayerListDeleteViewButtonPressed>(_onPlayerListDeleteViewButtonPressed);
    on<PlayerListIsActiveSelected>(_onPlayerListIsActiveSelected);
    on<PlayerListSelectAllPressed>(_onPlayerListSelectAllPressed);
    on<PlayerSelectedInDeleteView>(_onPlayerSelectedInDeleteView);
    on<PlayerListDeleteSelectedPlayersPressed>(_onPlayerListDeleteSelectedPlayersPressed);
    on<ListHeaderPressed>(_onListHeaderPressed);
  }

  FutureOr<void> _onPlayersFetched(PlayerListFetched event, Emitter<PlayerListState> emit) async {
    debugPrint("List Length${state.players?.length}");

    emit(state.copyWith(status: PlayerListStatus.loading));
    final players = await getPlayersListUseCase(NoParams());

    List<Player> activePlayers = [];
    List<Player> inactivePlayers = [];

    if (players != null && players.isNotEmpty) {
      var tempPlayer = partitionPlayers(players);
      activePlayers = tempPlayer.first;
      inactivePlayers = tempPlayer.last;
    }

    emit(state.copyWith(
        status: PlayerListStatus.loaded,
        players: players,
        activePlayers: activePlayers,
        inactivePlayers: inactivePlayers));
  }

  List<List<Player>> partitionPlayers(List<Player> players) {
    List<Player> activePlayers = [];
    List<Player> inactivePlayers = [];

    for (var player in players) {
      if (player.isActive) {
        activePlayers.add(player);
      } else {
        inactivePlayers.add(player);
      }
    }

    return [activePlayers, inactivePlayers];
  }

  FutureOr<void> _onPlayerAddButtonPressed(PlayerListAddButtonPressed event, Emitter<PlayerListState> emit) async {
    if (state.playerName.isNotEmpty) {
      emit(state.copyWith(status: PlayerListStatus.loading));

      // Get the new User Input
      final player = Player.withName(name: state.playerName, isActive: true);

      // get the current Active player list
      List<Player> updatedActivePlayers = state.activePlayers ?? [];

      // add the new name to the active player list
      updatedActivePlayers.add(player);

      // update list of players by concatenating new active and inactive lists
      List<Player> updatedPlayers = [];

      updatedPlayers.addAll(state.activePlayers!);
      updatedPlayers.addAll(state.inactivePlayers ?? []);

      // save list of Players with new name added to the local data source (Shared Preferences)
      final failureOrPlayerList =
          await updatePlayersListUseCase(UpdatePlayerListUsecaseParams(players: updatedPlayers));

      failureOrPlayerList.fold(
        (failure) => emit(PlayerListState(status: PlayerListStatus.error, errorMessage: failure.message)),
        (players) {
          // we only emit updatedActiveList because the inactive list remain the same. new name only be added to active list with isActive = true
          emit(state.copyWith(
            activePlayers: updatedActivePlayers,
            status: PlayerListStatus.loaded,
            players: players,
            playerName: '',
          ));
// // Calculate the current offset of the scroll view
//           double currentOffset = playersListScrollController.offset;
//           // Calculate the maximum allowable scroll offset
//           double maxScrollExtent = playersListScrollController.position.maxScrollExtent;
//          // Scroll the list of
//           if (currentOffset + playersListScrollController.position.viewportDimension < maxScrollExtent) {
//             playersListScrollController.jumpTo(
//                 (updatedActivePlayers.length - 1 )* 50,
//
//             );
//           }
          textEditingController.clear();
        },
      );
    }
  }

  FutureOr<void> _onPlayerNameChanged(PlayerNameChanged event, Emitter<PlayerListState> emit) {
    // if(focusNode.hasFocus){
    //   scrollController.jumpTo(scrollController.position.maxScrollExtent +70);
    // }
    textEditingController.text = event.playerName;
    emit(state.copyWith(playerName: event.playerName));
    _isInputIsInAppLang(emit);
    // _isPlayerNameDuplicated(emit);
  }

  // FutureOr<void> _isPlayerNameDuplicated(emit) {
  //   if (state.players != null) {
  //     if (state.players!.any((player) => player.name.toLowerCase().trim() == state.playerName.toLowerCase().trim())) {
  //       emit(state.copyWith(isNameDuplicated: true));
  //     }
  //   }
  //
  // }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return serverFailureMessage;
      case CacheFailure _:
        return cacheFailureMessage;
      default:
        return 'Unexpected error';
    }
  }
  FutureOr<void> _onPlayerListClearPressed(PlayerListClearPressed event, Emitter<PlayerListState> emit) async {
    emit(state.copyWith(status: PlayerListStatus.loading));
    final failureOrCleared = await clearPlayersListUseCase(NoParams());
    failureOrCleared.fold(
        (failure) => emit(state.copyWith(status: PlayerListStatus.error, errorMessage: failure.message)), (isCleared) {
      emit(state.copyWith(status: PlayerListStatus.loaded, players: [], isAllSelected: false));
    });
  }

  FutureOr<void> _onPlayerListIsActiveSelected(PlayerListIsActiveSelected event, Emitter<PlayerListState> emit) async {
    // List<Player> tempList = [...state.players ?? []];
    // int? index =tempList.indexWhere((element) => element.name == event.player.name);
    // if(index != -1){
    //   tempList[index] = tempList[index].copyWith(isActive: !tempList[index].isActive);
    // }
    //  emit(state.copyWith(players: tempList, isAllSelected: _isAllSelected(tempList)));

    /// Solution one with amir

    // List<Player> updatedPlayers =  [];
    // for(int i=0 ; i< state.players!.length ; i++) {
    //   if (state.players![i].name == event.player.name ) {
    //     updatedPlayers.add( state.players![i].copyWith(isActive: !state.players![i].isActive));
    //   }else{
    //     updatedPlayers.add(state.players![i]);
    //   }
    // }
    // emit(state.copyWith(players: updatedPlayers));

    // Amir : Solution 2 - More optimal
    List<Player> updateActivePlayer = state.activePlayers ?? [];
    List<Player> updateInactivePlayer = state.inactivePlayers ?? [];
    List<Player> updatedPlayers = [];
    Player player;
    if (event.inActiveTile) {
      player = updateActivePlayer.removeAt(event.index);
      updateInactivePlayer.add(player.copyWith(isActive: false));
    } else {
      player = updateInactivePlayer.removeAt(event.index);
      updateActivePlayer.add(player.copyWith(isActive: true));
    }

    updatedPlayers.addAll(updateActivePlayer);
    updatedPlayers.addAll(updateInactivePlayer);

    //
    // final List<Player> updatedPlayers = state.players!.map((player) {
    //   return player.name == event.player?.name ? player.copyWith(isActive: !player.isActive) : player;
    // }).toList();
    //
    // final activePlayers = state.players!.where((player) => player.isActive).toList();
    // final inactivePlayers = state.players!.where((player) => !player.isActive).toList();
    //
    // final int index = updatedPlayers.indexWhere((player) => player.name == event.player?.name);

    // if (index != -1) {
    //   // Player found in the list, remove and add to the last index
    //   if ((index == updatedPlayers.length - 1 || updatedPlayers[index + 1].isActive == false) &&
    //       (index == 0 || updatedPlayers[index - 1].isActive == true)) {
    //     debugPrint('');
    //   } else {
    //     final Player playerToMove = updatedPlayers.removeAt(index);
    //     if (playerToMove.isActive == false) {
    //       updatedPlayers.add(playerToMove.copyWith(isActive: playerToMove.isActive));
    //     } else {
    //       updatedPlayers.insert(0, playerToMove.copyWith(isActive: playerToMove.isActive));
    //     }
    //   }
    // }

    final failureOrPlayerList = await updatePlayersListUseCase(UpdatePlayerListUsecaseParams(players: updatedPlayers));

    failureOrPlayerList.fold(
      (failure) => emit(PlayerListState(status: PlayerListStatus.error, errorMessage: failure.message)),
      (players) {
        emit(state.copyWith(
            status: PlayerListStatus.loaded,
            players: players,
            inactivePlayers: updateInactivePlayer,
            activePlayers: updateActivePlayer));
      },
    );
    // emit(state.copyWith(players: updatedPlayers));

    ///Jay: solution by jay

    // List<Player> tempList = [];
    // state.players?.forEach((element) {
    //   if (element.name == event.player.name) {
    //     element.isActive = !element.isActive;
    //   }
    //   tempList.add(element);
    // });
    //
    // // tempList = [...state.players ?? []];
    // state.players?.clear();
    //
    // emit(state.copyWith(players: tempList));
  }

  FutureOr<void> _onPlayerListDeleteViewButtonPressed(
      PlayerListDeleteViewButtonPressed event, Emitter<PlayerListState> emit) {
    bool isDeleteViewPressed = !state.isDeleteViewPressed!;
    List<Player> updatedPlayers = state.players ?? [];
    List<Player> activePlayers = state.activePlayers ?? [];
    List<Player> inActivePlayers = state.inactivePlayers ?? [];
    if (isDeleteViewPressed) {
      emit(state.copyWith(
        isDeleteViewPressed: isDeleteViewPressed,
      ));
    } else {
      activePlayers = activePlayers.map((player) {
        return player.copyWith(isSelected: false);
      }).toList();

      inActivePlayers = inActivePlayers.map((player) {
        return player.copyWith(isSelected: false);
      }).toList();
      emit(state.copyWith(
          isAllSelected: false,
          isDeleteViewPressed: isDeleteViewPressed,
          activePlayers: activePlayers,
          inactivePlayers: inActivePlayers));
    }
  }

  bool _isAllSelected(List<Player>? activePlayerList, List<Player>? inActivePlayerList) {
    // Check if both lists are not empty and all items in both lists are selected
    if ((activePlayerList != null &&
            activePlayerList.isNotEmpty &&
            activePlayerList.every((player) => player.isSelected)) &&
        (inActivePlayerList != null &&
            inActivePlayerList.isNotEmpty &&
            inActivePlayerList.every((player) => player.isSelected))) {
      return true;
    }

    // If either list is empty or all items in both lists are selected, return true
    return false;
  }

  FutureOr<void> _onPlayerSelectedInDeleteView(PlayerSelectedInDeleteView event, Emitter<PlayerListState> emit) {
    // List<Player> tempList = [...state.players ?? []];
    // int? index =tempList.indexWhere((element) => element.name == event.player.name);
    // if(index != -1){
    //   tempList[index] = tempList[index].copyWith(isActive: !tempList[index].isActive);
    // }
    //  emit(state.copyWith(players: tempList, isAllSelected: _isAllSelected(tempList)));

    /// Solution one with amir

    // List<Player> updatedPlayers =  [];
    // for(int i=0 ; i< state.players!.length ; i++) {
    //   if (state.players![i].name == event.player.name ) {
    //     updatedPlayers.add( state.players![i].copyWith(isActive: !state.players![i].isActive));
    //   }else{
    //     updatedPlayers.add(state.players![i]);
    //   }
    // }
    // emit(state.copyWith(players: updatedPlayers));

    // Amir : Solution 2 - More optimal

    /// Deep Copy
    List<Player> updatedActivePlayers = state.activePlayers?.map((player) => player.copyWith()).toList() ?? [];
    List<Player> updatedInactivePlayers = state.inactivePlayers?.map((player) => player.copyWith()).toList() ?? [];
    List<Player> updatedPlayers = [];

    if (event.inActiveTile) {
      updatedActivePlayers[event.index] = updatedActivePlayers[event.index].copyWith(isSelected: !event.checkboxValue);
      // updatedActivePlayers[event.index].copyWith(isSelected: !event.inActiveTile);
      // player = updateActivePlayer[event.index].copyWith(isSelected: false);
      // updateInactivePlayer.add(player.copyWith(isActive: !event.inActiveTile));
    } else {
      updatedInactivePlayers[event.index] =
          updatedInactivePlayers[event.index].copyWith(isSelected: !event.checkboxValue);
      // player = updateInactivePlayer.removeAt(event.index);
      // updateActivePlayer.add(player.copyWith(isActive: !event.inActiveTile));
    }

    updatedPlayers.addAll(updatedActivePlayers);
    updatedPlayers.addAll(updatedInactivePlayers);

    // List<Player> updatedPlayers = [...state.players ?? []];
    //
    // updatedPlayers = updatedPlayers.map((player) {
    //   return player.name == event.player?.name ? player.copyWith(isSelected: !player.isSelected) : player;
    // }).toList();

    emit(state.copyWith(
        players: updatedPlayers,
        activePlayers: updatedActivePlayers,
        inactivePlayers: updatedInactivePlayers,
        isAllSelected: _isAllSelected(updatedActivePlayers, updatedInactivePlayers)));

    ///Jay: solution by jay

    // List<Player> tempList = [];
    // state.players?.forEach((element) {
    //   if (element.name == event.player.name) {
    //     element.isActive = !element.isActive;
    //   }
    //   tempList.add(element);
    // });
    //
    // // tempList = [...state.players ?? []];
    // state.players?.clear();
    //
    // emit(state.copyWith(players: tempList));
  }

  FutureOr<void> _onPlayerListSelectAllPressed(PlayerListSelectAllPressed event, Emitter<PlayerListState> emit) {
    print('isSelected ${event.isSelected}');
    List<Player> updatedPlayers = [...state.players ?? []];
    List<Player> updatedActivePlayers = [];
    List<Player> updatedInactivePlayers = [];
    updatedPlayers = updatedPlayers.map((s) => s.copyWith(isSelected: event.isSelected)).toList();
    // Derive the active and inactive players from the updated players list
    updatedActivePlayers = updatedPlayers.where((player) => player.isActive).toList();
    updatedInactivePlayers = updatedPlayers.where((player) => !player.isActive).toList();

    emit(state.copyWith(
        players: updatedPlayers,
        isAllSelected: event.isSelected,
        activePlayers: updatedActivePlayers,
        inactivePlayers: updatedInactivePlayers));
  }

  ///--------------------

  FutureOr<void> _onPlayerListDeleteSelectedPlayersPressed(
      PlayerListDeleteSelectedPlayersPressed event, Emitter<PlayerListState> emit) async {
    // emit(state.copyWith(players: []));
    List<Player> updatedPlayers = [];
    List<Player> updatedActivePlayers = [...state.activePlayers ?? []];
    List<Player> updatedInactivePlayers = [...state.inactivePlayers ?? []];
    if (state.isAllSelected!) {
      updatedPlayers = [];
      updatedActivePlayers = [];
      updatedInactivePlayers = [];
    } else {
      // Filter out selected players and create new lists
      updatedActivePlayers = updatedActivePlayers.where((player) => !player.isSelected).toList();
      updatedInactivePlayers = updatedInactivePlayers.where((player) => !player.isSelected).toList();

      // Combine the unselected players into one list
      updatedPlayers
        ..addAll(updatedActivePlayers)
        ..addAll(updatedInactivePlayers);
    }

    final failureOrPlayerList = await updatePlayersListUseCase(UpdatePlayerListUsecaseParams(players: updatedPlayers));

    failureOrPlayerList.fold(
        (failure) => emit(
              PlayerListState(status: PlayerListStatus.error, errorMessage: failure.message),
            ), (players) {
      emit(state.copyWith(
          status: PlayerListStatus.loaded,
          players: [...players],
          activePlayers: updatedActivePlayers,
          inactivePlayers: updatedInactivePlayers,
          playerName: '',
          isDeleteViewPressed: players.isEmpty ? false : true));
      // if (scrollController.hasClients == true) {
      //   scrollController.jumpTo(scrollController.position.maxScrollExtent + 70);
      // }

      // if (scrollController.isAttached == true) {
      //   scrollController.jumpTo(index: lastActiveIndex,);
      // }
      textEditingController.clear();
    });
  }

  void _isInputIsInAppLang(Emitter<PlayerListState> emit) {
    if (state.players != null) {
      /// To limit input to letters and numbers in any language
      if (state.playerName.isNotEmpty) {
        if (RegExp(r'[^\p{L}\p{N}\s]+', unicode: true).hasMatch(state.playerName.trim())) {
          emit(state.copyWith(isInputContainSpecialChar: true));
          return;
        } else {
          emit(state.copyWith(isInputContainSpecialChar: false));
        }

        // /// Detect Special Character
        // if (RegExp(r'[^\p{L}\p{N}\s]+', unicode: true).hasMatch(state.playerName.trim())) {
        //   emit(state.copyWith(isInputContainSpecialChar: true, isInputIsDiffLang: false));
        //   return;
        // } else {
        //   emit(state.copyWith(isInputContainSpecialChar: false));
        // }
        // /// Detect non English Alphabet
        // /// Check for non-ASCII characters (indicating a different language)
        // if (RegExp(r'[^\u0000-\u007F]+').hasMatch(state.playerName.trim())) {
        //   emit(state.copyWith(isInputIsDiffLang: true, isInputContainSpecialChar: false, ));
        //   return;
        // } else {
        //   emit(state.copyWith(isInputIsDiffLang: false));
        // }
        // if (RegExp(r'^[a-zA-Z0-9 ]').hasMatch(state.playerName)) {
        //   emit(state.copyWith(isInputIsInAppLang: true, isInputContainSpecialChar: false));
        // } else {
        //   emit(state.copyWith(isInputIsInAppLang: false, isInputContainSpecialChar: false));
        // }
      } else {
        emit(state.copyWith(isInputContainSpecialChar: false));
      }
    }
  }

  Future<void> _onListHeaderPressed(ListHeaderPressed event, Emitter<PlayerListState> emit) async {
    if (event.isActiveList) {
      await _toggleExpansion(activePlayerListController, state.isActiveListExpanded ?? false, !event.isExpanded, emit);
    } else {
      await _toggleExpansion(inactivePlayerListController, state.isInactiveListExpanded ?? false, !event.isExpanded, emit);
    }
  }

  Future<void> _toggleExpansion(
      ExpandedTileController controller,
      bool currentState,
      bool newExpandedState,
      Emitter<PlayerListState> emit,
      ) async {
    if (newExpandedState) {
       controller.expand();
    } else {
       controller.collapse();
    }

    if (currentState != newExpandedState) {
      emit(state.copyWith(
        isActiveListExpanded: controller == activePlayerListController ? newExpandedState : state.isActiveListExpanded,
        isInactiveListExpanded: controller == inactivePlayerListController ? newExpandedState : state.isInactiveListExpanded,
      ));
    }
  }
}
