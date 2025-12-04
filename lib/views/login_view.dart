import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Portal de Notícias"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: passCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Senha",
                ),
              ),

              const SizedBox(height: 24),

              // BOTÃO LOGIN
              vm.loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        final ok = await vm.login(
                          emailCtrl.text.trim(),
                          passCtrl.text.trim(),
                        );

                        if (ok) {
                          // Vai para HOME
                          Navigator.pushReplacementNamed(context, '/home');
                        }
                      },
                      child: const Text("Entrar"),
                    ),

              const SizedBox(height: 16),

              // ERRO
              if (vm.errorMessage != null)
                Text(
                  vm.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),

              const SizedBox(height: 20),

              // LINK PARA CADASTRO
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text("Criar uma conta"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
