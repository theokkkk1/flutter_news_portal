import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/theme_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authVm = context.watch<AuthViewModel>();
    final themeVm = context.watch<ThemeViewModel>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Perfil",
            style: Theme.of(context).textTheme.titleLarge,
          ),

          const SizedBox(height: 20),

          Text(
            authVm.isLogged ? "Usuário logado" : "Nenhum usuário logado",
            style: const TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              const Text("Modo escuro"),
              Switch(
                value: themeVm.isDark,
                onChanged: (_) => themeVm.toggle(),
              )
            ],
          ),

          const SizedBox(height: 20),

          if (authVm.isLogged)
            ElevatedButton(
              onPressed: () async {
                await authVm.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text("Logout"),
            ),
        ],
      ),
    );
  }
}
