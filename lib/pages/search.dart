import 'package:flutter/material.dart';

import '../data/plant_info.dart';
import '../data/plant_store.dart';
import '../widgets/flower_background.dart';
import 'plant_details.dart';
import 'red_book.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';
  final Set<String> _statusFilter = {};

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top + 12;
    final store = PlantStore.instance;

    final allPlants = plantInfoByLabel.values.toList()
      ..sort((a, b) => a.nameRo.compareTo(b.nameRo));

    final query = _query.trim().toLowerCase();
    final results = query.isEmpty
        ? allPlants
        : allPlants.where((plant) {
            final haystack = '${plant.nameRo} ${plant.latin} ${plant.label}'.toLowerCase();
            return haystack.contains(query);
          }).toList();

    final filtered = _statusFilter.isEmpty
        ? results
        : results.where((plant) => _statusFilter.contains(plant.status)).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: null,
      body: Stack(
        children: [
          const Positioned.fill(child: FlowerBackground()),
          ListView(
            padding: EdgeInsets.fromLTRB(20, topInset, 20, 20),
            children: [
              TextField(
                controller: _controller,
                onChanged: (value) => setState(() => _query = value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Cauta plante dupa nume sau nume stiintific...',
                ),
              ),
              const SizedBox(height: 12),
              _StatusFilter(
                selected: _statusFilter,
                onToggle: (code) {
                  setState(() {
                    if (_statusFilter.contains(code)) {
                      _statusFilter.remove(code);
                    } else {
                      _statusFilter.add(code);
                    }
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text('Catalog plante', style: Theme.of(context).textTheme.titleLarge),
                  const Spacer(),
                  IconButton(
                    tooltip: 'Cartea Rosie a Moldovei',
                    icon: const Icon(Icons.info_outline),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const RedBookPage()),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (filtered.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Text('Niciun rezultat.', style: Theme.of(context).textTheme.bodyLarge),
                )
              else
                ...filtered.map((plant) => _PlantCard(plant: plant, store: store)),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlantCard extends StatelessWidget {
  final PlantInfo plant;
  final PlantStore store;

  const _PlantCard({required this.plant, required this.store});

  @override
  Widget build(BuildContext context) {
    final statusLabel = getStatusLabelRo(plant.status);
    final statusColor = getStatusColor(plant.status);
    final image = plant.imageAssets.isEmpty ? 'assets/plant_icon.jpg' : plant.imageAssets.first;
    final isFavorite = store.isFavorite(plant.label);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => PlantDetailsPage(plant: plant)),
        );
      },
      child: Container(
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
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 64,
                height: 64,
                color: const Color(0xFFF3E8FB),
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(Icons.local_florist, color: Color(0xFFC57AE6)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant.nameRo,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    plant.latin,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    plant.descriptionRo,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      _StatusTag(label: statusLabel, color: statusColor),
                      if (isRedListStatus(plant.status))
                        const _StatusTag(label: 'Cartea rosie', color: Color(0xFFE53935)),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: isFavorite ? 'Scoate din favorite' : 'Adauga la favorite',
              onPressed: () => store.toggleFavorite(plant.label),
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.pink.shade400 : const Color(0xFFC57AE6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusFilter extends StatelessWidget {
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  const _StatusFilter({required this.selected, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: plantStatusInfo.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final status = plantStatusInfo.values.elementAt(index);
          final isOn = selected.contains(status.code);
          return ChoiceChip(
            label: Text(status.labelRo),
            selected: isOn,
            onSelected: (_) => onToggle(status.code),
            selectedColor: status.color.withOpacity(0.2),
          );
        },
      ),
    );
  }
}

class _StatusTag extends StatelessWidget {
  final String label;
  final Color color;
  const _StatusTag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.9)),
      ),
      child: Text(label, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
