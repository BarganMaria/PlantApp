import 'package:flutter/material.dart';
import '../widgets/flower_background.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top + kToolbarHeight + 12;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Favorite'),
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
              _FavoritesGrid(),
            ],
          ),
        ],
      ),
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



