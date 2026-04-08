import 'package:flutter/material.dart';

import '../data/plant_info.dart';

Future<void> showPlantPickerSheet({
  required BuildContext context,
  required Set<String> selected,
  required ValueChanged<String> onSelected,
  String title = 'Alege o planta din catalog',
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.86,
        child: _PlantPickerSheet(
          title: title,
          selected: selected,
          onSelected: onSelected,
        ),
      );
    },
  );
}

class _PlantPickerSheet extends StatefulWidget {
  final String title;
  final Set<String> selected;
  final ValueChanged<String> onSelected;

  const _PlantPickerSheet({
    required this.title,
    required this.selected,
    required this.onSelected,
  });

  @override
  State<_PlantPickerSheet> createState() => _PlantPickerSheetState();
}

class _PlantPickerSheetState extends State<_PlantPickerSheet> {
  late final List<PlantInfo> _allPlants;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _allPlants = plantInfoByLabel.values.toList()
      ..sort((a, b) => a.nameRo.compareTo(b.nameRo));
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filter(_query);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 6),
            child: Container(
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE6E6E6),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  tooltip: 'Inchide',
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: TextField(
              onChanged: (value) => setState(() => _query = value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Cauta dupa nume sau latin',
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final plant = filtered[index];
                final statusLabel = getStatusLabelRo(plant.status);
                final statusColor = getStatusColor(plant.status);
                final isSelected = widget.selected.contains(plant.label);
                return ListTile(
                  tileColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  leading: _Thumb(image: plant.imageAssets.first),
                  title: Text(plant.nameRo, style: Theme.of(context).textTheme.titleMedium),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plant.latin,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 6),
                      _StatusChip(label: statusLabel, color: statusColor),
                    ],
                  ),
                  trailing: Icon(
                    isSelected ? Icons.check_circle : Icons.add_circle_outline,
                    color: isSelected ? const Color(0xFFC57AE6) : Colors.grey,
                  ),
                  onTap: () {
                    widget.onSelected(plant.label);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<PlantInfo> _filter(String query) {
    if (query.trim().isEmpty) return _allPlants;
    final lower = query.toLowerCase();
    return _allPlants.where((plant) {
      final haystack = '${plant.nameRo} ${plant.latin} ${plant.label}'.toLowerCase();
      return haystack.contains(lower);
    }).toList();
  }
}

class _Thumb extends StatelessWidget {
  final String image;
  const _Thumb({required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 52,
        height: 52,
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

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.8)),
      ),
      child: Text(label, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
