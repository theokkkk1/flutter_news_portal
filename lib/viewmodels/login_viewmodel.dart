import 'package:flutter/foundation.dart';
import '../core/auth_service.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService auth;

  bool loading = false;
  String? errorMessage;

  LoginViewModel(this.auth);

  Future<bool> login(String email, String password) async {
    loading = true;
    errorMessage = null;
    notifyListeners();

    final ok = await auth.login(email: email, password: password);

    loading = false;

    if (!ok) {
      errorMessage = "Email ou senha inválidos";
      notifyListeners();
      return false;
    }

    notifyListeners();
    return true;
  }
}
