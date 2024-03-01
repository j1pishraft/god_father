import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:god_father/enums/page_enum.dart';
import 'package:god_father/features/player_list_page/presentation/pages/player_list_page.dart';
import 'package:god_father/features/setting_page/presentation/pages/setting_page.dart';
import 'package:inner_drawer/inner_drawer.dart';


part 'side_drawer_event.dart';
part 'side_drawer_state.dart';

class SideDrawerBloc extends Bloc<SideDrawerEvent, SideDrawerState> {
  SideDrawerBloc() : super(const SideDrawerState()) {
    on<SideMenuPagePressed>(_onSideMenuPagePressed);
  }



  FutureOr<void> _onSideMenuPagePressed(SideMenuPagePressed event, Emitter<SideDrawerState> emit) {
    // emit(state.copyWith(status: PlayerListStatus.loading));
    // final players = await getPlayersListUsecase(NoParams());
    emit(state.copyWith(sideSelectedPageEnum: event.pageEnum));
  }
}
