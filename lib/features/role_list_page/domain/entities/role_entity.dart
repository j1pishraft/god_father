import 'package:equatable/equatable.dart';


class Role extends Equatable {
  final String roleName;
  final String description;
  final bool isActive;
  final bool isSelected;

   const Role({required this.isSelected, required this.roleName, required this.description, required this.isActive});

  const Role.withName({
    required this.roleName,
    this.description = '',
    this.isActive = true,
    this.isSelected = false,
  });

  const Role.withRole({
    required this.roleName,
    required this.description,
    this.isActive = true,
    this.isSelected = false,
  });

  const Role.withIsActive({
    this.roleName = '',
    this.description = '',
    required this.isActive,
    this.isSelected = false,
  });


  Role copyWith({
    bool? isActive,
    bool? isSelected,
  }) {
    return Role(
      roleName: roleName,
      description: description,
      isActive: isActive ?? this.isActive,
      isSelected: isSelected ?? this.isSelected,
    );
  }
  @override
  List<Object?> get props => [roleName, description, isActive, isSelected];

}
