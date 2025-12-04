import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/article.dart';

class FavoritesService {
  static const String _key = 'favorites_v2';
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Carrega favoritos do storage local
  List<Article> loadFavorites() {
    final raw = _prefs.getStringList(_key) ?? [];

    return raw.map((s) {
      try {
        final map = jsonDecode(s);
        return Article.fromJson(map);
      } catch (_) {
        return null;
      }
    }).whereType<Article>().toList();
  }

  /// Salva a lista completa
  Future<void> saveFavorites(List<Article> list) async {
    final encoded = list.map((a) => jsonEncode(a.toJson())).toList();
    await _prefs.setStringList(_key, encoded);
  }
}
