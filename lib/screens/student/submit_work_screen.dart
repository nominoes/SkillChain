// lib/screens/student/submit_work_screen.dart
import 'package:flutter/material.dart';
import '../../models/task_model.dart';

class SubmitWorkScreen extends StatefulWidget {
  final TaskModel task;
  const SubmitWorkScreen({super.key, required this.task});

  @override
  State<SubmitWorkScreen> createState() => _SubmitWorkScreenState();
}

class _SubmitWorkScreenState extends State<SubmitWorkScreen> {
  final TextEditingController _linkCtrl = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _linkCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_linkCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter link or description')));
      return;
    }
    setState(() => _submitting = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _submitting = false);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Submitted successfully (mock)')));
    // Go back to dashboard home (demo behavior)
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Work')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Text('Submitting for: ${widget.task.title}', style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          TextField(
            controller: _linkCtrl,
            maxLines: 5,
            decoration: const InputDecoration(hintText: 'Paste your work link / description'),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitting ? null : _submit,
              child: _submitting ? const CircularProgressIndicator(color: Colors.white) : const Text('Submit'),
            ),
          )
        ]),
      ),
    );
  }
}