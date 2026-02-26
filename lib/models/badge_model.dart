class BadgeModel {
  final String id;
  final String userId;
  final String taskId;
  final String skill;
  final String verifiedBy;
  final DateTime issuedDate;

  BadgeModel({
    required this.id,
    required this.userId,
    required this.taskId,
    required this.skill,
    required this.verifiedBy,
    required this.issuedDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'taskId': taskId,
      'skill': skill,
      'verifiedBy': verifiedBy,
      'issuedDate': issuedDate.toIso8601String(),
    };
  }

  factory BadgeModel.fromMap(Map<String, dynamic> map) {
    return BadgeModel(
      id: map['id'] as String? ?? '',
      userId: map['userId'] as String? ?? '',
      taskId: map['taskId'] as String? ?? '',
      skill: map['skill'] as String? ?? '',
      verifiedBy: map['verifiedBy'] as String? ?? '',
      issuedDate:
          DateTime.tryParse(map['issuedDate'] as String? ?? '') ?? DateTime.now(),
    );
  }
}
