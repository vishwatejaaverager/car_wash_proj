import 'package:car_wash_proj/utils/routes.dart';
import 'package:flutter/material.dart';

import 'dart:math';

class ShowerPainter extends CustomPainter {
  final double animationValue;
  final double dropSize;

  ShowerPainter({required this.animationValue, required this.dropSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.8);

    for (int i = 0; i < 100; i++) {
      final x = Random().nextDouble() * size.width;
      final y = Random().nextDouble() * size.height * animationValue;

      canvas.drawCircle(Offset(x, y), dropSize, paint);
    }
  }

  @override
  bool shouldRepaint(ShowerPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue ||
        dropSize != oldDelegate.dropSize;
  }
}

class ShowerAnimation extends StatefulWidget {
  static const id = AppRoutes.aboutScreen;

  const ShowerAnimation({super.key});
  @override
  _ShowerAnimationState createState() => _ShowerAnimationState();
}

class _ShowerAnimationState extends State<ShowerAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: ShowerPainter(animationValue: _animation.value, dropSize: 4),
          size: Size.infinite,
        );
      },
    );
  }
}
