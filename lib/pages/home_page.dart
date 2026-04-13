import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../data/plant_info.dart';
import '../data/plant_store.dart';
import '../widgets/plant_picker_sheet.dart';
import '../widgets/weather_widget.dart';
import 'favorites.dart';
import 'scan_history.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PlantStore _store = PlantStore.instance;

  void _open(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  void _showAddFavorite() {
    showPlantPickerSheet(
      context: context,
      selected: _store.favorites.toSet(),
      title: 'Adauga in favorite',
      onSelected: (label) => _store.addFavorite(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    final weatherKey = dotenv.env['OPENWEATHER_API_KEY'] ?? '';
    final hasWeatherKey = weatherKey.isNotEmpty;

    return AnimatedBuilder(
      animation: _store,
      builder: (context, _) {
        final favorites = _store.favorites;
        final recentScans = _store.recentScans;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Identificare plante'),
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              if (hasWeatherKey)
                WeatherWidget(
                  city: 'Chisinau',
                  apiKey: weatherKey,
                )
              else
                const _MissingKeyCard(
                  title: 'Vreme indisponibila',
                  message: 'Adauga OPENWEATHER_API_KEY in .env pentru a activa vremea.',
                ),
              const SizedBox(height: 20),
              _SectionHeader(
                title: 'Scanari recente',
                action: 'Vezi toate',
                onTap: () => _open(context, const ScanHistoryPage()),
              ),
              const SizedBox(height: 12),
              _RecentScans(
                scans: recentScans,
                favorites: favorites.toSet(),
                onFavorite: _store.addFavorite,
              ),
              const SizedBox(height: 22),
              _SectionHeader(title: 'Plantele tale preferate', action: 'Adauga favorita', onTap: _showAddFavorite),
              const SizedBox(height: 12),
              if (favorites.isEmpty)
                const Text('Inca nu ai adaugat favorite.', style: TextStyle(color: Color(0xFF6C6C6C)))
              else
                _FavoritesGrid(favorites: favorites),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => _open(context, const FavoritesPage()),
                child: const Text('Deschide lista completa'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String action;
  final VoidCallback onTap;

  const _SectionHeader({
    required this.title,
    required this.action,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        TextButton(onPressed: onTap, child: Text(action)),
      ],
    );
  }
}

class _MissingKeyCard extends StatelessWidget {
  final String title;
  final String message;

  const _MissingKeyCard({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFFEFF2F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 6),
            Text(message, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _RecentScans extends StatelessWidget {
  final List<ScanEntry> scans;
  final Set<String> favorites;
  final Future<void> Function(String label)? onFavorite;
  const _RecentScans({required this.scans, required this.favorites, this.onFavorite});

  @override
  Widget build(BuildContext context) {
    if (scans.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 14,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.camera_alt_outlined, color: Color(0xFFC57AE6)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Nu exista scanari recente. Incearca un scan nou pentru a popula lista.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      height: 230,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: scans.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final scan = scans[index];
          final info = getPlantInfo(scan.label);
          final image = info?.imageAssets.first ?? 'assets/plant_icon.jpg';
          final confidence = (scan.confidence * 100).clamp(0, 100).toStringAsFixed(0);
          final timestamp = _formatTime(scan.timestamp);
          final isFavorite = favorites.contains(scan.label);
          return Container(
            width: 165,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x11000000),
                  blurRadius: 18,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        width: double.infinity,
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
                    info?.nameRo ?? scan.label,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    info?.latin ?? '',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    timestamp,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: const Color(0xFF666666)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final isToday = now.year == time.year && now.month == time.month && now.day == time.day;
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    if (isToday) return 'Azi • $h:$m';
    return '${time.day.toString().padLeft(2, '0')}.${time.month.toString().padLeft(2, '0')} • $h:$m';
  }
}

class _FavoritesGrid extends StatelessWidget {
  final List<String> favorites;

  const _FavoritesGrid({required this.favorites});

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
              const Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.favorite, color: Color(0xFFE17BCB), size: 18),
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
