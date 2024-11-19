import 'package:flame/game.dart';

class WaveData {
  final List<EnemyData> enemies;
  final double prewaveDelay;

  WaveData({
    required this.enemies,
    required this.prewaveDelay,
  });
}

class EnemyData {
  final String type; // Enemy type (e.g., "basic", "zigzag", etc.)
  final Vector2 position; // Spawn position
  final double delay; // Delay before spawning the NEXT enemy relative to this one (if this is the first enemy, it's the delay from the start of the wave)

  EnemyData({
    required this.type,
    required this.position,
    required this.delay,
  });
}
