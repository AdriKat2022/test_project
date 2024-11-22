import 'package:flame/game.dart';
import 'package:test_project/data/wave_data.dart';

class WavesDataContainer {

  // Wave Data list.
  static final List<WaveData> wavePattern_1 = [
    WaveData(
      enemies: [
        // Zigzag pattern with increasing delay
        EnemyData(type: EnemyTypes.zigzag, position: Vector2(100, -50), delay: 0),
        EnemyData(type: EnemyTypes.zigzag, position: Vector2(200, -50), delay: 0.5),
        EnemyData(type: EnemyTypes.zigzag, position: Vector2(300, -50), delay: 1),
        EnemyData(type: EnemyTypes.zigzag, position: Vector2(400, -50), delay: 1.5),
        EnemyData(type: EnemyTypes.zigzag, position: Vector2(500, -50), delay: 2),
        // Tanks for a challenge
        EnemyData(type: EnemyTypes.tank, position: Vector2(600, -50), delay: 2.5),
        EnemyData(type: EnemyTypes.tank, position: Vector2(700, -50), delay: 2.5),
      ],
      prewaveDelay: 5,
    ),
    WaveData(
      enemies: [
        // Alternating basic and zigzag enemies
        EnemyData(type: EnemyTypes.basic, position: Vector2(150, -50), delay: 0),
        EnemyData(type: EnemyTypes.zigzag, position: Vector2(250, -50), delay: 0.5),
        EnemyData(type: EnemyTypes.basic, position: Vector2(350, -50), delay: 1),
        EnemyData(type: EnemyTypes.zigzag, position: Vector2(450, -50), delay: 1.5),
        EnemyData(type: EnemyTypes.basic, position: Vector2(550, -50), delay: 2),
        EnemyData(type: EnemyTypes.zigzag, position: Vector2(650, -50), delay: 2.5),
        // Strong tank at the end
        EnemyData(type: EnemyTypes.tank, position: Vector2(300, -50), delay: 3),
      ],
      prewaveDelay: 6,
    ),
    WaveData(
      enemies: [
        // Line of basic enemies, faster spawning
        EnemyData(type: EnemyTypes.basic, position: Vector2(100, -50), delay: 0),
        EnemyData(type: EnemyTypes.basic, position: Vector2(200, -50), delay: 0.2),
        EnemyData(type: EnemyTypes.basic, position: Vector2(300, -50), delay: 0.4),
        EnemyData(type: EnemyTypes.basic, position: Vector2(400, -50), delay: 0.6),
        EnemyData(type: EnemyTypes.basic, position: Vector2(500, -50), delay: 0.8),
        // Followed by zigzag enemies
        EnemyData(type: EnemyTypes.zigzag, position: Vector2(150, -50), delay: 1),
        EnemyData(type: EnemyTypes.zigzag, position: Vector2(250, -50), delay: 1.2),
        EnemyData(type: EnemyTypes.zigzag, position: Vector2(350, -50), delay: 1.4),
        // Tanks spread out
        EnemyData(type: EnemyTypes.tank, position: Vector2(450, -50), delay: 3),
        EnemyData(type: EnemyTypes.tank, position: Vector2(550, -50), delay: 3.5),
      ],
      prewaveDelay: 7,
    ),
    WaveData(
      enemies: [
        // V-formation attack
        EnemyData(type: EnemyTypes.basic, position: Vector2(200, -50), delay: 0),
        EnemyData(type: EnemyTypes.basic, position: Vector2(300, -50), delay: 0),
        EnemyData(type: EnemyTypes.basic, position: Vector2(400, -50), delay: 0),
        EnemyData(type: EnemyTypes.basic, position: Vector2(500, -50), delay: 0),
        EnemyData(type: EnemyTypes.basic, position: Vector2(300, -50), delay: 1),
        EnemyData(type: EnemyTypes.basic, position: Vector2(400, -50), delay: 1),
        EnemyData(type: EnemyTypes.tank, position: Vector2(350, -50), delay: 2),
        // Sneaky zigzag backup
        EnemyData(type: EnemyTypes.zigzag, position: Vector2(250, -50), delay: 2.5),
        EnemyData(type: EnemyTypes.zigzag, position: Vector2(450, -50), delay: 2.5),
      ],
      prewaveDelay: 8,
    ),
    WaveData(
      enemies: [
        // Boss-style tank rush
        EnemyData(type: EnemyTypes.tank, position: Vector2(300, -50), delay: 0),
        EnemyData(type: EnemyTypes.tank, position: Vector2(400, -50), delay: 1),
        EnemyData(type: EnemyTypes.tank, position: Vector2(500, -50), delay: 2),
        EnemyData(type: EnemyTypes.tank, position: Vector2(600, -50), delay: 3),
        // Basic enemies as distractions
        EnemyData(type: EnemyTypes.basic, position: Vector2(200, -50), delay: 4),
        EnemyData(type: EnemyTypes.basic, position: Vector2(100, -50), delay: 4.5),
        EnemyData(type: EnemyTypes.basic, position: Vector2(300, -50), delay: 5),
        EnemyData(type: EnemyTypes.basic, position: Vector2(400, -50), delay: 5.5),
        EnemyData(type: EnemyTypes.basic, position: Vector2(500, -50), delay: 6),
      ],
      prewaveDelay: 10,
    ),
  ];
}