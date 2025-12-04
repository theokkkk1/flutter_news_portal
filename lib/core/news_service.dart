import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsService {
  static const String baseUrl =
      "https://api.spaceflightnewsapi.net/v4/articles";

  Future<List<Article>> fetchTopStories({
    int page = 0,
    int limit = 20,
    String? siteFilter,
  }) async {
    final offset = page * limit;

    final uri =
        Uri.parse("$baseUrl/?limit=$limit&offset=$offset");

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception("Erro ao buscar artigos: ${response.statusCode}");
    }

    final jsonData = jsonDecode(response.body);
    final List results = jsonData["results"] ?? [];

    List<Article> list = results
        .map((item) => Article.fromJson(item))
        .toList();

    // filtrar por site (categoria)
    if (siteFilter != null && siteFilter.isNotEmpty) {
      list = list
          .where((a) =>
              a.newsSite.toLowerCase() == siteFilter.toLowerCase())
          .toList();
    }

    return list;
  }

  Future<List<String>> fetchAvailableSites({int limit = 100}) async {
    final uri = Uri.parse("$baseUrl/?limit=$limit&offset=0");
    final response = await http.get(uri);

    if (response.statusCode != 200) return [];

    final jsonData = jsonDecode(response.body);
    final List results = jsonData["results"] ?? [];

    final sites = results
        .map((e) => (e["news_site"] ?? "").toString())
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList();

    sites.sort();
    return sites;
  }
}
