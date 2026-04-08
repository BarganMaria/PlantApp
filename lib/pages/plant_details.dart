import 'package:flutter/material.dart';

import '../data/plant_info.dart';
import '../widgets/flower_background.dart';

class PlantDetailsPage extends StatelessWidget {
  final PlantInfo plant;

  const PlantDetailsPage({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top + kToolbarHeight + 12;
    final statusLabel = getStatusLabelRo(plant.status);
    final statusColor = getStatusColor(plant.status);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(plant.nameRo),
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
              _ImageGallery(images: plant.imageAssets),
              const SizedBox(height: 14),
              Text(plant.nameRo, style: Theme.of(context).textTheme.headlineSmall),
              Text(
                plant.latin,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: [
                  _Chip(
                    label: 'Cartea Rosie: $statusLabel',
                    borderColor: statusColor,
                  ),
                  const _Chip(label: 'Catalog Moldova'),
                ],
              ),
              const SizedBox(height: 16),
              Text('Descriere', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(plant.descriptionRo, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ],
      ),
    );
  }
}

class _ImageGallery extends StatelessWidget {
  final List<String> images;

  const _ImageGallery({required this.images});

  @override
  Widget build(BuildContext context) {
    final safeImages = images.isEmpty ? const ['assets/plant_icon.jpg'] : images;

    return SizedBox(
      height: 220,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: PageView.builder(
          itemCount: safeImages.length,
          itemBuilder: (context, index) {
            return Container(
              color: const Color(0xFFF3E8FB),
              child: Center(
                child: Image.asset(
                  safeImages[index],
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color? borderColor;

  const _Chip({required this.label, this.borderColor});

  @override
  Widget build(BuildContext context) {
    final color = borderColor ?? const Color(0xFFD7C8E5);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
