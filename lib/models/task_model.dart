class TaskModel {
  final String id;
  final String title;
  final String description;
  final String skillRequired;
  final int hours;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.skillRequired,
    required this.hours,
  });
}