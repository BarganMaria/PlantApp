import 'package:flutter/material.dart';
import '../widgets/flower_background.dart';

class CameraScannerPage extends StatelessWidget {
  const CameraScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: FlowerBackground()),
          Container(color: Colors.black.withValues(alpha: 0.88)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back, color: Colors.white)),
                      const Spacer(),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.flash_on, color: Colors.white)),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.info_outline, color: Colors.white)),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 260,
                    height: 360,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white70, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text('Centreaza planta in cadru', style: TextStyle(color: Colors.white70)),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.photo, color: Colors.white)),
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white70, width: 4),
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.highlight, color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Atinge pentru foto sau tine apasat pentru identificare video', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



