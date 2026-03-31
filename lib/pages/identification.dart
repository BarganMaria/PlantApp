import 'dart:io';
import 'package:flutter/material.dart';
import '../data/plant_info.dart';
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
    final confidence = primary?.confidence ?? 0.0;
    final matchPercent = (confidence * 100).clamp(0, 100).toStringAsFixed(1);
    final status = primary?.status ?? 'LC';
    final statusLabel = getStatusLabelRo(status);
    final statusColor = getStatusColor(status);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Rezultate identificare'),
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
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC57AE6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('Potrivire $matchPercent%', style: const TextStyle(color: Colors.white)),
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
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  const _StatChip(label: 'Nativa'),
                  _StatChip(label: 'Cartea Rosie: $statusLabel', color: statusColor),
                  const _StatChip(label: 'Ingrijire: Usor'),
                ],
              ),
              if (predictions.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text('Top 3 predictii', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 10),
                ...predictions.take(3).map((item) => _PredictionRow(item: item)),
              ],
              const SizedBox(height: 20),
              _TabCard(),
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
                  IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.flag_outlined)),
                ],
              ),
            ],
          ),
        ],
      ),
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

class _TabCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
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
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Prezentare'),
                Tab(text: 'Ghid ingrijire'),
                Tab(text: 'Mai multe'),
              ],
            ),
            SizedBox(
              height: 220,
              child: TabBarView(
                children: [
                  _TabContent(lines: ['Paragraf descriere', 'Caracteristici cheie', 'Comparatie cu specii similare']),
                  _TabContent(lines: ['Cerinte de lumina', 'Nevoi de apa', 'Tip de sol', 'Interval de temperatura']),
                  _TabContent(lines: ['Habitat si distributie', 'Sezon de inflorire', 'Utilizari', 'Statut de conservare']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabContent extends StatelessWidget {
  final List<String> lines;
  const _TabContent({required this.lines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines
            .map(
              (line) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    const Icon(Icons.eco, size: 16, color: Color(0xFFC57AE6)),
                    const SizedBox(width: 8),
                    Expanded(child: Text(line, style: Theme.of(context).textTheme.bodyMedium)),
                  ],
                ),
              ),
            )
            .toList(),
      ),
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




