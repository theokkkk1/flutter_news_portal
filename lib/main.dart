import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// CORE / SERVICES
import 'core/auth_service.dart';
import 'core/favorites_service.dart';
import 'core/home_factory.dart';

// DESIGN SYSTEM
import 'design_system.dart';

// VIEWMODELS
import 'viewmodels/login_viewmodel.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/theme_viewmodel.dart';

// VIEWS
import 'views/login_view.dart';
import 'views/register_view.dart';
import 'views/article_details_view.dart';
import 'views/favorites_view.dart';
import 'views/profile_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authService = AuthService();
  await authService.init();

  final favoritesService = FavoritesService();
  await favoritesService.init();

  runApp(MyApp(
    authService: authService,
    favoritesService: favoritesService,
  ));
}

class MyApp extends StatelessWidget {
  final AuthService authService;
  final FavoritesService favoritesService;

  const MyApp({
    super.key,
    required this.authService,
    required this.favoritesService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // SERVICES
        Provider<AuthService>.value(value: authService),
        Provider<FavoritesService>.value(value: favoritesService),

        // VIEWMODELS
        ChangeNotifierProvider<AuthViewModel>(
          create: (_) => AuthViewModel(authService),
        ),
        ChangeNotifierProvider<LoginViewModel>(
          create: (_) => LoginViewModel(authService),
        ),
        ChangeNotifierProvider<ThemeViewModel>(
          create: (_) => ThemeViewModel(),
        ),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (_, themeVm, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Portal de Notícias',

            theme: DesignSystem.lightTheme,
            darkTheme: DesignSystem.darkTheme,
            themeMode: themeVm.isDark ? ThemeMode.dark : ThemeMode.light,

            initialRoute: '/login',

            routes: {
              '/login': (_) => const LoginView(),
              '/register': (_) => const RegisterView(),

              // HOME NAVIGATION (BottomNavigationBar)
              '/home': (_) =>
                  HomeFactory.makeHome(favoritesService, authService),

              // DETAILS PAGE
              '/details': (_) => const ArticleDetailsView(),

              // FAVORITES PAGE (manual navigation)
              '/favorites': (_) => const FavoritesView(),

              // PROFILE PAGE
              '/profile': (_) => const ProfileView(),
            },
          );
        },
      ),
    );
  }
}
