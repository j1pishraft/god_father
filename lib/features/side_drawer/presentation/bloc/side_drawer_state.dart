part of 'side_drawer_bloc.dart';

enum PlayerListStatus {
  initial,
  loading,
  loaded,
  error,
}

class SideDrawerState extends Equatable {
  const SideDrawerState({
    this.status = PlayerListStatus.initial,
    this.sideSelectedPageEnum = PageEnum.home,
  });

  final PlayerListStatus status;
  final PageEnum sideSelectedPageEnum;



  SideDrawerState copyWith({
    PageEnum? sideSelectedPageEnum,
    PlayerListStatus? status,
  }) {
    return SideDrawerState(
      sideSelectedPageEnum: sideSelectedPageEnum ?? this.sideSelectedPageEnum,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status, sideSelectedPageEnum];
}
