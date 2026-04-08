import 'package:flutter/material.dart';

import '../data/plant_info.dart';
import '../data/plant_store.dart';
import '../widgets/flower_background.dart';
import '../widgets/plant_picker_sheet.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final PlantStore _store = PlantStore.instance;

  void _showAddFavorite() {
    showPlantPickerSheet(
      context: context,
      selected: _store.favorites.toSet(),
      title: 'Adauga plante in favorite',
      onSelected: (label) {
        _store.addFavorite(label);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top + kToolbarHeight + 12;
    return AnimatedBuilder(
      animation: _store,
      builder: (context, _) {
        final favorites = _store.favorites;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: const Text('Favorite'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            actions: [
              TextButton(onPressed: _showAddFavorite, child: const Text('+Adauga favorita')),
            ],
          ),
          body: Stack(
            children: [
              const Positioned.fill(child: FlowerBackground()),
              ListView(
                padding: EdgeInsets.fromLTRB(20, topInset, 20, 20),
                children: [
                  if (favorites.isEmpty)
                    _EmptyState(onAdd: _showAddFavorite)
                  else
                    _FavoritesGrid(
                      favorites: favorites,
                      onRemove: (label) => _store.removeFavorite(label),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FavoritesGrid extends StatelessWidget {
  final List<String> favorites;
  final Future<void> Function(String label) onRemove;
  const _FavoritesGrid({required this.favorites, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: favorites.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final info = getPlantInfo(favorites[index]);
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: (info != null ? getStatusColor(info.status) : const Color(0xFFC57AE6)).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      info != null ? getStatusLabelRo(info.status) : 'Specie',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => onRemove(favorites[index]),
                    icon: const Icon(Icons.delete_outline, size: 18, color: Color(0xFF9A7BB3)),
                    tooltip: 'Elimina din favorite',
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(
                  height: 130,
                  width: double.infinity,
                  child: Container(
                    color: const Color(0xFFF3E8FB),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.local_florist, color: Color(0xFFC57AE6)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                info?.nameRo ?? favorites[index],
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
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.favorite,
                  color: Colors.pink.shade400,
                  size: 18,
                ),
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
      borderRadius: BorderRadius.circular(12),
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

class _EmptyState extends StatelessWidget {
  final VoidCallback onAdd;
  const _EmptyState({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 14,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nu ai inca favorite', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Alege plante din catalog sau din scanari si marcheaza-le ca favorite.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 14),
          ElevatedButton(onPressed: onAdd, child: const Text('Adauga din catalog')),
        ],
      ),
    );
  }
}
