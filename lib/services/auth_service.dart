class AuthService {
  final Map<String, Map<String, String>> _users = {
    "student@skillchain.com": {
      "password": "1234",
      "role": "student",
    },
    "startup@skillchain.com": {
      "password": "1234",
      "role": "startup",
    },
    "admin@skillchain.com": {
      "password": "1234",
      "role": "admin",
    },
  };

  Map<String, String>? login(String email, String password) {
    if (_users.containsKey(email) &&
        _users[email]!["password"] == password) {
      return {
        "email": email,
        "role": _users[email]!["role"]!,
      };
    }
    return null;
  }

  void register(String email, String password, String role) {
    _users[email] = {
      "password": password,
      "role": role,
    };
  }
}