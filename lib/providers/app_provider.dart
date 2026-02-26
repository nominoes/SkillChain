// lib/providers/app_provider.dart
import 'package:flutter/material.dart';

import '../models/application_model.dart';
import '../models/task_model.dart';

class AppProvider extends ChangeNotifier {
  AppProvider() {
    _seedInitialTasks();
  }

  final List<TaskModel> _tasks = [];
  final List<ApplicationModel> _applications = [];

  List<TaskModel> get tasks => List.unmodifiable(_tasks);
  List<ApplicationModel> get applications => List.unmodifiable(_applications);

  void _seedInitialTasks() {
    _tasks.addAll([
      TaskModel(
        id: 'task_1',
        title: 'Design Instagram Post',
        description:
            'Create a promotional Instagram post for a startup launch campaign.',
        skillRequired: 'Canva / Design',
        hours: 2,
        postedBy: 'u_startup_1',
      ),
      TaskModel(
        id: 'task_2',
        title: 'Build Login UI',
        description: 'Implement a responsive Flutter login screen for mobile.',
        skillRequired: 'Flutter',
        hours: 3,
        postedBy: 'u_startup_1',
      ),
      TaskModel(
        id: 'task_3',
        title: 'Write Product Announcement',
        description:
            'Write a 500-word product launch announcement blog post for our website.',
        skillRequired: 'Content Writing',
        hours: 2,
        postedBy: 'u_startup_1',
      ),
    ]);
  }

  void addTask(TaskModel task) {
    _tasks.add(task);
    notifyListeners();
  }

  void applyToTask(ApplicationModel application) {
    final alreadyApplied = _applications.any(
      (a) =>
          a.taskId == application.taskId &&
          a.applicantId == application.applicantId,
    );
    if (alreadyApplied) {
      return;
    }

    _applications.add(application);
    notifyListeners();
  }

  List<ApplicationModel> getApplicationsForTask(String taskId) {
    return _applications.where((a) => a.taskId == taskId).toList();
  }

  ApplicationModel? getApplication(String taskId, String applicantId) {
    for (final application in _applications) {
      if (application.taskId == taskId &&
          application.applicantId == applicantId) {
        return application;
      }
    }
    return null;
  }

  void selectApplicant(String taskId, String applicantId) {
    for (final application in _applications.where((a) => a.taskId == taskId)) {
      application.status =
          application.applicantId == applicantId ? 'selected' : 'rejected';
    }
    updateTaskStatus(taskId, 'Assigned', notify: false);
    notifyListeners();
  }

  void submitWork({
    required String taskId,
    required String applicantId,
    required String submissionLink,
  }) {
    final app = getApplication(taskId, applicantId);
    if (app == null) return;

    app.status = 'submitted';
    app.submissionLink = submissionLink;
    updateTaskStatus(taskId, 'Submitted', notify: false);
    notifyListeners();
  }

  void approveSubmission({
    required String taskId,
    required String applicantId,
    String feedback = 'Approved by startup',
  }) {
    final app = getApplication(taskId, applicantId);
    if (app == null) return;

    app.status = 'approved';
    app.feedback = feedback;
    updateTaskStatus(taskId, 'Verified', notify: false);
    notifyListeners();
  }

  void rejectApplication({
    required String taskId,
    required String applicantId,
    String feedback = 'Not selected',
  }) {
    final app = getApplication(taskId, applicantId);
    if (app == null) return;

    app.status = 'rejected';
    app.feedback = feedback;
    notifyListeners();
  }

  void updateTaskStatus(String taskId, String status, {bool notify = true}) {
  void updateTaskStatus(String taskId, String status) {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index != -1) {
      _tasks[index].status = status;
      if (notify) {
        notifyListeners();
      }
    }
  }
}
