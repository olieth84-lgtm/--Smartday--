import 'package:flutter/material.dart';
import '../../models/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  String? error;

  void login() async {
    final login = _loginController.text.trim();
    final password = _passwordController.text;

    // ---------------- Локальная проверка ----------------
    bool localSuccess = await AuthService.loginLocal(login, password);
    if (localSuccess) {
      Navigator.pushReplacementNamed(context, '/main');
      return;
    }

    // ---------------- Серверная проверка ----------------
    String? token = await AuthService().login(login, password);
    if (token != null) {
      print("Успешный вход! Token: $token");
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      setState(() => error = 'Неверный логин или пароль');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Вход')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _loginController,
              decoration: const InputDecoration(labelText: 'Логин / Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: const Text('Войти')),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('Нет аккаунта? Зарегистрироваться'),
            ),
            if (error != null)
              Text(error!, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
