import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.22, // Tilted to match the screenshot (~-12.6 degrees)
      child: Container(
        width: 140,
        height: 110,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 24,
              offset: const Offset(4, 16),
              spreadRadius: -2,
            ),
          ],
        ),
        child: CustomPaint(painter: _WalletPainter()),
      ),
    );
  }
}

class _WalletPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // --- 1. Paint back fold (Green Pocket) ---
    final Paint backPaint = Paint()
      ..shader = AppTheme.walletBackGradient.createShader(
        Rect.fromLTWH(0, 0, w, h * 0.8),
      )
      ..style = PaintingStyle.fill;

    // Draw back cardholder shape (slightly smaller and positioned higher)
    final RRect backRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.05, h * 0.02, w * 0.88, h * 0.72),
      const Radius.circular(16),
    );
    canvas.drawRRect(backRRect, backPaint);

    // Subtle dark shadow inside the back fold for depth
    final Paint backInnerShadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(backRRect, backInnerShadowPaint);

    // --- 2. Paint front fold (Yellow/Gold body) ---
    final Paint frontPaint = Paint()
      ..shader = AppTheme.walletGradient.createShader(
        Rect.fromLTWH(0, h * 0.18, w, h * 0.8),
      )
      ..style = PaintingStyle.fill;

    // Draw front cardholder shape (shifted down, covering most of the bottom)
    final RRect frontRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, h * 0.18, w, h * 0.82),
      const Radius.circular(20),
    );
    canvas.drawRRect(frontRRect, frontPaint);

    // Highlight border for front cardholder (gold shine)
    final Paint frontHighlightPaint = Paint()
      ..color = const Color(0xFFFFE97F).withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(frontRRect, frontHighlightPaint);

    // --- 3. Draw Rupee Symbol (₹) ---
    const String rupee = '₹';
    final textPainter = TextPainter(
      text: TextSpan(
        text: rupee,
        style: TextStyle(
          fontSize: h * 0.44,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontFamily: 'Roboto', // Ensures proper Rupee symbol rendering
          shadows: [
            Shadow(
              color: Colors.black.withValues(alpha: 0.15),
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    // Position text in the center of the front fold
    final double textX = (w - textPainter.width) / 2;
    final double textY = h * 0.18 + (h * 0.82 - textPainter.height) / 2 - 2;

    // Draw the symbol slightly tilted forward or centered
    canvas.save();
    // Shift slightly to account for font offset
    canvas.translate(textX + 2, textY);
    textPainter.paint(canvas, Offset.zero);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _WalletPainter oldDelegate) => false;
}
