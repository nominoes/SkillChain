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
}
