import 'package:equatable/equatable.dart';


class Player extends Equatable {
  final String name;
  final String role;
  final bool isActive;
  final bool isSelected;

   const Player({required this.isSelected, required this.name, required this.role, required this.isActive});

  const Player.withName({
    required this.name,
    this.role = '',
    this.isActive = true,
    this.isSelected = false,
  });

  const Player.withRole({
    required this.name,
    required this.role,
    this.isActive = true,
    this.isSelected = false,
  });

  const Player.withIsActive({
    this.name = '',
    this.role = '',
    required this.isActive,
    this.isSelected = false,
  });


  Player copyWith({
    bool? isActive,
    bool? isSelected,
  }) {
    return Player(
      name:name,
      role:role,
      isActive: isActive ?? this.isActive,
      isSelected: isSelected ?? this.isSelected,
    );
  }
  @override
  List<Object?> get props => [name, role, isActive, isSelected];


}
