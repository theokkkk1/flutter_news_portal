import 'package:flutter/foundation.dart';
import '../models/article.dart';
import '../core/favorites_service.dart';

class FavoritesViewModel extends ChangeNotifier {
  final FavoritesService service;
  List<Article> favorites = [];

  FavoritesViewModel(this.service) {
    load();
  }

  void load() {
    favorites = service.loadFavorites();
    notifyListeners();
  }

  bool isFavorite(Article a) {
    return favorites.any((f) => f.id == a.id);
  }

  Future<void> add(Article a) async {
    if (isFavorite(a)) return;
    favorites.add(a);
    await service.saveFavorites(favorites);
    notifyListeners();
  }

  Future<void> remove(Article a) async {
    favorites.removeWhere((f) => f.id == a.id);
    await service.saveFavorites(favorites);
    notifyListeners();
  }

  Future<void> toggle(Article a) async {
    if (isFavorite(a)) {
      await remove(a);
    } else {
      await add(a);
    }
  }
}
