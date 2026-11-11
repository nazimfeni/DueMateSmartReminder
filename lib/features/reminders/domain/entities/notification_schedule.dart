class NotificationSchedule {
  const NotificationSchedule({
    required this.id,
    required this.reminderId,
    required this.daysBefore,
    required this.notificationId,
    this.isActive = true,
  });

  final int id;
  final int reminderId;
  final int daysBefore;
  final int notificationId;
  final bool isActive;

  NotificationSchedule copyWith({
    int? id,
    int? reminderId,
    int? daysBefore,
    int? notificationId,
    bool? isActive,
  }) {
    return NotificationSchedule(
      id: id ?? this.id,
      reminderId: reminderId ?? this.reminderId,
      daysBefore: daysBefore ?? this.daysBefore,
      notificationId: notificationId ?? this.notificationId,
      isActive: isActive ?? this.isActive,
    );
  }
}
