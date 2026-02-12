import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'screens/main_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'models/auth_service.dart';

final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

final authService = AuthService();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация уведомлений
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initSettings =
      InitializationSettings(android: androidSettings);

  await notificationsPlugin.initialize(initSettings);

  // Пример автоматического логина через сервер
  await loginUser();

  runApp(const SmartdayApp());
}

/// Функция входа на сервер
Future<void> loginUser() async {
  String? token = await authService.login(
    "eve.holt@reqres.in",
    "cityslicka",
  );

  if (token != null) {
    print("Успешный вход! Token: $token");
  } else {
    print("Ошибка входа");
  }
}

class SmartdayApp extends StatelessWidget {
  const SmartdayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smartday',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FE),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/main': (context) => const MainScreen(),
      },
    );
  }
}

/// Показ локального уведомления
Future<void> showLocalNotification({
  String title = 'Smartday',
  String body = 'Не забудь проверить свои задачи 👀',
}) async {
  const AndroidNotificationDetails androidDetails =
      AndroidNotificationDetails(
    'default_channel',
    'Основные уведомления',
    channelDescription: 'Уведомления приложения Smartday',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails);

  await notificationsPlugin.show(
    0,
    title,
    body,
    notificationDetails,
  );
}
