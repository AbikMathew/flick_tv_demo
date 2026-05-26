import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ConfettiOverlay extends StatefulWidget {
  const ConfettiOverlay({
    super.key,
    required this.child,
    this.triggerOnStart = true,
  });

  final Widget child;
  final bool triggerOnStart;

  @override
  State<ConfettiOverlay> createState() => ConfettiOverlayState();
}

class ConfettiOverlayState extends State<ConfettiOverlay> with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  final List<_Particle> _particles = [];
  final math.Random _random = math.Random();
  
  Duration _lastElapsed = Duration.zero;
  Size _screenSize = Size.zero;

  static const List<Color> _confettiColors = [
    Color(0xFF39A845), // Green
    Color(0xFFE2B71B), // Gold
    Color(0xFFFF5252), // Red
    Color(0xFF29B6F6), // Light Blue
    Color(0xFFAB47BC), // Purple
    Color(0xFFEC407A), // Pink
    Color(0xFF00E676), // Neon Green
  ];

  @override
  void initState() {
    super.initState();
    // Initialize ticker to drive particle updates
    _ticker = createTicker(_onTick);
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void burst() {
    if (_screenSize == Size.zero) return;
    
    _particles.clear();
    _lastElapsed = Duration.zero;

    final int countPerSide = 65; // High particle count for dense festive feel

    // 1. Left Emitter: shoots upward and to the right
    final double leftX = 0;
    final double leftY = _screenSize.height;
    for (int i = 0; i < countPerSide; i++) {
      // Launch angle: between -65 and -20 degrees (in radians)
      final double angle = -math.pi / 2.8 + (_random.nextDouble() * 0.5 - 0.25);
      final double speed = 700 + _random.nextDouble() * 750; // pixels per second
      _particles.add(_generateParticle(leftX, leftY, angle, speed));
    }

    // 2. Right Emitter: shoots upward and to the left
    final double rightX = _screenSize.width;
    final double rightY = _screenSize.height;
    for (int i = 0; i < countPerSide; i++) {
      // Launch angle: between -160 and -115 degrees (in radians)
      final double angle = -math.pi / 1.55 + (_random.nextDouble() * 0.5 - 0.25);
      final double speed = 700 + _random.nextDouble() * 750;
      _particles.add(_generateParticle(rightX, rightY, angle, speed));
    }

    if (!_ticker.isTicking) {
      _ticker.start();
    }
  }

  _Particle _generateParticle(double startX, double startY, double angle, double speed) {
    final double sizeWidth = 6.0 + _random.nextDouble() * 8.0;
    final double sizeHeight = 10.0 + _random.nextDouble() * 8.0;

    return _Particle(
      x: startX,
      y: startY,
      vx: math.cos(angle) * speed,
      vy: math.sin(angle) * speed,
      gravity: 550.0 + _random.nextDouble() * 250.0, // Natural fall acceleration
      drag: 0.965 + _random.nextDouble() * 0.02,     // Air resistance
      angle: _random.nextDouble() * math.pi * 2,
      angularVelocity: (_random.nextDouble() * 10 - 5),
      scaleY: _random.nextDouble() * 2 - 1,
      scaleVelocity: 4.0 + _random.nextDouble() * 6.0,
      color: _confettiColors[_random.nextInt(_confettiColors.length)],
      width: sizeWidth,
      height: sizeHeight,
      horizontalDriftFrequency: 1.0 + _random.nextDouble() * 2.0,
      horizontalDriftAmplitude: 15.0 + _random.nextDouble() * 25.0,
      driftOffset: _random.nextDouble() * math.pi * 2,
    );
  }

  void _onTick(Duration elapsed) {
    if (_lastElapsed == Duration.zero) {
      _lastElapsed = elapsed;
      return;
    }

    final double dt = (elapsed.inMicroseconds - _lastElapsed.inMicroseconds) / 1000000.0;
    _lastElapsed = elapsed;

    bool allDead = true;

    for (final particle in _particles) {
      // Apply gravity to vertical velocity
      particle.vy += particle.gravity * dt;

      // Apply air resistance/drag to both components of velocity
      particle.vx *= math.pow(particle.drag, dt * 60);
      particle.vy *= math.pow(particle.drag, dt * 60);

      // Update positions
      particle.x += particle.vx * dt;
      particle.y += particle.vy * dt;

      // Add a horizontal waving/swaying wind motion to falling particles
      final double totalSeconds = elapsed.inMilliseconds / 1000.0;
      final double sway = math.sin(totalSeconds * particle.horizontalDriftFrequency + particle.driftOffset) * 
          particle.horizontalDriftAmplitude * dt;
      particle.x += sway;

      // Update 2D rotation
      particle.angle += particle.angularVelocity * dt;

      // Update 3D flipping simulation scale (scales height from -1.0 to 1.0)
      particle.scaleY += particle.scaleVelocity * dt;
      if (particle.scaleY.abs() > 1.0) {
        particle.scaleVelocity = -particle.scaleVelocity;
        particle.scaleY = particle.scaleY.clamp(-1.0, 1.0);
      }

      // Check if particle is still on screen (bottom margin is expanded to let them clear screen)
      if (particle.y < _screenSize.height + 50) {
        allDead = false;
      }
    }

    if (allDead) {
      _ticker.stop();
      _particles.clear();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final newSize = Size(constraints.maxWidth, constraints.maxHeight);
        if (_screenSize != newSize) {
          _screenSize = newSize;
          if (widget.triggerOnStart && _particles.isEmpty) {
            // Delay burst slightly so UI layout stabilizes and looks natural
            WidgetsBinding.instance.addPostFrameCallback((_) {
              burst();
            });
          }
        }

        return Stack(
          children: [
            widget.child,
            // Draw confetti overlay inside a RepaintBoundary for maximum repaint performance
            if (_particles.isNotEmpty)
              Positioned.fill(
                child: IgnorePointer(
                  child: RepaintBoundary(
                    child: CustomPaint(
                      painter: _ConfettiPainter(particles: _particles),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _Particle {
  _Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.gravity,
    required this.drag,
    required this.angle,
    required this.angularVelocity,
    required this.scaleY,
    required this.scaleVelocity,
    required this.color,
    required this.width,
    required this.height,
    required this.horizontalDriftFrequency,
    required this.horizontalDriftAmplitude,
    required this.driftOffset,
  });

  double x;
  double y;
  double vx;
  double vy;
  final double gravity;
  final double drag;
  double angle;
  final double angularVelocity;
  double scaleY;
  double scaleVelocity;
  final Color color;
  final double width;
  final double height;
  final double horizontalDriftFrequency;
  final double horizontalDriftAmplitude;
  final double driftOffset;
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter({required this.particles});

  final List<_Particle> particles;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;

    for (final p in particles) {
      // Skip out-of-bound coordinates
      if (p.x < -20 || p.x > size.width + 20 || p.y > size.height + 20) {
        continue;
      }

      canvas.save();
      
      // Move to particle coordinate
      canvas.translate(p.x, p.y);
      
      // Apply 2D rotation
      canvas.rotate(p.angle);
      
      // Apply 3D flip (height scale)
      canvas.scale(1.0, p.scaleY);

      // Draw particle shape
      paint.color = p.color;
      
      // Draw rectangular flake
      canvas.drawRect(
        Rect.fromLTWH(-p.width / 2, -p.height / 2, p.width, p.height),
        paint,
      );
      
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => true;
}
