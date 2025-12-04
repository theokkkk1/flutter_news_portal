import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';
import '../models/article.dart';
import '../widgets/article_card.dart';

class HomeListView extends StatefulWidget {
  const HomeListView({super.key});

  @override
  State<HomeListView> createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListView> {
  final ScrollController _scrollController = ScrollController();

  void _setupScroll(HomeViewModel vm) {
    if (!_scrollController.hasListeners) {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
          if (!vm.isLoadingMore && vm.hasMore) {
            vm.loadArticles();
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HomeViewModel>(context);
    _setupScroll(vm);

    if (vm.isLoading && vm.articles.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.error != null && vm.articles.isEmpty) {
      return Center(child: Text('Erro: ${vm.error}'));
    }

    return RefreshIndicator(
      onRefresh: () => vm.loadArticles(refresh: true),
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.all(12),
        itemCount: vm.articles.length + (vm.isLoadingMore ? 1 : 0),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          if (index >= vm.articles.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final Article a = vm.articles[index];

          return ArticleCard(
            article: a,
            onTap: () {
              Navigator.pushNamed(context, '/details', arguments: a);
            },
          );
        },
      ),
    );
  }
}
