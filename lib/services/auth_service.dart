import '../models/user_model.dart';

class AuthService {
  static final Map<String, Map<String, String>> _users = {
    'student@skillchain.com': {
      'id': 'u_student_1',
      'name': 'Anjali Sharma',
      'password': '1234',
      'role': 'student',
    },
    'startup@skillchain.com': {
      'id': 'u_startup_1',
      'name': 'TechStart Co.',
      'password': '1234',
      'role': 'startup',
    },
    'admin@skillchain.com': {
      'id': 'u_admin_1',
      'name': 'SkillChain Admin',
      'password': '1234',
      'role': 'admin',
    },
  };

  UserModel? login(String email, String password) {
    final normalizedEmail = email.trim().toLowerCase();
    final user = _users[normalizedEmail];

    if (user == null || user['password'] != password) {
      return null;
    }

    return UserModel(
      id: user['id']!,
      name: user['name']!,
      email: normalizedEmail,
      role: user['role']!,
    );
  }

  Future<UserModel?> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();

    if (_users.containsKey(normalizedEmail)) {
      return null;
    }

    final userId = 'u_${DateTime.now().millisecondsSinceEpoch}';
    _users[normalizedEmail] = {
      'id': userId,
      'name': name,
      'password': password,
      'role': role,
    };

    return UserModel(
      id: userId,
      name: name,
      email: normalizedEmail,
      role: role,
    );
  }
}
