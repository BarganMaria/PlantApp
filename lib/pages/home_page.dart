import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'scan_history.dart';
import 'reminders.dart';
import 'favorites.dart';
import 'quiz.dart';
import '../widgets/weather_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherKey = dotenv.env['OPENWEATHER_API_KEY'] ?? '';
    final hasWeatherKey = weatherKey.isNotEmpty;

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
          _SectionHeader(title: 'Scanari recente', action: 'Vezi toate', onTap: () => _open(context, const ScanHistoryPage())),
          const SizedBox(height: 12),
          _HorizontalCards(items: const ['Stejar', 'Lavanda', 'Iris', 'Ienupar']),
          const SizedBox(height: 22),
          _SectionHeader(title: 'Sarcini de ingrijire azi', action: '+Adauga memento', onTap: () => _open(context, const RemindersPage())),
          const SizedBox(height: 12),
          _ReminderList(),
          const SizedBox(height: 22),
          _SectionHeader(title: 'Plantele tale preferate', action: 'Vezi toate favoritele', onTap: () => _open(context, const FavoritesPage())),
          const SizedBox(height: 12),
          _FavoritesGrid(),
          const SizedBox(height: 22),
          _QuizCard(onTap: () => _open(context, const QuizPage())),
        ],
      ),
    );
  }
}

void _open(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
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
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const Spacer(),
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

class _HorizontalCards extends StatelessWidget {
  final List<String> items;
  const _HorizontalCards({required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return Container(
            width: 140,
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
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 68,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3E8FB),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(child: Icon(Icons.local_florist, color: Color(0xFFC57AE6))),
                  ),
                  const SizedBox(height: 12),
                  Text(items[index], style: Theme.of(context).textTheme.titleLarge),
                  Text('Potrivire 95%', style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ReminderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'plant': 'Aloe Vera', 'task': 'Udare', 'time': '09:00'},
      {'plant': 'Orhidee', 'task': 'Pulverizare', 'time': '14:00'},
    ];
    return Column(
      children: items
          .map(
            (item) => Container(
              margin: const EdgeInsets.only(bottom: 10),
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
                  const Icon(Icons.water_drop, color: Color(0xFFC57AE6)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('${item['plant']} • ${item['task']}',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  Text(item['time']!, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _FavoritesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final plants = ['Mac', 'Bujor', 'Ienupar', 'Lavanda'];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: plants.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      itemBuilder: (context, index) {
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
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3E8FB),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(child: Icon(Icons.local_florist, color: Color(0xFFC57AE6))),
                ),
              ),
              const SizedBox(height: 8),
              Text(plants[index], style: Theme.of(context).textTheme.titleLarge),
              Text('Salvia officinalis', style: Theme.of(context).textTheme.bodyMedium),
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

class _QuizCard extends StatelessWidget {
  final VoidCallback onTap;
  const _QuizCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF2C94C), Color(0xFFE9A95E)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Testeaza-ti cunostintele',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: const Color(0xFF3A2F1E))),
          const SizedBox(height: 8),
          Text('Quiz zilnic disponibil',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF3A2F1E))),
          const SizedBox(height: 12),
          Text('Poti identifica aceasta floare moldoveneasca?',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF3A2F1E))),
          const SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A2F1E),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Joaca quizul'),
              ),
              const Spacer(),
              const Text('?? serie de 5 zile'),
            ],
          ),
        ],
      ),
    );
  }
}


