import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanEntry {
  final String label;
  final double confidence;
  final DateTime timestamp;

  const ScanEntry({
    required this.label,
    required this.confidence,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'label': label,
        'confidence': confidence,
        'timestamp': timestamp.toIso8601String(),
      };

  factory ScanEntry.fromJson(Map<String, dynamic> json) {
    final ts = json['timestamp'] as String?;
    return ScanEntry(
      label: json['label'] as String? ?? '',
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      timestamp: ts != null ? DateTime.tryParse(ts) ?? DateTime.now() : DateTime.now(),
    );
  }
}

class PlantStore extends ChangeNotifier {
  PlantStore._();

  static final PlantStore instance = PlantStore._();

  static const _favoritesKey = 'favorites';
  static const _scansKey = 'recent_scans';

  bool _initialized = false;
  List<String> _favorites = [];
  List<ScanEntry> _recentScans = [];

  UnmodifiableListView<String> get favorites => UnmodifiableListView(_favorites);
  UnmodifiableListView<ScanEntry> get recentScans => UnmodifiableListView(_recentScans);
  bool get isReady => _initialized;

  Future<void> init() async {
    if (_initialized) return;
    final prefs = await SharedPreferences.getInstance();
    _favorites = prefs.getStringList(_favoritesKey) ?? [];
    final rawScans = prefs.getStringList(_scansKey) ?? [];
    _recentScans = rawScans
        .map((item) {
          try {
            final decoded = jsonDecode(item) as Map<String, dynamic>;
            return ScanEntry.fromJson(decoded);
          } catch (_) {
            return null;
          }
        })
        .whereType<ScanEntry>()
        .toList();
    _initialized = true;
    notifyListeners();
  }

  bool isFavorite(String label) => _favorites.contains(label);

  Future<void> addFavorite(String label) async {
    if (label.isEmpty || _favorites.contains(label)) return;
    _favorites.add(label);
    await _persistFavorites();
    notifyListeners();
  }

  Future<void> removeFavorite(String label) async {
    if (_favorites.remove(label)) {
      await _persistFavorites();
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(String label) async {
    if (isFavorite(label)) {
      await removeFavorite(label);
    } else {
      await addFavorite(label);
    }
  }

  Future<void> addScan(String label, {double confidence = 0.0}) async {
    if (label.isEmpty) return;
    final entry = ScanEntry(label: label, confidence: confidence, timestamp: DateTime.now());
    _recentScans.removeWhere((item) => item.label == label);
    _recentScans.insert(0, entry);
    if (_recentScans.length > 30) {
      _recentScans = _recentScans.take(30).toList();
    }
    await _persistScans();
    notifyListeners();
  }

  Future<void> clearScans() async {
    _recentScans.clear();
    await _persistScans();
    notifyListeners();
  }

  Future<void> _persistFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoritesKey, _favorites);
  }

  Future<void> _persistScans() async {
    final prefs = await SharedPreferences.getInstance();
    final payload = _recentScans.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(_scansKey, payload);
  }
}
