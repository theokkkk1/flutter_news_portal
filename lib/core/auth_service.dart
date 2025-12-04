class AuthService {
  bool _logged = false;

  Future<void> init() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<bool> login({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 600));

    if (email.isEmpty || password.isEmpty) return false;

    _logged = true;
    return true;
  }

  Future<void> logout() async {
    _logged = false;
  }

  bool get isLogged => _logged;
}
