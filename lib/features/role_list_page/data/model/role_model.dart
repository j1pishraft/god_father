
import '../../domain/entities/role_entity.dart';

class RoleModel extends Role {
  @override
  final String roleName;
  @override
  final String description;
  @override
  final bool isActive;

   const RoleModel({
    required this.roleName,
    required this.description,
    this.isActive = true,
  }) : super.withRole(roleName: roleName, description: description, isActive: isActive);

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(roleName: json['roleName'], description: json['description'], isActive: json['isActive']);
  }

  Map<String, dynamic> toJson() => {
        'roleName': roleName,
        'description': description,
        'isActive': isActive,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [roleName, description, isActive];
}
