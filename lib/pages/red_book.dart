import 'package:flutter/material.dart';
import '../widgets/flower_background.dart';

class RedBookPage extends StatefulWidget {
  const RedBookPage({super.key});

  @override
  State<RedBookPage> createState() => _RedBookPageState();
}

class _RedBookPageState extends State<RedBookPage> {
  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top + kToolbarHeight + 12;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Cartea Rosie a Moldovei'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: FlowerBackground()),
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: topInset)),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverToBoxAdapter(child: _HeaderBanner()),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 14)),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Despre Cartea Rosie a Moldovei',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF5C5C5C)),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cartea Rosie a Moldovei este o lista oficiala cu specii rare si pe cale de disparitie de plante si animale. Este folosita pentru a monitoriza biodiversitatea si a proteja speciile aflate in risc de extinctie.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'Statut de conservare',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Fiecare planta primeste un statut in functie de riscul de extinctie, similar cu sistemul folosit de Uniunea Internationala pentru Conservarea Naturii (IUCN):',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10),
                      const _StatusLine(label: 'CR (Critic in pericol)', description: 'risc extrem de extinctie'),
                      const _StatusLine(label: 'EN (In pericol)', description: 'risc foarte ridicat de extinctie'),
                      const _StatusLine(label: 'VU (Vulnerabil)', description: 'risc ridicat de extinctie'),
                      const SizedBox(height: 18),
                      Text(
                        'De ce conteaza',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Aceste categorii ajuta la identificarea speciilor care au nevoie de protectie urgenta si ghideaza eforturile de conservare.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: null,
    );
  }
}

class _HeaderBanner extends StatelessWidget {
  const _HeaderBanner();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 260,
            width: double.infinity,
            child: Image.asset(
              'assets/tutorial_image_4.png',
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusLine extends StatelessWidget {
  final String label;
  final String description;
  const _StatusLine({required this.label, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('-  ', style: TextStyle(height: 1.5)),
          Expanded(
            child: Text(
              '$label — $description',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpeciesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(child: SizedBox.shrink());
  }
}

class RedBookDetailPage extends StatelessWidget {
  const RedBookDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalii specie')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: const Color(0xFFFCE8F7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(child: Icon(Icons.local_florist, size: 90, color: Color(0xFFE17BCB))),
          ),
          const SizedBox(height: 16),
          Text('Lalea de stepa', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 6),
          Text('Statut de conservare: Pe cale de disparitie', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16),
          _InfoSection(title: 'Descriere si identificare', content: 'Petale distincte si frunze inguste.'),
          _InfoSection(title: 'Distributie in Moldova', content: 'Placeholder pentru harta interactiva.'),
          _InfoSection(title: 'Habitat si ecologie', content: 'Stepe si pajisti deschise.'),
          _InfoSection(title: 'Amenintari', content: 'Pierderea habitatului, suprapasunat.'),
          _InfoSection(title: 'Masuri de conservare', content: 'Zone protejate si monitorizare.'),
          _InfoSection(title: 'Protectie legala', content: 'Inclusa in legislatia nationala de conservare.'),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE17BCB), foregroundColor: Colors.white),
            child: const Text('Raporteaza observatie'),
          ),
        ],
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String title;
  final String content;
  const _InfoSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(content, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}









