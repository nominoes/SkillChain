class BadgeModel {
  final String id;
  final String skill;
  final String verifiedBy;
  final DateTime issuedDate;

  BadgeModel({
    required this.id,
    required this.skill,
    required this.verifiedBy,
    required this.issuedDate,
  });
}