import 'dart:io';
import 'package:flutter/material.dart';
import '../data/plant_info.dart';
import '../data/plant_store.dart';
import '../services/plant_classifier.dart';
import '../widgets/flower_background.dart';

class IdentificationResultsPage extends StatelessWidget {
  final String? imagePath;
  final PlantPrediction? prediction;
  final List<PlantPrediction> predictions;

  const IdentificationResultsPage({
    super.key,
    this.imagePath,
    this.prediction,
    this.predictions = const [],
  });

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top + kToolbarHeight + 12;
    final primary = prediction ?? (predictions.isNotEmpty ? predictions.first : null);
    final status = primary?.status ?? 'LC';
    final statusLabel = getStatusLabelRo(status);
    final statusColor = getStatusColor(status);
    final description = primary?.info?.descriptionRo ?? 'Descriere indisponibila pentru aceasta specie.';
    final store = PlantStore.instance;
    final isFavorite = primary != null && store.isFavorite(primary.label);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Rezultate identificare'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            tooltip: 'Detalii identificare',
            onPressed: () => _showIdentificationDetails(context),
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: FlowerBackground()),
          ListView(
            padding: EdgeInsets.fromLTRB(20, topInset, 20, 20),
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3E8FB),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: imagePath == null
                      ? const Center(child: Icon(Icons.local_florist, size: 80, color: Color(0xFFC57AE6)))
                      : Image.file(
                          File(imagePath!),
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                primary?.displayName ?? 'Specie necunoscuta',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                primary?.latinName ?? 'Identificare indisponibila',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 6),
              Text('Moldova Plants Model', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              _StatChip(label: 'Cartea Rosie: $statusLabel', color: statusColor),
              const SizedBox(height: 14),
              Text('Descriere', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(description, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style:
                          ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC57AE6), foregroundColor: Colors.white),
                      child: const Text('Adauga in Plantele mele'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: primary == null ? null : () => store.toggleFavorite(primary.label),
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.pink.shade400 : const Color(0xFFC57AE6),
                    ),
                    tooltip: isFavorite ? 'Scoate din favorite' : 'Adauga la favorite',
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showIdentificationDetails(BuildContext context) {
    final primary = prediction ?? (predictions.isNotEmpty ? predictions.first : null);
    final primaryConfidence = primary?.confidence ?? 0.0;
    final matchPercent = (primaryConfidence * 100).clamp(0, 100).toStringAsFixed(1);

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Detalii identificare', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text('Potrivire: $matchPercent%', style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 14),
                if (predictions.isNotEmpty) ...[
                  Text('Top predictii', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 10),
                  ...predictions.take(3).map((item) => _PredictionRow(item: item)),
                ] else ...[
                  Text('Nu exista predictii disponibile.', style: Theme.of(context).textTheme.bodyMedium),
                ],
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final Color? color;
  const _StatChip({required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    final chipColor = color ?? const Color(0xFFD7C8E5);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: chipColor),
      ),
      child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}

class _PredictionRow extends StatelessWidget {
  final PlantPrediction item;
  const _PredictionRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final percent = (item.confidence * 100).clamp(0, 100).toStringAsFixed(1);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE7E1F0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.displayName, style: Theme.of(context).textTheme.titleMedium),
                Text(
                  item.latinName,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          Text('$percent%', style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}




