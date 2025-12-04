import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/favorites_viewmodel.dart';
import '../widgets/article_card.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FavoritesViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos (${vm.favorites.length})"),
      ),

      body: vm.favorites.isEmpty
          ? const Center(
              child: Text(
                "Nenhuma notícia favoritada",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: vm.favorites.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final article = vm.favorites[index];

                return ArticleCard(
                  article: article,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/details',
                      arguments: article,
                    );
                  },
                );
              },
            ),
    );
  }
}
