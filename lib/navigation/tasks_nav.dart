import 'package:flutter/material.dart';
import '../screens/tasks/home_page.dart';
import '../screens/tasks/details_screen.dart';
import '../models/task.dart';

class TasksNavigation extends StatelessWidget {
  const TasksNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        if (settings.name == '/details') {
          final task = settings.arguments as Task;
          return MaterialPageRoute(
            builder: (_) => DetailsScreen(task: task),
          );
        }

        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      },
    );
  }
}
