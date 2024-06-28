import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/player_entity.dart';
import '../../domain/usecases/clear_player_list_usecase.dart';
import '../../domain/usecases/get_players_list_usecase.dart';
import '../../domain/usecases/update_players_list_usecase.dart';

part 'player_list_event.dart';

part 'player_list_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
const String invalidInputFailureMessage = 'Invalid Input - the number must be a positive number or zero.';

class PlayerListBloc extends Bloc<PlayerListEvent, PlayerListState> {
  final GetPlayersListUsecase getPlayersListUseCase;
  final UpdatePlayersListUsecase updatePlayersListUseCase;
  final ClearPlayersListUsecase clearPlayersListUseCase;

  TextEditingController textEditingController = TextEditingController();
  ItemScrollController scrollController = ItemScrollController();
  FocusNode focusNode = FocusNode();

  PlayerListBloc({required this.clearPlayersListUseCase, required this.getPlayersListUseCase, required this.updatePlayersListUseCase}) : super(const PlayerListState()) {
    on<PlayerListStarted>(_onPlayersFetched);
    on<PlayerListAddPressed>(_onPlayerAdded);
    on<PlayerListNameChanged>(_onPlayerNameChanged);
    on<PlayerListClearPressed>(_onPlayerListClearPressed);
    on<PlayerListDeleteViewButtonPressed>(_onPlayerListDeleteViewButtonPressed);
    on<PlayerListDeActiveSelected>(_onPlayerListDeActiveSelected);
    on<PlayerListSelectAllPressed>(_onPlayerListSelectAllPressed);
    on<PlayerSelectedInDeleteView>(_onPlayerSelectedInDeleteView);
    on<PlayerListDeleteSelectedPlayersPressed>(_onPlayerListDeleteSelectedPlayersPressed);
  }

  FutureOr<void> _onPlayersFetched(PlayerListStarted event, Emitter<PlayerListState> emit) async {
    debugPrint("List Length${state.players?.length}");

    emit(state.copyWith(status: PlayerListStatus.loading));
    final players = await getPlayersListUseCase(NoParams());
    emit(state.copyWith(status: PlayerListStatus.loaded, players: players, isAllSelected: _isAllSelected(players)));
  }

  bool _isAllSelected(List<Player>? players) {
    if ((players?.isEmpty ?? true) || (players?.any((element) => element.isSelected == false) ?? false)) {
      return false;
    }
    return true;
  }

  FutureOr<void> _onPlayerAdded(PlayerListAddPressed event, Emitter<PlayerListState> emit) async {
    if (state.playerName.isNotEmpty) {
      // emit(const PlayerListState(status: PlayerListStatus.loading));

      emit(state.copyWith(status: PlayerListStatus.loading));
      debugPrint("_onPlayerAdded player name${state.playerName}");

      final player = Player.withName(name: state.playerName);
      debugPrint("${state.players}");
      debugPrint("_onPlayerAdded player name${state.playerName}");
      //  List<Player> currentList = List.from(state.players ?? []) ;
      // final newList = [...currentList, player];

      List<Player> currentList = state.players ?? [];
      // Find the last player with isActive == true
      int lastActiveIndex = currentList.lastIndexWhere((player) => player.isActive);
      // Check if the list is empty
      if (currentList.isEmpty) {
        currentList.add(player);
      } else {

        // int lastIndex = currentList.lastIndexWhere((player) => player.isActive);

        // Add new player after the last active player or to the top if no active player found
        if (lastActiveIndex != -1) {
          currentList.insert(lastActiveIndex + 1, player);
        } else {
          currentList.insert(0, player);
        }
      }

      final failureOrPlayerList = await updatePlayersListUseCase(UpdatePlayersListUsecaseParams(players: currentList));

      failureOrPlayerList.fold(
        (failure) => emit(PlayerListState(status: PlayerListStatus.error, errorMessage: failure.message)),
        (players) {
          emit(state.copyWith(status: PlayerListStatus.loaded, players: players, playerName: '', isAllSelected: _isAllSelected(players)));
          if (scrollController.isAttached == true) {
            scrollController.jumpTo(index: lastActiveIndex,);
          }
          textEditingController.clear();
        },
      );
    }
  }

  FutureOr<void> _onPlayerNameChanged(PlayerListNameChanged event, Emitter<PlayerListState> emit) {
    // if(focusNode.hasFocus){
    //   scrollController.jumpTo(scrollController.position.maxScrollExtent +70);
    // }
    textEditingController.text = event.playerName;
    emit(state.copyWith(playerName: event.playerName));
    _isPlayerNameDuplicated(emit);
  }

  FutureOr<void> _isPlayerNameDuplicated(emit) {
    if (state.players != null) {
      if (state.players!.any((player) => player.name.toLowerCase().trim() == state.playerName.toLowerCase().trim())) {
        emit(state.copyWith(isNameDuplicated: true));
      }
    }

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
  }

  FutureOr<void> _onPlayerListClearPressed(PlayerListClearPressed event, Emitter<PlayerListState> emit) async {
    emit(state.copyWith(status: PlayerListStatus.loading));
    final failureOrCleared = await clearPlayersListUseCase(NoParams());
    failureOrCleared.fold((failure) => emit(state.copyWith(status: PlayerListStatus.error, errorMessage: failure.message)), (isCleared) {
      emit(state.copyWith(status: PlayerListStatus.loaded, players: [], isAllSelected: false));
    });
  }

  FutureOr<void> _onPlayerListDeleteViewButtonPressed(PlayerListDeleteViewButtonPressed event, Emitter<PlayerListState> emit) {
    bool isDeleteViewPressed = !state.isDeleteViewPressed! ?? false;
    List<Player> updatedPlayers = [];
    if (isDeleteViewPressed) {
      updatedPlayers = state.players!.map((player) {
        return player.copyWith(isSelected: false);
      }).toList();
      emit(state.copyWith(isDeleteViewPressed: isDeleteViewPressed, players: updatedPlayers, isAllSelected: _isAllSelected(updatedPlayers)));
    } else {
      emit(state.copyWith(
        isDeleteViewPressed: isDeleteViewPressed,
      ));
    }
  }

  FutureOr<void> _onPlayerListDeActiveSelected(PlayerListDeActiveSelected event, Emitter<PlayerListState> emit) async {
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

    final List<Player> updatedPlayers = state.players!.map((player) {
      return player.name == event.player?.name ? player.copyWith(isActive: !player.isActive) : player;
    }).toList();



    final int index = updatedPlayers.indexWhere((player) => player.name == event.player?.name);

    if (index != -1 ) {
      // Player found in the list, remove and add to the last index
      if((index == updatedPlayers.length -1 || updatedPlayers[index+1].isActive == false) && (index == 0 || updatedPlayers[index-1].isActive == true)){

      }else {
        final Player playerToMove = updatedPlayers.removeAt(index);
        if (playerToMove.isActive == false) {
          updatedPlayers.add(playerToMove.copyWith(isActive: playerToMove.isActive));
        } else {
          updatedPlayers.insert(0, playerToMove.copyWith(isActive: playerToMove.isActive));
        }
      }
    }

    final failureOrPlayerList = await updatePlayersListUseCase(UpdatePlayersListUsecaseParams(players: updatedPlayers));

    failureOrPlayerList.fold(
      (failure) => emit(PlayerListState(status: PlayerListStatus.error, errorMessage: failure.message)),
      (players) {
        emit(state.copyWith(status: PlayerListStatus.loaded, players: players));
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

    List<Player> updatedPlayers = [...state.players ?? []];

    updatedPlayers = updatedPlayers.map((player) {
      return player.name == event.player?.name ? player.copyWith(isSelected: !player.isSelected) : player;
    }).toList();




    emit(state.copyWith(players: updatedPlayers, isAllSelected: _isAllSelected(updatedPlayers)));

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
    List<Player> tempList = [...state.players ?? []];
    tempList = tempList.map((s) => s.copyWith(isSelected: event.isSelected)).toList();

    emit(state.copyWith(players: tempList, isAllSelected: event.isSelected));
  }

  FutureOr<void> _onPlayerListDeleteSelectedPlayersPressed(PlayerListDeleteSelectedPlayersPressed event, Emitter<PlayerListState> emit) async {
    // emit(state.copyWith(players: []));

    List<Player> playersWithSelectedFalse = state.players?.where((player) => !player.isSelected).toList() ?? [];

    final failureOrPlayerList = await updatePlayersListUseCase(UpdatePlayersListUsecaseParams(players: playersWithSelectedFalse));

    failureOrPlayerList.fold(
        (failure) => emit(
              PlayerListState(status: PlayerListStatus.error, errorMessage: failure.message),
            ), (players) {
      emit(state.copyWith(status: PlayerListStatus.loaded, players: [...players], playerName: '', isDeleteViewPressed: players.isEmpty ? false : true));
      // if (scrollController.hasClients == true) {
      //   scrollController.jumpTo(scrollController.position.maxScrollExtent + 70);
      // }

      // if (scrollController.isAttached == true) {
      //   scrollController.jumpTo(index: lastActiveIndex,);
      // }
      textEditingController.clear();
    });
  }
}
