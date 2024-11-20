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

class EnemyTypes {
  static const String basic = 'basic';
  static const String zigzag = 'zigzag';
  static const String tank = 'tank';
  static const String boss = 'boss';

  // Each type of enemy has their own properties (e.g., health, speed, etc.)

  static Map<String, dynamic> getProperties(String type) {
    switch (type) {
      case basic:
        return {
          'health': 20,
          'speed': 100,
          'sprite': 'ships/enemy.png'
        };
      case zigzag:
        return {
          'health': 30,
          'speed': 150,
          'sprite': 'ships/enemy.png'
        };
      case tank:
        return {
          'health': 30,
          'speed': 50,
          'sprite': 'ships/enemy.png'
        };
      case boss:
        return {
          'health': 100,
          'speed': 50,
          'sprite': 'ships/enemy.png'
        };
      default:
        throw Exception('Unknown enemy type: $type');
    }
  }
}