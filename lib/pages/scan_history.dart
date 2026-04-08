import 'package:flutter/material.dart';

import '../data/plant_info.dart';
import '../data/plant_store.dart';
import '../widgets/flower_background.dart';

class ScanHistoryPage extends StatelessWidget {
  const ScanHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top + kToolbarHeight + 12;
    final store = PlantStore.instance;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Istoric scanari'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            tooltip: 'Sterge istoricul',
            onPressed: () => store.clearScans(),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: FlowerBackground()),
          AnimatedBuilder(
            animation: store,
            builder: (context, _) {
              final items = store.recentScans;
              if (items.isEmpty) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(20, topInset, 20, 20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
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
                    child: Text(
                      'Nu ai scanari salvate inca.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.fromLTRB(20, topInset, 20, 20),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final entry = items[index];
                  final info = getPlantInfo(entry.label);
                  final image = info?.imageAssets.first ?? 'assets/plant_icon.jpg';
                  final confidence = (entry.confidence * 100).clamp(0, 100).toStringAsFixed(0);
                  final time = _formatTime(entry.timestamp);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
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
                        _Thumb(image: image),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                info?.nameRo ?? entry.label,
                                style: Theme.of(context).textTheme.titleMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                info?.latin ?? '',
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text('Incredere: $confidence%', style: Theme.of(context).textTheme.bodySmall),
                              Text(time, style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => store.addFavorite(entry.label),
                          tooltip: 'Adauga la favorite',
                          icon: const Icon(Icons.favorite_border, color: Color(0xFFC57AE6)),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  final String image;
  const _Thumb({required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 56,
        height: 56,
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

String _formatTime(DateTime time) {
  final now = DateTime.now();
  final isToday = now.year == time.year && now.month == time.month && now.day == time.day;
  final h = time.hour.toString().padLeft(2, '0');
  final m = time.minute.toString().padLeft(2, '0');
  if (isToday) return 'Azi • $h:$m';
  return '${time.day.toString().padLeft(2, '0')}.${time.month.toString().padLeft(2, '0')} • $h:$m';
}
