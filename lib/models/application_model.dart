// lib/models/application_model.dart
class ApplicationModel {
  final String id;
  final String taskId;
  final String applicantId;
  final String status; // 'Applied', 'Accepted', 'Rejected', etc.

  ApplicationModel({
    required this.id,
    required this.taskId,
    required this.applicantId,
    this.status = 'Applied',
  });

  // Optional map conversion
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskId': taskId,
      'applicantId': applicantId,
      'status': status,
    };
  }

  factory ApplicationModel.fromMap(Map<String, dynamic> m) {
    return ApplicationModel(
      id: m['id'] as String,
      taskId: m['taskId'] as String,
      applicantId: m['applicantId'] as String,
      status: m['status'] as String,
    );
  }
}
