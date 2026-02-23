// lib/services/auth_service.dart
class AuthService {
  /// Mock login. Replace with actual FirebaseAuth call later.
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 700));
    // simple mock rule: accept any non-empty credentials
    return email.isNotEmpty && password.isNotEmpty;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}