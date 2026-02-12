import 'package:flutter/material.dart';
import '../screens/analytics/analytics_screen.dart';

class AnalyticsNavigation extends StatelessWidget {
  const AnalyticsNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Navigator(
      onGenerateRoute: _routes,
    );
  }

  static Route _routes(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => const AnalyticsScreen(),
    );
  }
}
