import 'package:flutter/material.dart';

class Habit {
  final String title;
  final String category;
  final IconData icon;
  final int streak;
  final List<bool> weekProgress;
  final double overallProgress;
  final bool isCompletedToday;

  Habit({
    required this.title,
    required this.category,
    required this.icon,
    required this.streak,
    required this.weekProgress,
    this.overallProgress = 0.0,
    this.isCompletedToday = false,
  });

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      title: json['title'],
      category: json['category'],
      icon: Icons.help, // нельзя сериализовать IconData напрямую
      streak: json['streak'],
      weekProgress: List<bool>.from(json['weekProgress']),
      overallProgress: json['overallProgress'] ?? 0.0,
      isCompletedToday: json['isCompletedToday'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'streak': streak,
      'weekProgress': weekProgress,
      'overallProgress': overallProgress,
      'isCompletedToday': isCompletedToday,
    };
  }
}
