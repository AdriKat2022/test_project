// In a wave, enemies are spawned in a sequence, with a delay between each enemy, it should be data driven.

import 'package:flame/components.dart';
import 'package:test_project/space_shooter_game.dart';
import 'package:test_project/components/enemy.dart';
import 'package:test_project/utils/object_pool.dart';
import 'package:test_project/data/wave_data.dart';

class Wave extends Component with HasGameReference<SpaceShooterGame> {
  final ObjectPool<Enemy> enemyPool;
  final List<WaveData> waveDataList;

  double timeSinceWaveStarted = 0;
  double nextEnemyTime = 0;

  int currentWaveIndex = 0;
  bool isWaveActive = false;

  Wave({
    required this.enemyPool,
    required this.waveDataList,
  });

  @override
  void update(double dt) {
    super.update(dt);

    if (currentWaveIndex >= waveDataList.length) return; // No more waves

    final currentWave = waveDataList[currentWaveIndex];

    // Pre-wave delay
    if (!isWaveActive) {
      timeSinceWaveStarted += dt;
      if (timeSinceWaveStarted >= currentWave.prewaveDelay) {
        isWaveActive = true;
        timeSinceWaveStarted = 0;
        nextEnemyTime = 0;
      }
      return;
    }

    nextEnemyTime -= dt;

    // Spawn enemies at defined intervals
    if (nextEnemyTime <= 0) {

      // Check if there are more enemies to spawn
      if (currentWave.enemies.isNotEmpty) {
        // Spawn enemies while the next enemy time is less than or equal to 0 (meaning no delay in the wave data)
        while(nextEnemyTime <= 0 && currentWave.enemies.isNotEmpty) {
          spawnNextEnemy(currentWave);
        }
      }
      else {
        // No more enemies, wave is complete
        isWaveActive = false;
        currentWaveIndex++;
      }
    }
  }

  // Spawn the next enemy in the wave and set the delay for the next enemy
  void spawnNextEnemy(WaveData currentWave) {
    // Spawn the next enemy in the wave
    final enemyData = currentWave.enemies.removeAt(0);

    // For now just print the enemy type
    print("spawning enemy " + enemyData.type + " at " + enemyData.position.toString() + "(delay of " + enemyData.delay.toString() + ")");

    // Spawn the enemy using the pool
    final enemy = enemyPool.getObject();
    if (enemy != null) {
      print("enemy spawned successfully (identity: " + identityHashCode(enemy).toString() + ")");
      enemy.position = enemyData.position;
      enemy.reset();
      game.add(enemy);
    }

    nextEnemyTime = enemyData.delay;
  }
}
