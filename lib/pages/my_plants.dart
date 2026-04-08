import 'package:flutter/material.dart';

import '../data/plant_info.dart';
import '../widgets/flower_background.dart';

class MyPlantsPage extends StatefulWidget {
  const MyPlantsPage({super.key});

  @override
  State<MyPlantsPage> createState() => _MyPlantsPageState();
}

class _MyPlantsPageState extends State<MyPlantsPage> {
  final List<String> _plants = [
    'narcissus_pseudonarcissus',
    'tulipa_gesneriana',
  ];

  void _addPlant(String label) {
    if (!_plants.contains(label)) {
      setState(() => _plants.add(label));
    }
  }

  void _showAddPlant() {
    final candidates = plantInfoByLabel.values.take(10).toList();
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: candidates
              .map(
                (plant) => ListTile(
                  leading: _PlantThumb(image: plant.imageAssets.first),
                  title: Text(plant.nameRo),
                  subtitle: Text(plant.latin),
                  trailing: _plants.contains(plant.label) ? const Icon(Icons.check, color: Color(0xFFC57AE6)) : null,
                  onTap: () {
                    _addPlant(plant.label);
                    Navigator.of(context).pop();
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

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
          TextButton(onPressed: _showAddPlant, child: const Text('+Adauga planta')),
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
              _PlantGrid(plants: _plants),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlantGrid extends StatelessWidget {
  final List<String> plants;
  const _PlantGrid({required this.plants});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: plants.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final info = getPlantInfo(plants[index]);
        final image = info?.imageAssets.first ?? 'assets/plant_icon.jpg';
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
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(
                  height: 140,
                  width: double.infinity,
                  child: Container(
                    color: const Color(0xFFF3E8FB),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.local_florist, color: Color(0xFFC57AE6)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                info?.nameRo ?? plants[index],
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Ultima udare: acum 2 zile',
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
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

class _PlantThumb extends StatelessWidget {
  final String image;
  const _PlantThumb({required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 48,
        height: 48,
        color: const Color(0xFFF3E8FB),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(Icons.local_florist, color: Color(0xFFC57AE6)),
        ),
      ),
    );
  }
}
