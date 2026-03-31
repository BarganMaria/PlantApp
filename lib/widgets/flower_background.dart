import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlowerBackground extends StatelessWidget {
  final double opacity;

  const FlowerBackground({super.key, this.opacity = 0.99});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Opacity(
        opacity: opacity,
        child: SvgPicture.asset(
          'assets/Untitled.svg',
          fit: BoxFit.cover,
          alignment: Alignment.center,
          colorFilter: ColorFilter.mode(
            const Color(0xFFC57AE6),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

