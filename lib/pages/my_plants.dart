import 'package:flutter/material.dart';
import '../widgets/flower_background.dart';

class MyPlantsPage extends StatelessWidget {
  const MyPlantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top + kToolbarHeight + 12;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Colectia mea de plante'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_alt_outlined)),
          TextButton(onPressed: () {}, child: const Text('+Adauga planta manual')),
        ],
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: FlowerBackground()),
          ListView(
            padding: EdgeInsets.fromLTRB(20, topInset, 20, 20),
            children: [
              Row(
                children: const [
                  Icon(Icons.grid_view, color: Color(0xFFC57AE6)),
                  SizedBox(width: 10),
                  Icon(Icons.view_list, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 16),
              _PlantGrid(),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlantGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final plants = ['Aloe Vera', 'Monstera', 'Rozmarin', 'Ficus'];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: plants.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color(0x11000000),
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3E8FB),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(child: Icon(Icons.local_florist, color: Color(0xFFC57AE6))),
                ),
              ),
              const SizedBox(height: 8),
              Text(plants[index], style: Theme.of(context).textTheme.titleLarge),
              Text('Ultima udare: acum 2 zile', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 6),
              Row(
                children: const [
                  Icon(Icons.circle, size: 10, color: Color(0xFFC57AE6)),
                  SizedBox(width: 6),
                  Text('Buna'),
                  Spacer(),
                  Icon(Icons.water_drop, size: 18, color: Color(0xFFC57AE6)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}



