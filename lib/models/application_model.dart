// lib/models/application_model.dart
class ApplicationModel {
  final String id;
  final String taskId;
  final String applicantId;
  String status; // applied | selected | submitted | approved | rejected
  String submissionLink;
  String feedback;

  ApplicationModel({
    required this.id,
    required this.taskId,
    required this.applicantId,
    this.status = 'applied',
    this.submissionLink = '',
    this.feedback = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskId': taskId,
      'applicantId': applicantId,
      'status': status,
      'submissionLink': submissionLink,
      'feedback': feedback,
    };
  }

  factory ApplicationModel.fromMap(Map<String, dynamic> m) {
    return ApplicationModel(
      id: m['id'] as String? ?? '',
      taskId: m['taskId'] as String? ?? '',
      applicantId: m['applicantId'] as String? ?? '',
      status: m['status'] as String? ?? 'applied',
      submissionLink: m['submissionLink'] as String? ?? '',
      feedback: m['feedback'] as String? ?? '',
    );
  }
}
