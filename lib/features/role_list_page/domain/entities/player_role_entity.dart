import 'package:equatable/equatable.dart';

class PlayerRole extends Equatable {
  final String? roleName;
  final String? description;
  final int? category;
  final bool? canWakeupAtNight;
  final int? wakeupPriority;
  final bool? isActive;
  final bool? isSelected;
  final bool? isCommonRole;
  final int? count;

  const PlayerRole({
    this.roleName,
    this.description,
    this.category,
    this.canWakeupAtNight,
    this.wakeupPriority,
    this.isSelected,
    this.isActive,
    this.isCommonRole,
    this.count,
  });

  PlayerRole copyWith({
    String? roleName,
    String? description,
    int? category,
    bool? canWakeupAtNight,
    int? wakeupPriority,
    bool? isActive,
    bool? isSelected,
    bool? isCommonRole,
    int? count,
  }) {
    return PlayerRole(
        roleName: roleName ?? this.roleName,
        description: description ?? this.description,
        category: category ?? this.category,
        canWakeupAtNight: canWakeupAtNight ?? this.canWakeupAtNight,
        wakeupPriority: wakeupPriority ?? this.wakeupPriority,
        isActive: isActive ?? this.isActive,
        isSelected: isSelected ?? this.isSelected,
        isCommonRole: isCommonRole ?? this.isCommonRole,
        count: count ?? this.count);
  }

  PlayerRole withName({
    String? roleName,
    String? description,
    int? category,
    bool? canWakeupAtNight,
    int? wakeupPriority,
    bool? isActive,
    bool? isSelected,
    bool? isCommonRole,
    count,
  }) {
    return PlayerRole(
        roleName: roleName ?? this.roleName,
        description: description ?? this.description,
        category: category ?? this.category,
        canWakeupAtNight: canWakeupAtNight ?? this.canWakeupAtNight,
        wakeupPriority: wakeupPriority ?? this.wakeupPriority,
        isActive: isActive ?? this.isActive,
        isSelected: isSelected ?? this.isSelected,
        isCommonRole: isCommonRole,
        count: count ?? this.count);
  }

  @override
  List<Object?> get props =>
      [roleName, description, category, canWakeupAtNight, wakeupPriority, isActive, isSelected, isCommonRole, count];
}
