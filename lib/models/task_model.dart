// lib/models/task_model.dart
class TaskModel {
  final String id;
  final String title;
  final String description;
  final String skillRequired;
  final int hours;
  final String postedBy; // user ID of the startup who posted
  String status; // e.g. 'Open', 'Assigned', 'Completed'

  /// Backward-compatible constructor:
  /// - prefer [skillRequired], but old callsites can still pass [skill]
  /// - [postedBy] defaults to empty string for older mock callsites
  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    String? skillRequired,
    String? skill,
    required this.hours,
    this.postedBy = '',
    this.status = 'Open',
  }) : skillRequired = skillRequired ?? skill ?? '';

  /// Backward-compatible alias used by older UI code.
  String get skill => skillRequired;

  // Optional: toMap/fromMap if using a database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'skillRequired': skillRequired,
      'hours': hours,
      'postedBy': postedBy,
      'status': status,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> m) {
    return TaskModel(
      id: m['id'] as String? ?? '',
      title: m['title'] as String? ?? '',
      description: m['description'] as String? ?? '',
      skillRequired:
          (m['skillRequired'] ?? m['skill'] ?? '') as String,
      hours: (m['hours'] as num?)?.toInt() ?? 0,
      postedBy: m['postedBy'] as String? ?? '',
      status: m['status'] as String? ?? 'Open',
    );
  }
}
