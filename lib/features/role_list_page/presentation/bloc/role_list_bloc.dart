import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'role_list_event.dart';
part 'role_list_state.dart';

class RoleListBloc extends Bloc<RoleListEvent, RoleListState> {
  RoleListBloc() : super(const RoleListState()) {
    on<RoleListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
