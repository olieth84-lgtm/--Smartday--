import 'package:flutter/material.dart';
import 'tasks/home_page.dart';
import 'habits/habits_screen.dart';
import 'analytics/analytics_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const HomePage(),
    const HabitsScreen(),
    const AnalyticsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          backgroundColor: Colors.white,
          indicatorColor: Colors.transparent,
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(Icons.check_circle_outline),
              selectedIcon:
                  Icon(Icons.check_circle, color: Color(0xFF6C63FF)),
              label: 'Задачи',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_today_outlined),
              selectedIcon:
                  Icon(Icons.calendar_today, color: Color(0xFF6C63FF)),
              label: 'Привычки',
            ),
            NavigationDestination(
              icon: Icon(Icons.show_chart),
              selectedIcon:
                  Icon(Icons.show_chart, color: Color(0xFF6C63FF)),
              label: 'Аналитика',
            ),
          ],
        ),
      ),
    );
  }
}