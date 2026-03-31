import 'package:flutter/material.dart';
import '../widgets/flower_background.dart';

class RemindersPage extends StatelessWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top + kToolbarHeight + 12;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Mementouri'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: FlowerBackground()),
          ListView(
            padding: EdgeInsets.fromLTRB(20, topInset, 20, 20),
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF5FF),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Center(child: Text('Vizualizare calendar (placeholder)')),
              ),
              const SizedBox(height: 16),
              const _ReminderCard(plant: 'Aloe Vera', task: 'Udare', time: 'Azi 09:00', recurring: 'La fiecare 3 zile'),
              const _ReminderCard(plant: 'Orhidee', task: 'Fertilizare', time: 'Maine 08:00', recurring: 'Saptamanal'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC57AE6), foregroundColor: Colors.white),
                child: const Text('Adauga memento'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReminderCard extends StatelessWidget {
  final String plant;
  final String task;
  final String time;
  final String recurring;
  const _ReminderCard({
    required this.plant,
    required this.task,
    required this.time,
    required this.recurring,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.notifications_active, color: Color(0xFFC57AE6)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$plant • $task', style: Theme.of(context).textTheme.bodyLarge),
                Text(time, style: Theme.of(context).textTheme.bodyMedium),
                Text(recurring, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          Checkbox(value: false, onChanged: (_) {}),
        ],
      ),
    );
  }
}



