import 'package:flutter/foundation.dart';
import '../core/news_service.dart';
import '../models/article.dart';

class HomeViewModel extends ChangeNotifier {
  final NewsService service;

  HomeViewModel(this.service);

  List<Article> articles = [];
  bool isLoading = false;
  bool isLoadingMore = false;
  String? error;
  int page = 0;
  final int limit = 20;
  bool hasMore = true;
  String? currentFilterSite;

  Future<void> loadArticles({bool refresh = false, String? siteFilter}) async {
    if (refresh) {
      page = 0;
      hasMore = true;
      articles = [];
      currentFilterSite = siteFilter;
    }
    if (!hasMore) return;

    try {
      if (page == 0) {
        isLoading = true;
      } else {
        isLoadingMore = true;
      }
      error = null;
      notifyListeners();

      final fetched = await service.fetchTopStories(page: page, limit: limit, siteFilter: currentFilterSite);
      if (fetched.length < limit) {
        hasMore = false;
      }
      articles.addAll(fetched);
      page += 1;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      isLoadingMore = false;
      notifyListeners();
    }
  }

  void applySiteFilter(String? site) {
    currentFilterSite = site;
    page = 0;
    hasMore = true;
    articles = [];
    loadArticles(refresh: true, siteFilter: site);
  }
}
