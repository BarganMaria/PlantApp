import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ---------------------------------------------
//  HOW TO USE
//  1. Add to pubspec.yaml:
//       dependencies:
//         http: ^1.2.1
//  2. Drop WeatherWidget anywhere in your tree:
//       WeatherWidget(city: 'Chisinau', apiKey: 'YOUR_KEY')
// ---------------------------------------------

class WeatherWidget extends StatefulWidget {
  final String city;
  final String apiKey;

  const WeatherWidget({
    super.key,
    required this.city,
    required this.apiKey,
  });

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic>? _weather;
  bool _loading = true;
  String? _error;
  late AnimationController _windController;

  @override
  void initState() {
    super.initState();
    _windController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
    _fetchWeather();
  }

  @override
  void dispose() {
    _windController.dispose();
    super.dispose();
  }

  Future<void> _fetchWeather() async {
    if (!mounted) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final url =
          'https://api.openweathermap.org/data/2.5/weather?q=${widget.city}&appid=${widget.apiKey}&units=metric';
      final res = await http.get(Uri.parse(url));
      if (!mounted) return;
      if (res.statusCode == 200) {
        setState(() {
          _weather = json.decode(res.body);
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'Oras negasit';
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Fara conexiune';
          _loading = false;
        });
      }
    }
  }

  _SceneType _scene() {
    final id = _weather?['weather']?[0]?['id'] ?? 800;
    final hour = DateTime.now().hour;
    if (hour < 6 || hour >= 20) return _SceneType.night;
    if (id >= 200 && id < 300) return _SceneType.storm;
    if (id >= 300 && id < 700) return _SceneType.rain;
    return _SceneType.sunny;
  }

  String _conditionLabel() {
    final id = _weather?['weather']?[0]?['id'] ?? 800;
    if (id >= 200 && id < 300) return 'Furtuna';
    if (id >= 300 && id < 400) return 'Burnita';
    if (id >= 500 && id < 600) return 'Ploios';
    if (id >= 600 && id < 700) return 'Ninsori';
    if (id >= 700 && id < 800) return 'Ceata';
    if (id == 800) return 'Cer senin';
    if (id == 801 || id == 802) return 'Partial noros';
    return 'Noros';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: _loading
          ? _buildLoading()
          : _error != null
              ? _buildError()
              : _buildContent(),
    );
  }

  Widget _buildLoading() {
    return Container(
      color: const Color(0xFFD4EAB0),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  Widget _buildError() {
    return Container(
      color: const Color(0xFFB8D98D),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off, color: Colors.white, size: 36),
            const SizedBox(height: 8),
            Text(_error!,
                style: const TextStyle(color: Colors.white, fontSize: 14)),
            TextButton(
              onPressed: _fetchWeather,
              child: const Text('Reincearca', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    final temp = (_weather!['main']['temp'] as num).round();
    final pressure = _weather!['main']['pressure'];
    final humidity = _weather!['main']['humidity'];
    final visibilityM = _weather!['visibility'] ?? 10000;
    final visibilityKm = (visibilityM / 1000).toStringAsFixed(1);
    final scene = _scene();

    return Stack(
      children: [
        // Moldovan landscape
        Positioned.fill(
          child: CustomPaint(
            painter: _MoldovaLandscapePainter(scene: scene),
          ),
        ),

        // Animated clouds
        AnimatedBuilder(
          animation: _windController,
          builder: (_, __) {
            final t = _windController.value;
            return Stack(
              children: [
                Positioned(
                  top: 22 + t * 6,
                  left: 60 + t * 12,
                  child: _Cloud(
                      opacity: scene == _SceneType.night ? 0.15 : 0.55,
                      scale: 1.0,
                      scene: scene),
                ),
                Positioned(
                  top: 14 - t * 4,
                  right: 20 + t * 8,
                  child: _Cloud(
                      opacity: scene == _SceneType.night ? 0.1 : 0.40,
                      scale: 0.65,
                      scene: scene),
                ),
              ],
            );
          },
        ),

        // Sun / Moon
        if (scene == _SceneType.sunny || scene == _SceneType.rain)
          Positioned(
            top: 18,
            right: 24,
            child: _SunWidget(scene: scene),
          ),
        if (scene == _SceneType.night)
          Positioned(
            top: 16,
            right: 28,
            child: _MoonWidget(),
          ),

        // Rain drops
        if (scene == _SceneType.rain || scene == _SceneType.storm)
          Positioned.fill(
            child: CustomPaint(
              painter: _RainPainter(heavy: scene == _SceneType.storm),
            ),
          ),

        // Bottom gradient for chip readability
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 80,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.0),
                  Colors.black.withValues(alpha: 0.22),
                ],
              ),
            ),
          ),
        ),

        // Content
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // City label
              Text(
                widget.city.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.2,
                  color: Colors.white.withValues(alpha: 0.9),
                  shadows: const [
                    Shadow(color: Colors.black26, blurRadius: 4)
                  ],
                ),
              ),
              const SizedBox(height: 2),

              // Temp + condition
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$temp°C',
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.05,
                      shadows: [
                        Shadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 2))
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Text(
                      _conditionLabel(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        shadows: [
                          Shadow(color: Colors.black26, blurRadius: 4)
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Stat chips
              Row(
                children: [
                  _StatChip(
                      icon: Icons.speed_rounded,
                      label: 'Presiune',
                      value: '${pressure}mb'),
                  const SizedBox(width: 8),
                  _StatChip(
                      icon: Icons.visibility_rounded,
                      label: 'Vizibilitate',
                      value: '$visibilityKm km'),
                  const SizedBox(width: 8),
                  _StatChip(
                      icon: Icons.water_drop_rounded,
                      label: 'Umiditate',
                      value: '$humidity%'),
                ],
              ),
              const SizedBox(height: 14),
            ],
          ),
        ),
      ],
    );
  }
}

// --- Scene type ------------------------------
enum _SceneType { sunny, rain, storm, night }

// --- Sun widget ------------------------------
class _SunWidget extends StatelessWidget {
  final _SceneType scene;
  const _SunWidget({required this.scene});

  @override
  Widget build(BuildContext context) {
    final color = scene == _SceneType.rain
        ? const Color(0xFFDDD8C4)
        : const Color(0xFFFFF176);
    return SizedBox(
      width: 44,
      height: 44,
      child: CustomPaint(painter: _SunPainter(color: color)),
    );
  }
}

class _SunPainter extends CustomPainter {
  final Color color;
  _SunPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    // Glow
    canvas.drawCircle(
        center,
        20,
        Paint()
          ..color = color.withValues(alpha: 0.2)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10));
    canvas.drawCircle(center, 13, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_SunPainter old) => false;
}

// --- Moon widget -----------------------------
class _MoonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: CustomPaint(painter: _MoonPainter()),
    );
  }
}

class _MoonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(c, 14, Paint()..color = const Color(0xFFE8ECBE));
    canvas.drawCircle(c.translate(6, -5), 11,
        Paint()..color = const Color(0xFF1C2A3A));
  }

  @override
  bool shouldRepaint(_MoonPainter old) => false;
}

// --- Cloud widget -----------------------------
class _Cloud extends StatelessWidget {
  final double opacity;
  final double scale;
  final _SceneType scene;

  const _Cloud({required this.opacity, required this.scale, required this.scene});

  @override
  Widget build(BuildContext context) {
    final color = scene == _SceneType.storm
        ? Color.fromRGBO(90, 100, 115, opacity)
        : scene == _SceneType.rain
            ? Color.fromRGBO(180, 190, 200, opacity)
            : Color.fromRGBO(255, 255, 255, opacity);

    return Transform.scale(
      scale: scale,
      alignment: Alignment.topLeft,
      child: SizedBox(
        width: 90,
        height: 44,
        child: CustomPaint(painter: _CloudPainter(color: color)),
      ),
    );
  }
}

class _CloudPainter extends CustomPainter {
  final Color color;
  _CloudPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = color;
    final path = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(size.width * 0.28, size.height * 0.65), radius: 18))
      ..addOval(Rect.fromCircle(
          center: Offset(size.width * 0.5, size.height * 0.42), radius: 23))
      ..addOval(Rect.fromCircle(
          center: Offset(size.width * 0.72, size.height * 0.62), radius: 17))
      ..addRect(Rect.fromLTRB(size.width * 0.15, size.height * 0.58,
          size.width * 0.86, size.height));
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(_CloudPainter old) => old.color != color;
}

// --- Rain painter -----------------------------
class _RainPainter extends CustomPainter {
  final bool heavy;
  _RainPainter({required this.heavy});

  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(13);
    final paint = Paint()
      ..color = Colors.lightBlueAccent.withValues(alpha: heavy ? 0.45 : 0.28)
      ..strokeWidth = heavy ? 1.4 : 1.0
      ..strokeCap = StrokeCap.round;
    final count = heavy ? 55 : 35;
    for (var i = 0; i < count; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height * 0.75;
      canvas.drawLine(Offset(x, y), Offset(x - 4, y + 12), paint);
    }
  }

  @override
  bool shouldRepaint(_RainPainter old) => old.heavy != heavy;
}

// --- Moldova Landscape Painter ----------------
class _MoldovaLandscapePainter extends CustomPainter {
  final _SceneType scene;
  _MoldovaLandscapePainter({required this.scene});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // -- Sky ----------------------------------
    final skyTop = switch (scene) {
      _SceneType.sunny => const Color(0xFF87CEEB),
      _SceneType.rain => const Color(0xFF8DA7BA),
      _SceneType.storm => const Color(0xFF4A5A68),
      _SceneType.night => const Color(0xFF0D1B2A),
    };
    final skyBot = switch (scene) {
      _SceneType.sunny => const Color(0xFFBDE8FF),
      _SceneType.rain => const Color(0xFFB5C7D3),
      _SceneType.storm => const Color(0xFF6A7A88),
      _SceneType.night => const Color(0xFF1C3A5E),
    };

    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [skyTop, skyBot],
        ).createShader(Rect.fromLTWH(0, 0, w, h)),
    );

    // -- Stars (night only) -------------------
    if (scene == _SceneType.night) {
      final rng = Random(99);
      final starPaint = Paint()..color = Colors.white.withValues(alpha: 0.75);
      for (var i = 0; i < 28; i++) {
        canvas.drawCircle(
          Offset(rng.nextDouble() * w, rng.nextDouble() * h * 0.52),
          rng.nextDouble() * 1.4,
          starPaint,
        );
      }
    }

    // -- Horizon mist band --------------------
    final mistColor = switch (scene) {
      _SceneType.sunny => const Color(0xFFD4EFC5).withValues(alpha: 0.55),
      _SceneType.rain => const Color(0xFFB8CCC0).withValues(alpha: 0.50),
      _SceneType.storm => const Color(0xFF8A9A95).withValues(alpha: 0.45),
      _SceneType.night => const Color(0xFF1A2E22).withValues(alpha: 0.60),
    };
    canvas.drawRect(
      Rect.fromLTRB(0, h * 0.54, w, h * 0.66),
      Paint()
        ..color = mistColor
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
    );

    // -- Far tree line (tiny silhouette) ------
    _drawTreeLine(canvas, w, h, scene);

    // -- Field — flat green -------------------
    final fieldNear = switch (scene) {
      _SceneType.sunny => const Color(0xFF6DB33F),
      _SceneType.rain => const Color(0xFF4A7A3A),
      _SceneType.storm => const Color(0xFF3A5C2E),
      _SceneType.night => const Color(0xFF1A3010),
    };
    final fieldFar = switch (scene) {
      _SceneType.sunny => const Color(0xFF8CC85A),
      _SceneType.rain => const Color(0xFF5A8A48),
      _SceneType.storm => const Color(0xFF486A38),
      _SceneType.night => const Color(0xFF243818),
    };

    // Far field strip
    canvas.drawRect(
      Rect.fromLTRB(0, h * 0.60, w, h * 0.72),
      Paint()..color = fieldFar,
    );
    // Near field
    canvas.drawRect(
      Rect.fromLTRB(0, h * 0.72, w, h),
      Paint()..color = fieldNear,
    );

    // -- Crop rows (perspective lines) --------
    _drawCropRows(canvas, w, h, scene);

    // -- Sunflowers (only sunny / near-bottom) --
    if (scene == _SceneType.sunny || scene == _SceneType.rain) {
      _drawSunflowers(canvas, w, h, scene);
    }

    // -- Lone oak / willow tree right side ----
    _drawLoneTree(canvas, Offset(w * 0.85, h * 0.73), h * 0.28, scene);

    // -- Dirt path ----------------------------
    _drawPath(canvas, w, h, scene);
  }

  // -- Tree line on horizon -----------------
  void _drawTreeLine(Canvas canvas, double w, double h, _SceneType scene) {
    final color = switch (scene) {
      _SceneType.sunny => const Color(0xFF4A8A30).withValues(alpha: 0.55),
      _SceneType.rain => const Color(0xFF3A6828).withValues(alpha: 0.45),
      _SceneType.storm => const Color(0xFF2A4820).withValues(alpha: 0.50),
      _SceneType.night => const Color(0xFF0E1E0A).withValues(alpha: 0.70),
    };
    final rng = Random(17);
    final paint = Paint()..color = color;
    for (var i = 0; i < 22; i++) {
      final x = (w / 22) * i + rng.nextDouble() * 10;
      final treeH = 14.0 + rng.nextDouble() * 12;
      final treeW = 7.0 + rng.nextDouble() * 5;
      final base = h * 0.60;
      // Trunk
      canvas.drawRect(
        Rect.fromLTWH(x - 1, base - treeH * 0.4, 2, treeH * 0.42),
        paint,
      );
      // Canopy oval
      canvas.drawOval(
        Rect.fromCenter(
            center: Offset(x, base - treeH * 0.55),
            width: treeW,
            height: treeH * 0.7),
        paint,
      );
    }
  }

  // -- Perspective crop rows -----------------
  void _drawCropRows(Canvas canvas, double w, double h, _SceneType scene) {
    final color = switch (scene) {
      _SceneType.sunny => const Color(0xFF52961E).withValues(alpha: 0.45),
      _SceneType.rain => const Color(0xFF3A6818).withValues(alpha: 0.40),
      _SceneType.storm => const Color(0xFF2A4810).withValues(alpha: 0.45),
      _SceneType.night => const Color(0xFF102008).withValues(alpha: 0.55),
    };
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.2;

    const vp = Offset(0.5, 0.0); // vanishing point (centre horizon)
    const numRows = 10;
    for (var i = 0; i <= numRows; i++) {
      final t = i / numRows;
      final bx = w * t;
      final by = h;
      final tx = w * (vp.dx + (t - vp.dx) * 0.15);
      final ty = h * 0.72;
      canvas.drawLine(Offset(bx, by), Offset(tx, ty), paint);
    }
  }

  // -- Sunflowers ---------------------------
  void _drawSunflowers(Canvas canvas, double w, double h, _SceneType scene) {
    final positions = [
      Offset(w * 0.04, h * 0.78),
      Offset(w * 0.12, h * 0.82),
      Offset(w * 0.20, h * 0.76),
      Offset(w * 0.30, h * 0.80),
    ];

    for (final pos in positions) {
      _drawSunflower(canvas, pos, scene);
    }
  }

  void _drawSunflower(Canvas canvas, Offset base, _SceneType scene) {
    final stemColor = scene == _SceneType.sunny
        ? const Color(0xFF3A7020)
        : const Color(0xFF2A5015);
    final petalColor = scene == _SceneType.sunny
        ? const Color(0xFFFFCC00)
        : const Color(0xFFB89800);
    final centerColor = const Color(0xFF5C3A10);

    final stemH = 22.0;
    // Stem
    canvas.drawLine(
      base,
      base.translate(0, -stemH),
      Paint()
        ..color = stemColor
        ..strokeWidth = 2.2
        ..strokeCap = StrokeCap.round,
    );

    final head = base.translate(0, -stemH);
    // Petals
    final petalPaint = Paint()..color = petalColor;
    for (var i = 0; i < 8; i++) {
      final angle = i * pi / 4;
      final px = head.dx + cos(angle) * 7;
      final py = head.dy + sin(angle) * 7;
      canvas.drawCircle(Offset(px, py), 4, petalPaint);
    }
    // Centre
    canvas.drawCircle(head, 5, Paint()..color = centerColor);
  }

  // -- Lone tree ----------------------------
  void _drawLoneTree(Canvas canvas, Offset base, double size, _SceneType scene) {
    final trunkColor = switch (scene) {
      _SceneType.sunny => const Color(0xFF7A5230),
      _SceneType.rain => const Color(0xFF5A3820),
      _SceneType.storm => const Color(0xFF3A2010),
      _SceneType.night => const Color(0xFF1A0C04),
    };
    final leafColor = switch (scene) {
      _SceneType.sunny => const Color(0xFF3A8020),
      _SceneType.rain => const Color(0xFF2A5E18),
      _SceneType.storm => const Color(0xFF1A3C10),
      _SceneType.night => const Color(0xFF0E1E08),
    };

    // Trunk
    canvas.drawRect(
      Rect.fromLTWH(base.dx - 5, base.dy - size * 0.55, 10, size * 0.58),
      Paint()..color = trunkColor,
    );
    // Canopy — wide spreading oak
    canvas.drawOval(
      Rect.fromCenter(
          center: base.translate(0, -size * 0.68),
          width: size * 0.9,
          height: size * 0.6),
      Paint()..color = leafColor,
    );
    // Slightly lighter highlight blob
    canvas.drawOval(
      Rect.fromCenter(
          center: base.translate(-size * 0.1, -size * 0.75),
          width: size * 0.45,
          height: size * 0.28),
      Paint()..color = leafColor.withValues(alpha: 0.5),
    );
  }

  // -- Dirt path ----------------------------
  void _drawPath(Canvas canvas, double w, double h, _SceneType scene) {
    final color = switch (scene) {
      _SceneType.sunny => const Color(0xFFD4A86A).withValues(alpha: 0.6),
      _SceneType.rain => const Color(0xFFA07840).withValues(alpha: 0.55),
      _SceneType.storm => const Color(0xFF806030).withValues(alpha: 0.50),
      _SceneType.night => const Color(0xFF402808).withValues(alpha: 0.60),
    };

    final path = Path()
      ..moveTo(w * 0.44, h)
      ..lineTo(w * 0.56, h)
      ..lineTo(w * 0.53, h * 0.72)
      ..lineTo(w * 0.47, h * 0.72)
      ..close();

    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_MoldovaLandscapePainter old) => old.scene != scene;
}

// --- Stat chip -------------------------------
class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatChip({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.22),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 11, color: Colors.white70),
                const SizedBox(width: 4),
                Text(label,
                    style: const TextStyle(
                        fontSize: 9,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 2),
            Text(value,
                style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

