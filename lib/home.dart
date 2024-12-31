import 'package:flutter/material.dart';
import 'package:navidad/leaf_tree.dart';
import 'package:snow_fall_animation/snow_fall_animation.dart';

class Home extends StatelessWidget {
  final int leaves;
  const Home({
    this.leaves = 10,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navidad'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                ...List.generate(
                  leaves,
                  (index) => Leaf(
                    position: ((360 / leaves) * index),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 165,
            child: Image.asset(
              'assets/star.webp',
              width: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SnowFallAnimation(
            config: SnowfallConfig(
              numberOfSnowflakes: 200,
              speed: 1.0,
              useEmoji: true,
              customEmojis: [
                '❄️',
                '❅',
                '❆',
              ],
            ),
          ),
        ],
      ),
    );
  }
}
