import 'package:flutter/material.dart';
import '../../models/habit.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  final List<Habit> _habits = [
    Habit(title: "Утренняя зарядка", category: "Здоровье", icon: Icons.directions_run, streak: 12, weekProgress: [true, true, true, true, true, true, true], isCompletedToday: true),
    Habit(title: "Чтение 30 минут", category: "Саморазвитие", icon: Icons.menu_book_rounded, streak: 8, weekProgress: [true, true, false, true, true, true, false], isCompletedToday: true),
    Habit(title: "Медитация", category: "Здоровье", icon: Icons.self_improvement, streak: 5, weekProgress: [true, true, true, true, true, false, false], isCompletedToday: false),
    Habit(title: "Выпить 2л воды", category: "Здоровье", icon: Icons.water_drop, streak: 15, weekProgress: [true, true, true, true, true, true, false], isCompletedToday: false),
    Habit(title: "Изучение языка", category: "Саморазвитие", icon: Icons.language, streak: 3, weekProgress: [false, true, true, true, false, false, false], isCompletedToday: false),
  ];

  @override
  Widget build(BuildContext context) {
    int completedCount = _habits.where((h) => h.isCompletedToday).length;
    int totalCount = _habits.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(completedCount, totalCount),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: _buildStatCard("Лучшая серия", "15 дней", Icons.local_fire_department, Colors.orange, const Color(0xFFFFF3E0))),
                  const SizedBox(width: 15),
                  Expanded(child: _buildStatCard("Всего привычек", "$totalCount", Icons.show_chart, const Color(0xFF6C63FF), const Color(0xFFE8EAF6))),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Мои привычки", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _habits.length,
              itemBuilder: (context, index) => _buildHabitCard(_habits[index]),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(int done, int total) {
    return Stack(
      children: [
        Container(
          height: 220,
          width: double.infinity,
          padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.arrow_back, color: Colors.white),
              const Text("Трекер привычек", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const Icon(Icons.add, color: Colors.white),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 120, left: 20, right: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Выполнено сегодня"),
                  Text("$done/$total", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                ],
              ),
              const SizedBox(height: 15),
              LinearProgressIndicator(
                value: total == 0 ? 0 : done / total,
                minHeight: 12,
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                borderRadius: BorderRadius.circular(10),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color iconColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 10)),
            Text(value, style: TextStyle(color: iconColor, fontSize: 16, fontWeight: FontWeight.bold)),
          ])
        ],
      ),
    );
  }

  Widget _buildHabitCard(Habit habit) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            children: [
              Icon(habit.icon, color: Colors.green),
              const SizedBox(width: 15),
              Expanded(child: Text(habit.title, style: const TextStyle(fontWeight: FontWeight.bold))),
              const Icon(Icons.local_fire_department, color: Colors.orange, size: 18),
              Text("${habit.streak}")
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              7,
              (i) => Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: habit.weekProgress[i] ? Colors.green : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
