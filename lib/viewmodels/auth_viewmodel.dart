import 'package:flutter/foundation.dart';
import '../core/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService service;

  bool _logged = false;
  String? errorMessage;

  bool get isLogged => _logged;

  AuthViewModel(this.service) {
    _logged = service.isLogged;
  }

  Future<bool> login(String email, String password) async {
    errorMessage = null;
    notifyListeners();

    final ok = await service.login(email: email, password: password);

    if (!ok) {
      errorMessage = "Credenciais inválidas";
      notifyListeners();
      return false;
    }

    _logged = true;
    notifyListeners();
    return true;
  }

  Future<void> register(String name, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 600));
    _logged = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await service.logout();
    _logged = false;
    notifyListeners();
  }
}
