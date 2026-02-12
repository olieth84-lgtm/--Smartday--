import 'package:flutter/material.dart';
import '../../models/habit.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Habit> habits = [
      Habit(title: "Утренняя зарядка", category: "", icon: Icons.directions_run, streak: 0, weekProgress: [], overallProgress: 1.0),
      Habit(title: "Чтение 30 минут", category: "", icon: Icons.menu_book_rounded, streak: 0, weekProgress: [], overallProgress: 0.86),
      Habit(title: "Медитация", category: "", icon: Icons.self_improvement, streak: 0, weekProgress: [], overallProgress: 0.71),
      Habit(title: "Выпить 2л воды", category: "", icon: Icons.water_drop, streak: 0, weekProgress: [], overallProgress: 1.0),
      Habit(title: "Изучение языка", category: "", icon: Icons.language, streak: 0, weekProgress: [], overallProgress: 0.57),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildInfoCard("Продуктивность", "84%", "+5% к прошлой неделе", Icons.show_chart, Colors.blue)),
                      const SizedBox(width: 15),
                      Expanded(child: _buildInfoCard("Выполнено задач", "43", "из 51 запланированных", Icons.check_circle_outline, Colors.green)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(child: _buildInfoCard("Текущая серия", "12", "дней подряд", Icons.local_fire_department, Colors.orange)),
                      const SizedBox(width: 15),
                      Expanded(child: _buildInfoCard("Привычки", "5", "активных привычек", Icons.emoji_events_outlined, Colors.purple)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Активность за неделю", style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 15),
            _buildBarChart(),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Прогресс привычек", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  ...habits.map((h) => _buildHabitProgressRow(h)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.lightbulb_outline, color: Colors.amber),
                      SizedBox(width: 8),
                      Text("Инсайты", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text("Отличная работа! Ваша продуктивность выросла на 5% по сравнению с прошлой неделей.", style: TextStyle(color: Colors.grey.shade600, height: 1.5)),
                  const SizedBox(height: 10),
                  Text("Серия 12 дней! Вы выполняете задачи 12 дней подряд. Так держать!", style: TextStyle(color: Colors.grey.shade600, height: 1.5)),
                  const SizedBox(height: 10),
                  Text("Совет: Постарайтесь улучшить выполнение привычки \"Изучение языка\" - сейчас всего 57%.", style: TextStyle(color: Colors.grey.shade600, height: 1.5)),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2D5BD0), Color(0xFF6C63FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back, color: Colors.white)),
              const Expanded(child: Center(child: Text("Аналитика продуктивности", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)))),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: const Center(child: Text("Неделя", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2D5BD0)))),
                )),
                const Expanded(child: Center(child: Text("Месяц", style: TextStyle(color: Colors.white)))),
                const Expanded(child: Center(child: Text("Год", style: TextStyle(color: Colors.white)))),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String mainValue, String subValue, IconData icon, Color color) {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Expanded(child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Colors.grey.shade700))),
            ],
          ),
          Text(mainValue, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color)),
          Text(subValue, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    final data = [0.4, 0.3, 0.6, 0.5, 0.4, 0.35, 0.2];
    final days = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];
    return Container(
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(7, (index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 30,
                height: 100 * data[index],
                decoration: BoxDecoration(
                  color: const Color(0xFF4FA4F4).withOpacity(index == 2 ? 1.0 : 0.6),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                ),
              ),
              const SizedBox(height: 8),
              Text(days[index], style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildHabitProgressRow(Habit habit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(habit.icon, size: 20, color: Colors.black87),
              const SizedBox(width: 10),
              Expanded(child: Text(habit.title, style: const TextStyle(fontWeight: FontWeight.w500))),
              Text("${(habit.overallProgress * 100).toInt()}%", style: TextStyle(fontWeight: FontWeight.bold, color: _getColorForProgress(habit.overallProgress))),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: habit.overallProgress,
              minHeight: 6,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
            ),
          )
        ],
      ),
    );
  }

  Color _getColorForProgress(double value) {
    if (value >= 1.0) return Colors.green;
    if (value >= 0.7) return Colors.green.shade700;
    if (value >= 0.5) return Colors.orange;
    return Colors.red;
  }
}
