import 'package:flutter/material.dart';
import '../widgets/flower_background.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top + kToolbarHeight + 12;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Exploreaza'),
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
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Cauta plante dupa nume sau familie...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ExpansionTile(
                title: const Text('Filtre avansate'),
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      Chip(label: Text('Tip frunza: simpla')),
                      Chip(label: Text('Culoare floare: galben')),
                      Chip(label: Text('Tip crestere: arbore')),
                      Chip(label: Text('Statut nativ')),
                      Chip(label: Text('Statut Cartea Rosie')),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _SearchResults(),
            ],
          ),
        ],
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final results = ['Mac de camp', 'Trandafir salbatic', 'Mesteacan argintiu'];
    return Column(
      children: results
          .map(
            (name) => Container(
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
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3E8FB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.local_florist, color: Color(0xFFC57AE6)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: Theme.of(context).textTheme.titleLarge),
                        Text('Nume stiintific', style: Theme.of(context).textTheme.bodyMedium),
                        const Text('Potrivire: 92%'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

