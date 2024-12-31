import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class Leaf extends StatefulWidget {
  final double position;

  const Leaf({
    required this.position,
    super.key,
  });

  @override
  LeafState createState() => LeafState();
}

class LeafState extends State<Leaf> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(70, 0),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final rotation = widget.position + (_controller.value * 360);

          return Transform(
            alignment: Alignment.centerLeft,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(vector.radians(rotation)),
            child: child,
          );
        },
        child: const ChristmasLights(),
      ),
    );
  }
}

class ChristmasLights extends StatefulWidget {
  const ChristmasLights({
    super.key,
  });

  @override
  State<ChristmasLights> createState() => _ChristmasLightsState();
}

class _ChristmasLightsState extends State<ChristmasLights>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController.unbounded(vsync: this)
      ..repeat(
        min: -0.5,
        max: 1.5,
        period: const Duration(
          seconds: 2,
        ),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (Rect bounds) => LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            transform: _SlideGradientTransform(animationController.value),
            colors: const [
              Color(0xFFFEDA77),
              Color(0xFFF58529),
              Color(0xFFDD2A7B),
              Color(0xFF8134AF),
              Color(0xFF515BD4),
            ],
          ).createShader(bounds),
          child: Image.asset(
            'assets/leaves.png',
            width: 140,
            height: 400,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

class _SlideGradientTransform extends GradientTransform {
  final double percent;
  const _SlideGradientTransform(this.percent);
  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(
      0,
      bounds.height * percent,
      0,
    );
  }
}
