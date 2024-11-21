import 'package:flame/game.dart';
import 'package:test_project/data/move_strategies.dart';

/// Contains all the enemies that will spawn in a wave, and the delay before the wave starts.
class WaveData {
  final List<EnemyData> enemies;
  final double prewaveDelay;

  WaveData({
    required this.enemies,
    required this.prewaveDelay,
  });
}

class EnemyData {
  /// Enemy type (e.g., "basic", "zigzag", etc.).
  final String type; 
  /// Spawn position of the enemy.
  final Vector2 position;
  /// Delay before spawning the NEXT enemy relative to this one. Ignored if this is the last enemy in the wave.
  final double delay; 

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

  // Each type of enemy has their own properties (e.g., health, speed, etc.).
  /// Returns the properties of the selected enemy type (it use the static variables of this class).
  static Map<String, dynamic> getProperties(String type) {
    switch (type) {
      case basic:
        return {
          'health': 20,
          'speed': 100,
          'sprite': 'ships/enemy.png',
          'move_strategy': LinearMoveStrategy(Vector2(0, 1)),
        };
      case zigzag:
        return {
          'health': 30,
          'speed': 150,
          'sprite': 'ships/enemy.png',
          'move_strategy': LinearMoveStrategy(Vector2(0, 1)),
        };
      case tank:
        return {
          'health': 30,
          'speed': 50,
          'sprite': 'ships/enemy.png',
          'move_strategy': LinearMoveStrategy(Vector2(0, 1)),
        };
      case boss:
        return {
          'health': 100,
          'speed': 50,
          'sprite': 'ships/enemy.png',
          'move_strategy': LinearMoveStrategy(Vector2(0, 1)),
        };
      default:
        throw Exception('Unknown enemy type: $type');
    }
  }
}