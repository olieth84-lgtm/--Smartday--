import 'package:flutter/material.dart';

class Task {
  String name;
  String time;
  bool isDone;
  Color priorityColor;

  Task({
    required this.name,
    required this.time,
    this.isDone = false,
    this.priorityColor = Colors.grey,
  });
}
