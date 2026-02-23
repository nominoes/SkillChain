import 'package:flutter/material.dart';

class PostTaskScreen extends StatefulWidget {
  const PostTaskScreen({super.key});

  @override
  State<PostTaskScreen> createState() => _PostTaskScreenState();
}

class _PostTaskScreenState extends State<PostTaskScreen> {
  final _title = TextEditingController();
  final _skill = TextEditingController();
  final _hours = TextEditingController();
  final _desc = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _skill.dispose();
    _hours.dispose();
    _desc.dispose();
    super.dispose();
  }

  void _postTask() {
    if (_title.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter task title')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Task Posted (mock)')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _title,
              decoration: const InputDecoration(hintText: 'Task Title'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _skill,
              decoration: const InputDecoration(hintText: 'Required Skill'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _hours,
              decoration: const InputDecoration(hintText: 'Estimated Hours'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _desc,
              maxLines: 4,
              decoration: const InputDecoration(hintText: 'Task Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _postTask,
              child: const Text('Post Task'),
            ),
          ],
        ),
      ),
    );
  }
}