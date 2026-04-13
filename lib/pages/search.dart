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
  final Set<String> _selectedStatuses = <String>{};
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top + 12;
    final store = PlantStore.instance;
    final statusFilters =
        plantStatusInfo.values.where((status) => status.code != 'EX').toList(growable: false);

    final allPlants = plantInfoByLabel.values.toList()
      ..sort((a, b) => a.nameRo.compareTo(b.nameRo));

    final query = _query.trim().toLowerCase();
    final results = query.isEmpty
        ? allPlants
        : allPlants.where((plant) {
            final haystack = '${plant.nameRo} ${plant.latin} ${plant.label}'.toLowerCase();
            return haystack.contains(query);
          }).toList();

    final filtered = _selectedStatuses.isEmpty
        ? results
        : results.where((plant) => _selectedStatuses.contains(plant.status)).toList();

    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        final favorites = store.favorites.toSet();
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
                  Text(
                    'Filtreaza dupa statutul din Cartea Rosie',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 44,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: statusFilters.length + 1,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return _CatalogFilterChip(
                            label: 'Toate',
                            color: const Color(0xFFC57AE6),
                            selected: _selectedStatuses.isEmpty,
                            onSelected: (_) {
                              if (_selectedStatuses.isEmpty) return;
                              setState(_selectedStatuses.clear);
                            },
                          );
                        }

                        final status = statusFilters[index - 1];
                        return _CatalogFilterChip(
                          label: status.labelRo,
                          color: status.color,
                          selected: _selectedStatuses.contains(status.code),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedStatuses.add(status.code);
                              } else {
                                _selectedStatuses.remove(status.code);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (filtered.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Text('Niciun rezultat.', style: Theme.of(context).textTheme.bodyLarge),
                    )
                  else
                    ...filtered.map((plant) => _PlantCard(plant: plant, store: store, favorites: favorites)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PlantCard extends StatelessWidget {
  final PlantInfo plant;
  final PlantStore store;
  final Set<String> favorites;

  const _PlantCard({required this.plant, required this.store, required this.favorites});

  @override
  Widget build(BuildContext context) {
    final statusLabel = getStatusLabelRo(plant.status);
    final statusColor = getStatusColor(plant.status);
    final image = plant.imageAssets.isEmpty ? 'assets/plant_icon.jpg' : plant.imageAssets.first;
    final isFavorite = favorites.contains(plant.label);

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

class _StatusTag extends StatelessWidget {
  final String label;
  final Color color;
  const _StatusTag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.9)),
      ),
      child: Text(label, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}

class _CatalogFilterChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const _CatalogFilterChip({
    required this.label,
    required this.color,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      showCheckmark: false,
      onSelected: onSelected,
      backgroundColor: Colors.white,
      selectedColor: color.withValues(alpha: 0.14),
      side: BorderSide(
        color: selected ? color : color.withValues(alpha: 0.45),
      ),
      labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: selected ? color : Colors.black87,
        fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }
}
