import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'identification.dart';
import '../services/plant_classifier.dart';
import '../widgets/flower_background.dart';

class ScanLoadingPage extends StatefulWidget {
  final String imagePath;

  const ScanLoadingPage({super.key, required this.imagePath});

  @override
  State<ScanLoadingPage> createState() => _ScanLoadingPageState();
}

class _ScanLoadingPageState extends State<ScanLoadingPage> {
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _runAnalysis();
  }

  Future<void> _runAnalysis() async {
    try {
      final predictions = await PlantClassifier.instance.classifyTopK(widget.imagePath, k: 3);
      final prediction = predictions.isNotEmpty ? predictions.first : null;
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => IdentificationResultsPage(
            imagePath: widget.imagePath,
            prediction: prediction,
            predictions: predictions,
          ),
        ),
      );
    } catch (e) {
      debugPrint('Plant model error: $e');
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Nu am putut rula modelul. Incearca din nou.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top + kToolbarHeight + 12;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Scanare'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: FlowerBackground()),
          Padding(
            padding: EdgeInsets.fromLTRB(20, topInset, 20, 20),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      File(widget.imagePath),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (_errorMessage == null) ...[
                  const CircularProgressIndicator(),
                  const SizedBox(height: 12),
                  const Text(
                    'Identificam planta...',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ] else ...[
                  Text(
                    _errorMessage!,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Inapoi'),
                  ),
                ],
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

