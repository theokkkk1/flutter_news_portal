import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/news_service.dart';
import '../core/favorites_service.dart';
import '../core/auth_service.dart';

import '../viewmodels/home_viewmodel.dart';
import '../viewmodels/favorites_viewmodel.dart';
import '../viewmodels/auth_viewmodel.dart';

import '../views/home_shell.dart';

class HomeFactory {
  static Widget makeHome(
    FavoritesService favoritesService,
    AuthService authService,
  ) {
    final newsService = NewsService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
          create: (_) => HomeViewModel(newsService)..loadArticles(refresh: true),
        ),
        ChangeNotifierProvider<FavoritesViewModel>(
          create: (_) => FavoritesViewModel(favoritesService),
        ),
        ChangeNotifierProvider<AuthViewModel>.value(
          value: AuthViewModel(authService),
        ),
      ],
      child: const HomeShell(),
    );
  }
}
