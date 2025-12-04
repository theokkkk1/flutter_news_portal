import 'package:flutter/material.dart';
import '../models/article.dart';
import '../viewmodels/favorites_viewmodel.dart';
import 'package:provider/provider.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const ArticleCard({
    super.key,
    required this.article,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesViewModel>(context);
    final isFav = favorites.isFavorite(article);

    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGEM COM FALLBACK AUTOMÁTICO
            SizedBox(
              width: double.infinity,
              height: 220,
              child: (article.imageUrl.isEmpty ||
                      article.imageUrl == "null")
                  ? _buildPlaceholder()
                  : Image.network(
                      article.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildPlaceholder(),
                    ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "${article.newsSite} • ${Article.formatDate(article.publishedAt)}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    favorites.toggle(article);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[300],
      alignment: Alignment.center,
      child: const Icon(Icons.image_not_supported,
          size: 40, color: Colors.black38),
    );
  }
}
