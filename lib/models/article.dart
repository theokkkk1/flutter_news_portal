class Article {
  final int id;
  final String title;
  final String summary;
  final String url;
  final String imageUrl;
  final String newsSite;
  final String publishedAt;

  Article({
    required this.id,
    required this.title,
    required this.summary,
    required this.url,
    required this.imageUrl,
    required this.newsSite,
    required this.publishedAt,
  });

  // 🔧 Corrige caracteres estranhos de UTF
  static String fixUtf(String text) {
    return text
        .replaceAll('â', "'")
        .replaceAll('â', "'")
        .replaceAll('â', '–')
        .replaceAll('â', '—')
        .replaceAll('â¦', '…')
        .replaceAll('â', '"')
        .replaceAll('â', '"')
        .replaceAll('â¢', '•')
        .replaceAll('â¨', '\n')
        .trim();
  }

  // 🗓️ Formata data ISO em formato brasileiro
  static String formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso);
      return "${dt.day.toString().padLeft(2,'0')}/"
          "${dt.month.toString().padLeft(2,'0')}/"
          "${dt.year} ${dt.hour.toString().padLeft(2,'0')}:"
          "${dt.minute.toString().padLeft(2,'0')}";
    } catch (_) {
      return iso;
    }
  }

  // 🔥 Lê JSON vindo da API REAL
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] ?? 0,
      title: fixUtf(json['title'] ?? ''),
      summary: fixUtf(json['summary'] ?? ''),
      url: json['url'] ?? '',
      imageUrl: json['image_url'] ?? '',
      newsSite: json['news_site'] ?? '',
      publishedAt: json['published_at'] ?? '',
    );
  }

  // 🔥 Necessário para FAVORITOS
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'url': url,
      'image_url': imageUrl,
      'news_site': newsSite,
      'published_at': publishedAt,
    };
  }
}
