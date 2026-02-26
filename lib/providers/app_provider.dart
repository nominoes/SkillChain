// lib/providers/app_provider.dart
import 'package:flutter/material.dart';

import 'package:skillchain/models/application_model.dart';
import 'package:skillchain/models/badge_model.dart';
import 'package:skillchain/models/task_model.dart';

class AppProvider extends ChangeNotifier {
  static const String taskOpen = 'Open';
  static const String taskAssigned = 'Assigned';
  static const String taskSubmitted = 'Submitted';
  static const String taskVerified = 'Verified';

  static const String appApplied = 'applied';
  static const String appSelected = 'selected';
  static const String appSubmitted = 'submitted';
  static const String appApproved = 'approved';
  static const String appRejected = 'rejected';

  AppProvider() {
    _seedInitialTasks();
  }

  final List<TaskModel> _tasks = [];
  final List<ApplicationModel> _applications = [];
  final List<BadgeModel> _badges = [];
  final Map<String, int> _reputation = {};

  List<TaskModel> get tasks => List.unmodifiable(_tasks);
  List<ApplicationModel> get applications => List.unmodifiable(_applications);
  List<BadgeModel> get badges => List.unmodifiable(_badges);

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
          application.applicantId == applicantId ? appSelected : appRejected;
    }
    _updateTaskStatus(taskId, taskAssigned, notify: false);
    notifyListeners();
  }

  void submitWork({
    required String taskId,
    required String applicantId,
    required String submissionLink,
  }) {
    final app = getApplication(taskId, applicantId);
    if (app == null) return;

    app.status = appSubmitted;
    app.submissionLink = submissionLink;
    _updateTaskStatus(taskId, taskSubmitted, notify: false);
    notifyListeners();
  }

  void approveSubmission({
    required String taskId,
    required String applicantId,
    String feedback = 'Approved by startup',
  }) {
    final app = getApplication(taskId, applicantId);
    final task = _taskById(taskId);
    if (app == null || task == null) return;

    app.status = appApproved;
    app.feedback = feedback;
    _updateTaskStatus(taskId, taskVerified, notify: false);

    final alreadyAwarded = _badges.any(
      (badge) => badge.userId == applicantId && badge.taskId == taskId,
    );

    if (!alreadyAwarded) {
      _badges.add(
        BadgeModel(
          id: 'badge_${DateTime.now().millisecondsSinceEpoch}',
          userId: applicantId,
          taskId: taskId,
          skill: task.skillRequired,
          verifiedBy: task.postedBy,
          issuedDate: DateTime.now(),
        ),
      );
      _reputation[applicantId] = (_reputation[applicantId] ?? 0) + 10;
    }

    notifyListeners();
  }

  void rejectApplication({
    required String taskId,
    required String applicantId,
    String feedback = 'Not selected',
  }) {
    final app = getApplication(taskId, applicantId);
    if (app == null) return;

    app.status = appRejected;
    app.feedback = feedback;
    notifyListeners();
  }

  int getReputationForUser(String userId) => _reputation[userId] ?? 0;

  List<BadgeModel> getBadgesForUser(String userId) {
    return _badges.where((badge) => badge.userId == userId).toList();
  }

  List<ApplicationModel> get approvedApplications {
    return _applications.where((a) => a.status == appApproved).toList();
  }

  TaskModel? _taskById(String taskId) {
    for (final task in _tasks) {
      if (task.id == taskId) return task;
    }
    return null;
  }

  void _updateTaskStatus(String taskId, String status, {bool notify = true}) {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index != -1) {
      _tasks[index].status = status;
      if (notify) {
        notifyListeners();
      }
    }
  }
}
