import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeViewModel extends ChangeNotifier {
  static const String _key = 'theme_is_dark';
  bool isDark = false;

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool(_key) ?? false;
    notifyListeners();
  }

  Future<void> toggle() async {
    isDark = !isDark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, isDark);
    notifyListeners();
  }
}
