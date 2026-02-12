import 'package:flutter/material.dart';
import '../../models/task.dart';

class DetailsScreen extends StatelessWidget {
  final Task task;
  const DetailsScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(task.name)),
      body: const Center(child: Text("Детали...")),
    );
  }
}
