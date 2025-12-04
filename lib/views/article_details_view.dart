import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/article.dart';

class ArticleDetailsView extends StatelessWidget {
  const ArticleDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final Article article =
        ModalRoute.of(context)!.settings.arguments as Article;

    return Scaffold(
      appBar: AppBar(
        title: Text(article.newsSite),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (article.imageUrl.isNotEmpty)
            Image.network(
              article.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.broken_image, size: 60),
            )
          else
            Container(
              height: 180,
              width: double.infinity,
              alignment: Alignment.center,
              color: Colors.grey.shade200,
              child: const Icon(Icons.image_not_supported, size: 60),
            ),

          const SizedBox(height: 20),

          Text(
            article.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Text(
            article.summary,
            style: const TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () async {
              final Uri uri = Uri.parse(article.url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
            child: const Text("Visitar site original"),
          ),
        ],
      ),
    );
  }
}
