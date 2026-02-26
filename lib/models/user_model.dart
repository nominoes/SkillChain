// lib/models/user_model.dart
class UserModel {
  final String id;
  final String name;
  final String email;
  final String role; // 'student' | 'startup' | 'admin'

  UserModel({
    required this.id,
    this.name = '',
    required this.email,
    required this.role,
  });

  // Optional: create from a map (e.g., from a database or service)
  factory UserModel.fromMap(Map<String, dynamic> m) {
    return UserModel(
      id: m['id'] as String? ?? '',
      name: m['name'] as String? ?? '',
      email: m['email'] as String? ?? '',
      role: m['role'] as String? ?? 'student',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
    };
  }
}
