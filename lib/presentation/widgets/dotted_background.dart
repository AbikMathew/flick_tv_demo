import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class DottedBackground extends StatelessWidget {
  const DottedBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Base Gradient Background
        Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.backgroundGradient,
          ),
        ),
        // 2. Radial glow at the top center
        Positioned(
          top: -100,
          left: 0,
          right: 0,
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.yellow.withValues(alpha: 0.02),
              boxShadow: [
                BoxShadow(
                  color: Colors.yellow.withValues(alpha: 0.08),
                  blurRadius: 150,
                  spreadRadius: 80,
                ),
              ],
            ),
          ),
        ),
        // 3. Halftone Dots Grid
        Positioned.fill(child: CustomPaint(painter: _HalftoneDotsPainter())),
        // 4. Content
        child,
      ],
    );
  }
}

class _HalftoneDotsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFC0A040)
          .withValues(alpha: 0.2) // Goldish dots
      ..style = PaintingStyle.fill;

    const double spacing = 12.0;
    final int rows = (size.height * 0.35 / spacing).ceil();
    final int cols = (size.width / spacing).ceil();

    for (int r = 0; r < rows; r++) {
      final double y = r * spacing;

      // Opacity calculation based on depth (vertical fade)
      // Dots at the top (y = 0) are most visible, fading to 0 at size.height * 0.35
      final double verticalFactor = 1.0 - (y / (size.height * 0.35));
      if (verticalFactor <= 0) continue;

      for (int c = 0; c < cols; c++) {
        final double x = c * spacing;

        // Add a subtle wave or radial glow influence to the opacity
        final double dx = x - (size.width / 2);
        final double distanceToCenterTop = math.sqrt(dx * dx + y * y);
        final double radialFactor = math.max(
          0.0,
          1.0 - (distanceToCenterTop / (size.width * 0.9)),
        );

        final double opacity =
            0.25 * verticalFactor * (0.3 + 0.7 * radialFactor);

        if (opacity > 0.01) {
          paint.color = const Color(0xFFE2B71B).withValues(alpha: opacity);

          // Outer dots are smaller, central top dots are slightly larger
          final double dotRadius = 1.0 + 0.6 * verticalFactor * radialFactor;

          canvas.drawCircle(Offset(x, y), dotRadius, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _HalftoneDotsPainter oldDelegate) => false;
}
