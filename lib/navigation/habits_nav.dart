import 'package:flutter/material.dart';
import '../screens/habits/habits_screen.dart';

class HabitsNavigation extends StatelessWidget {
  const HabitsNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Navigator(
      onGenerateRoute: _routes,
    );
  }

  static Route _routes(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => const HabitsScreen(),
    );
  }
}
