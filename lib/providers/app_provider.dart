// lib/providers/app_provider.dart
import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../models/application_model.dart';

class AppProvider extends ChangeNotifier {
  final List<TaskModel> _tasks = [];
  final List<ApplicationModel> _applications = [];

  List<TaskModel> get tasks => List.unmodifiable(_tasks);
  List<ApplicationModel> get applications => List.unmodifiable(_applications);

  void addTask(TaskModel task) {
    _tasks.add(task);
    notifyListeners();
  }

  void applyToTask(ApplicationModel application) {
    _applications.add(application);
    notifyListeners();
  }

  /// Returns all applications for a specific task.
  List<ApplicationModel> getApplicationsForTask(String taskId) {
    return _applications.where((a) => a.taskId == taskId).toList();
  }

  /// Updates the status of a task (e.g. to 'Assigned' or 'Completed').
  void updateTaskStatus(String taskId, String status) {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index != -1) {
      _tasks[index].status = status;
      notifyListeners();
    }
  }
}
