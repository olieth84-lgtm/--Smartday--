import 'package:flutter/material.dart';
import '../../models/task.dart';
import 'details_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Task> _tasks = [
    Task(name: "Утренняя планерка", time: "09:00", isDone: true, priorityColor: Colors.red),
    Task(name: "Подготовить презентацию", time: "10:30", isDone: true, priorityColor: Colors.red),
    Task(name: "Обед и прогулка", time: "13:00", isDone: false, priorityColor: Colors.amber),
    Task(name: "Звонок с клиентом", time: "15:00", isDone: false, priorityColor: Colors.red),
    Task(name: "Спортзал", time: "18:00", isDone: false, priorityColor: Colors.amber),
    Task(name: "Чтение книги", time: "20:00", isDone: false, priorityColor: Colors.green),
  ];

  void _toggleTask(int index) {
    setState(() {
      _tasks[index].isDone = !_tasks[index].isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    int completedCount = _tasks.where((t) => t.isDone).length;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderSection(completedCount),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickActionBtn(Icons.check_circle_outline, "Привычки"),
                  const SizedBox(width: 12),
                  _buildQuickActionBtn(Icons.show_chart_rounded, "Аналитика"),
                  const SizedBox(width: 12),
                  _buildQuickActionBtn(Icons.calendar_month_outlined, "Календарь"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Задачи на сегодня", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add, size: 18, color: Colors.white),
                    label: const Text("Добавить", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D5BD0),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return _buildTaskCard(_tasks[index], index);
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(int completedCount) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4A4E9E), Color(0xFF8E44AD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("SMARTDAY", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 1)),
                  const SizedBox(height: 4),
                  Text("Вторник, 20 Января", style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14)),
                ],
              ),
              IconButton(icon: const Icon(Icons.notifications_none_rounded, color: Colors.white), onPressed: () {}),
            ],
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Прогресс дня", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("$completedCount/6", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: completedCount / 6,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.black87),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Осталось ${6 - completedCount} задач", style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQuickActionBtn(IconData icon, String label) {
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.black54),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(Task task, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (c) => DetailsScreen(task: task)));
        },
        leading: GestureDetector(
          onTap: () => _toggleTask(index),
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: task.isDone ? Colors.green : Colors.grey.shade400, width: 2),
              color: task.isDone ? Colors.green.withOpacity(0.1) : Colors.transparent,
            ),
            child: task.isDone ? const Icon(Icons.check, size: 16, color: Colors.green) : null,
          ),
        ),
        title: Text(task.name, style: TextStyle(decoration: task.isDone ? TextDecoration.lineThrough : null, color: task.isDone ? Colors.grey : Colors.black87)),
        subtitle: Text(task.time),
        trailing: Container(width: 8, height: 8, decoration: BoxDecoration(color: task.priorityColor, shape: BoxShape.circle)),
      ),
    );
  }
}
