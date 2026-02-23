// lib/services/firestore_service.dart
import 'dart:async';
import '../models/task_model.dart';

class FirestoreService {
  Future<List<TaskModel>> getMockTasks() async {
    await Future.delayed(const Duration(milliseconds: 450));
    return [
      TaskModel(
        id: '1',
        title: 'Design Instagram Post',
        description: 'Create a promotional Instagram post for the startup using Canva.',
        skillRequired: 'Design',
        hours: 2,
      ),
      TaskModel(
        id: '2',
        title: 'Build Login UI',
        description: 'Create a responsive login screen using Flutter (mobile + web).',
        skillRequired: 'Flutter',
        hours: 3,
      ),
      TaskModel(
        id: '3',
        title: 'Write Blog Post',
        description: 'Write a 500-word blog post about micro-internships and their benefits.',
        skillRequired: 'Content Writing',
        hours: 1,
      ),
    ];
  }
}