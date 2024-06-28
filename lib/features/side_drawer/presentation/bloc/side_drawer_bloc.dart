import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:god_father/enums/page_enum.dart';


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
