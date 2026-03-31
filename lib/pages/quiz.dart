import 'package:flutter/material.dart';
import '../widgets/flower_background.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top + kToolbarHeight + 12;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Quiz zilnic'),
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
                height: 220,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3E8FB),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Center(child: Icon(Icons.local_florist, size: 80, color: Color(0xFFC57AE6))),
              ),
              const SizedBox(height: 16),
              Text('Intrebarea 1 din 10', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 8),
              Text('Ce planta este prezentata mai sus?', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              const _AnswerOption(label: 'Mac de camp'),
              const _AnswerOption(label: 'Trandafir salbatic'),
              const _AnswerOption(label: 'Ienupar'),
              const _AnswerOption(label: 'Lavanda'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC57AE6), foregroundColor: Colors.white),
                child: const Text('Trimite raspunsul'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnswerOption extends StatelessWidget {
  final String label;
  const _AnswerOption({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD7C8E5)),
      ),
      child: Row(
        children: [
          const Icon(Icons.circle_outlined, size: 18),
          const SizedBox(width: 10),
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}



