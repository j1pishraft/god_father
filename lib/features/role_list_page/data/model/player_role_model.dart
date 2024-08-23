import '../../domain/entities/player_role_entity.dart';

//ignore: must_be_immutable
class PlayerRoleModel extends PlayerRole {
  // final String? roleName;
  // final String? newDescription;
  // final int? newCategory;
  // final bool? newCanWakeupAtNight;
  // final int? newWakeupPriority;
  // final bool? newIsActive;
  // final bool? newIsSelected;
  // final bool? newIsCommonRole;
  // final int? newCount;

  const PlayerRoleModel({
    super.roleName,
    super.description,
    super.category,
    super.canWakeupAtNight,
    super.wakeupPriority,
    super.isActive,
    super.isSelected,
    super.isCommonRole,
    super.count,
  });

  factory PlayerRoleModel.fromJson(Map<String, dynamic> json) {
    return PlayerRoleModel(
      roleName: json['roleName'],
      description: json['description'],
      category: json['category'],
      canWakeupAtNight: json['canWakeupAtNight'],
      wakeupPriority: json['wakeupPriority'],
      isActive: json['isActive'] ?? false,
      isSelected: json['isSelected'] ?? false,
      isCommonRole: json['isCommonRole'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roleName': roleName,
      'description': description,
      'category': category,
      'canWakeupAtNight': canWakeupAtNight,
      'wakeupPriority': wakeupPriority,
      'isActive': isActive,
      'isSelected': isSelected,
      'isCommonRole': isCommonRole,
      'count': count,
    };
  }



  @override
  List<Object?> get props => [
        ...super.props
      ];
}
// ignore: must_be_immutable
// class PlayerRoleModel extends PlayerRole {
//   final String? newRoleName;
//   final String? newDescription;
//   final int? newCategory;
//   final bool? newCanWakeupAtNight;
//   final int? newWakeupPriority;
//   final bool? newIsActive;
//   final bool? newIsSelected;
//   final bool? newIsCommonRole;
//   final int? newCount;
//
//   PlayerRoleModel(
//       {this.newRoleName,
//         this.newDescription,
//         this.newCategory,
//         this.newCanWakeupAtNight,
//         this.newWakeupPriority,
//         this.newIsActive,
//         this.newIsSelected,
//         this.newIsCommonRole,
//         this.newCount})
//       : super(
//       roleName: newRoleName,
//       description: newDescription,
//       category: newCategory,
//       canWakeupAtNight: newCanWakeupAtNight,
//       wakeupPriority: newWakeupPriority,
//       isActive: newIsActive,
//       isSelected: newIsSelected,
//       isCommonRole: newIsCommonRole,
//       count: newCount);
//
//   factory PlayerRoleModel.fromJson(Map<String, dynamic> json) {
//     return PlayerRoleModel(
//         newRoleName: json['roleName'],
//         newDescription: json['description'],
//         newCategory: json['category'],
//         newCanWakeupAtNight: json['canWakeupAtNight'],
//         newWakeupPriority: json['wakeupPriority'],
//         newIsActive: json['isActive'] ?? false,
//         newIsSelected: json['isSelected'] ?? false,
//         newIsCommonRole: json['isCommonRole'],
//         newCount: json['count']);
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'roleName': newRoleName,
//       'description': newDescription,
//       'category': newCategory,
//       'canWakeupAtNight': newCanWakeupAtNight,
//       'wakeupPriority': newWakeupPriority,
//       'isActive': newIsActive,
//       'isSelected': newIsSelected,
//       'isCommonRole': newIsCommonRole,
//       'count': newCount,
//     };
//   }
//
//   @override
//   PlayerRoleModel copyWith({
//     String? roleName,
//     String? description,
//     int? category,
//     bool? canWakeupAtNight,
//     int? wakeupPriority,
//     bool? isActive,
//     bool? isSelected,
//     bool? isCommonRole,
//     count,
//   }) {
//     return PlayerRoleModel(
//       newRoleName: roleName ?? newRoleName,
//       newDescription: description ?? newDescription,
//       newCategory: category ?? newCategory,
//       newCanWakeupAtNight: canWakeupAtNight ?? newCanWakeupAtNight,
//       newWakeupPriority: wakeupPriority ?? newWakeupPriority,
//       newIsActive: isActive ?? newIsActive,
//       newIsSelected: isSelected ?? newIsSelected,
//       newIsCommonRole: isCommonRole ?? newIsCommonRole,
//       newCount: count ?? newCount,
//     );
//   }
//
//   @override
//   List<Object?> get props => [
//     newRoleName,
//     newDescription,
//     newCategory,
//     newCanWakeupAtNight,
//     newWakeupPriority,
//     newIsActive,
//     newIsSelected,
//     newIsCommonRole,
//     newCount
//   ];
// }