import 'package:flutter/material.dart';
import '../widgets/flower_background.dart';

class ScanHistoryPage extends StatelessWidget {
  const ScanHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top + kToolbarHeight + 12;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Istoric scanari'),
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
            children: const [
              _HistorySection(title: 'Azi'),
              _HistorySection(title: 'Ieri'),
              _HistorySection(title: 'Saptamana trecuta'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HistorySection extends StatelessWidget {
  final String title;
  const _HistorySection({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
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
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3E8FB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.local_florist, color: Color(0xFFC57AE6)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mac de camp', style: Theme.of(context).textTheme.titleLarge),
                    const Text('Incredere: 95%'),
                    const Text('11:30'),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outline)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}



