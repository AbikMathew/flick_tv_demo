import 'dart:math' as math;
import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    required this.type,
    this.size = 56,
  });

  final String type;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F11),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF2C2C2E),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: CustomPaint(
        painter: _IconPainter(type: type),
      ),
    );
  }
}

class _IconPainter extends CustomPainter {
  _IconPainter({required this.type});

  final String type;

  @override
  void paint(Canvas canvas, Size size) {
    switch (type) {
      case 'tap':
        _paintTapIcon(canvas, size);
        break;
      case 'failures':
        _paintFailuresIcon(canvas, size);
        break;
      case 'refunds':
        _paintRefundsIcon(canvas, size);
        break;
      case 'gift':
        _paintGiftIcon(canvas, size);
        break;
      default:
        _paintTapIcon(canvas, size);
    }
  }

  // --- 1. SINGLE TAP ICON ---
  void _paintTapIcon(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Draw Phone body
    final phonePaint = Paint()
      ..color = const Color(0xFFE2B71B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    
    final phoneRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.15, h * 0.05, w * 0.45, h * 0.85),
      const Radius.circular(6),
    );
    canvas.drawRRect(phoneRect, phonePaint);

    // Phone home button or speaker
    final detailPaint = Paint()
      ..color = const Color(0xFFE2B71B).withOpacity(0.5)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.375, h * 0.15), 1.5, detailPaint);
    canvas.drawCircle(Offset(w * 0.375, h * 0.8), 2.5, detailPaint);

    // Hand Path (Tapping finger)
    final handPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final handPath = Path();
    // Start at bottom right
    handPath.moveTo(w * 0.9, h * 0.95);
    // Left edge of wrist
    handPath.lineTo(w * 0.65, h * 0.95);
    // Up to hand body
    handPath.lineTo(w * 0.6, h * 0.65);
    // Index finger pointing up
    handPath.lineTo(w * 0.5, h * 0.25); // Tip of index finger
    handPath.quadraticBezierTo(w * 0.525, h * 0.2, w * 0.55, h * 0.25);
    handPath.lineTo(w * 0.62, h * 0.52);
    // Folded middle finger
    handPath.lineTo(w * 0.65, h * 0.52);
    handPath.lineTo(w * 0.68, h * 0.62);
    // Folded ring finger
    handPath.lineTo(w * 0.72, h * 0.62);
    handPath.lineTo(w * 0.75, h * 0.70);
    // Thumb
    handPath.lineTo(w * 0.72, h * 0.75);
    handPath.quadraticBezierTo(w * 0.85, h * 0.78, w * 0.9, h * 0.9);
    handPath.close();

    canvas.drawPath(handPath, handPaint);

    // Tap Ripple effect (circular arcs at tap location)
    final ripplePaint = Paint()
      ..color = const Color(0xFFFF5252).withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(w * 0.52, h * 0.22), radius: 6),
      -math.pi / 2 - 0.5,
      1.0,
      false,
      ripplePaint,
    );
  }

  // --- 2. ZERO FAILURES ICON ---
  void _paintFailuresIcon(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Draw Phone body
    final phonePaint = Paint()
      ..color = const Color(0xFFE2B71B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final phoneRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.2, h * 0.15, w * 0.45, h * 0.8),
      const Radius.circular(6),
    );
    canvas.drawRRect(phoneRect, phonePaint);

    // Signal/Wifi waves at top right
    final wifiPaint = Paint()
      ..color = const Color(0xFF39A845) // Green check/signal
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    wifiPaint.strokeWidth = 2.0;
    // Outer wave
    canvas.drawArc(
      Rect.fromCircle(center: Offset(w * 0.7, h * 0.35), radius: 14),
      -math.pi,
      math.pi / 2,
      false,
      wifiPaint,
    );
    // Inner wave
    canvas.drawArc(
      Rect.fromCircle(center: Offset(w * 0.7, h * 0.35), radius: 8),
      -math.pi,
      math.pi / 2,
      false,
      wifiPaint,
    );
    // Center point
    canvas.drawCircle(Offset(w * 0.7, h * 0.35), 2, wifiPaint..style = PaintingStyle.fill);

    // Hand holding phone from left
    final handPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final handPath = Path();
    handPath.moveTo(w * 0.05, h * 0.95);
    handPath.lineTo(w * 0.3, h * 0.95);
    // Wrist up
    handPath.lineTo(w * 0.32, h * 0.65); // Thumb on phone edge
    handPath.quadraticBezierTo(w * 0.35, h * 0.6, w * 0.32, h * 0.55);
    // Wrapping fingers around side
    handPath.lineTo(w * 0.22, h * 0.45);
    handPath.lineTo(w * 0.22, h * 0.8);
    handPath.lineTo(w * 0.05, h * 0.8);
    handPath.close();

    canvas.drawPath(handPath, handPaint);
  }

  // --- 3. REAL-TIME REFUNDS ICON ---
  void _paintRefundsIcon(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Draw credit card/banknote tilted
    canvas.save();
    canvas.translate(w * 0.45, h * 0.45);
    canvas.rotate(-0.3);
    
    final cardPaint = Paint()
      ..color = const Color(0xFFE2B71B)
      ..style = PaintingStyle.fill;

    final cardRect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(-16, -10, 32, 20),
      const Radius.circular(4),
    );
    canvas.drawRRect(cardRect, cardPaint);

    // Draw credit card strip
    final stripPaint = Paint()..color = const Color(0xFF5E4B0A);
    canvas.drawRect(const Rect.fromLTWH(-16, -4, 32, 4), stripPaint);

    canvas.restore();

    // Hand lifting the card
    final handPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final handPath = Path();
    handPath.moveTo(w * 0.55, h * 0.95);
    handPath.lineTo(w * 0.8, h * 0.95);
    handPath.lineTo(w * 0.72, h * 0.65);
    handPath.lineTo(w * 0.52, h * 0.60); // finger holding card
    handPath.quadraticBezierTo(w * 0.48, h * 0.55, w * 0.46, h * 0.62);
    handPath.lineTo(w * 0.52, h * 0.75);
    handPath.close();

    canvas.drawPath(handPath, handPaint);

    // Instant circular/refund arrow on the left
    final arrowPaint = Paint()
      ..color = const Color(0xFF39A845)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final arrowRect = Rect.fromCircle(center: Offset(w * 0.22, h * 0.45), radius: 10);
    // Draw 3/4 circle
    canvas.drawArc(arrowRect, -0.5, 4.8, false, arrowPaint);

    // Arrowhead
    final headPath = Path();
    headPath.moveTo(w * 0.32, h * 0.38);
    headPath.lineTo(w * 0.35, h * 0.46);
    headPath.lineTo(w * 0.27, h * 0.48);
    canvas.drawPath(headPath, arrowPaint..style = PaintingStyle.fill);
  }

  // --- 4. GIFT CARD ICON (3D Box) ---
  void _paintGiftIcon(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Draw main gift box body (Golden gradient)
    final boxPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFE2B71B), Color(0xFFC59A14)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(w * 0.15, h * 0.35, w * 0.7, h * 0.55))
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.18, h * 0.38, w * 0.64, h * 0.52),
        const Radius.circular(4),
      ),
      boxPaint,
    );

    // Box Lid (slightly wider, gold)
    final lidPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFFD43F), Color(0xFFE2B71B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(w * 0.12, h * 0.28, w * 0.76, h * 0.12))
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.14, h * 0.28, w * 0.72, h * 0.12),
        const Radius.circular(3),
      ),
      lidPaint,
    );

    // Red Ribbon Ribbon Cross (Vertical & Horizontal)
    final ribbonPaint = Paint()
      ..color = const Color(0xFFE53935)
      ..style = PaintingStyle.fill;

    // Vertical ribbon
    canvas.drawRect(Rect.fromLTWH(w * 0.45, h * 0.28, w * 0.1, h * 0.62), ribbonPaint);
    // Horizontal ribbon on box
    canvas.drawRect(Rect.fromLTWH(w * 0.18, h * 0.58, w * 0.64, h * 0.08), ribbonPaint);

    // Beautiful Red Bow at the top
    final bowPaint = Paint()
      ..color = const Color(0xFFC62828)
      ..style = PaintingStyle.fill;

    // Left loop
    final leftLoop = Path();
    leftLoop.moveTo(w * 0.5, h * 0.28);
    leftLoop.cubicTo(w * 0.3, h * 0.05, w * 0.25, h * 0.2, w * 0.5, h * 0.26);
    canvas.drawPath(leftLoop, bowPaint);

    // Right loop
    final rightLoop = Path();
    rightLoop.moveTo(w * 0.5, h * 0.28);
    rightLoop.cubicTo(w * 0.7, h * 0.05, w * 0.75, h * 0.2, w * 0.5, h * 0.26);
    canvas.drawPath(rightLoop, bowPaint);

    // Bow Center knot
    canvas.drawCircle(Offset(w * 0.5, h * 0.27), 4.0, ribbonPaint);
  }

  @override
  bool shouldRepaint(covariant _IconPainter oldDelegate) =>
      oldDelegate.type != type;
}
