// lib/models/task_model.dart
class TaskModel {
  final String id;
  final String title;
  final String description;
  final String skillRequired;
  final int hours;
  final String postedBy; // user ID of the startup who posted
  String status;         // e.g. 'Open', 'Assigned', 'Completed'

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.skillRequired,
    required this.hours,
    required this.postedBy,
    this.status = 'Open',
  });

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
      id: m['id'] as String,
      title: m['title'] as String,
      description: m['description'] as String,
      skillRequired: m['skillRequired'] as String,
      hours: m['hours'] as int,
      postedBy: m['postedBy'] as String,
      status: m['status'] as String,
    );
  }
}
