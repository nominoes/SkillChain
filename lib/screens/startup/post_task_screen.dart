// lib/screens/startup/post_task_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/task_model.dart';

class PostTaskScreen extends StatefulWidget {
  const PostTaskScreen({super.key});

  @override
  State<PostTaskScreen> createState() => _PostTaskScreenState();
}

class _PostTaskScreenState extends State<PostTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _skillCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _hoursCtrl = TextEditingController();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _skillCtrl.dispose();
    _descCtrl.dispose();
    _hoursCtrl.dispose();
    super.dispose();
  }

  void _postTask() {
    if (!_formKey.currentState!.validate()) return;
    final user = context.read<AuthProvider>().currentUser!;
    final task = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleCtrl.text,
      description: _descCtrl.text,
      skillRequired: _skillCtrl.text,
      hours: int.tryParse(_hoursCtrl.text) ?? 1,
      postedBy: user.id,
      status: 'Open',
    );
    context.read<AppProvider>().addTask(task);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post New Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(hintText: 'Task Title'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Enter title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _skillCtrl,
                decoration: const InputDecoration(hintText: 'Skill Required'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Enter required skill';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(hintText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _hoursCtrl,
                decoration: const InputDecoration(hintText: 'Estimated Hours'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Enter hours';
                  }
                  if (int.tryParse(v) == null) {
                    return 'Enter a number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _postTask,
                  child: const Text('Post Task'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
