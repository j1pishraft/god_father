part of 'side_drawer_bloc.dart';

abstract class SideDrawerEvent extends Equatable {
  const SideDrawerEvent();

  @override
  List<Object> get props => [];
}

class SideMenuPagePressed extends SideDrawerEvent {
  const SideMenuPagePressed({required this.pageEnum});
  final PageEnum pageEnum;

  @override
  List<Object> get props => [pageEnum];
}
