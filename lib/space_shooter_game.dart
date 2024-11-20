import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:test_project/components/enemy.dart';
import 'package:test_project/components/wave.dart';
import 'package:test_project/components/player.dart';
import 'package:test_project/data/wave_data.dart';
import 'package:test_project/ui/button.dart';
import 'package:test_project/utils/object_pool.dart';

class SpaceShooterGame extends FlameGame with PanDetector, HasCollisionDetection {

  late Player player;

  @override
  Future<void> onLoad() async {
    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData('backgrounds/background_placeholder.png'),
        ParallaxImageData('backgrounds/stars_1.png'),
        ParallaxImageData('backgrounds/stars_2.png'),
      ],
      baseVelocity: Vector2(0, -5),
      repeat: ImageRepeat.repeat,
      velocityMultiplierDelta: Vector2(0, 4),
    );
    add(parallax);

    player = Player();
    add(player);

    // Create the enemy pool (could be moved into a LEVEL class)
    final enemyPool = ObjectPool<Enemy>(
      maxSize: 20,
      createObjectFunction: () => Enemy(),
    );

    // Add the waves
    add(Wave(enemyPool: enemyPool, waveDataList: [
      WaveData(
        enemies: [
          // 3 enemies in line
          EnemyData(type: 'basic', position: Vector2(100, -50), delay: 0),
          EnemyData(type: 'basic', position: Vector2(200, -50), delay: 0),
          EnemyData(type: 'basic', position: Vector2(300, -50), delay: 2),
          // 2 enemies in line
          EnemyData(type: 'basic', position: Vector2(400, -50), delay: 0),
          EnemyData(type: 'basic', position: Vector2(500, -50), delay: 0),
        ],
        prewaveDelay: 2,
      ),
      WaveData(
        enemies: [
          EnemyData(type: 'basic', position: Vector2(100, -50), delay: 0.3),
          EnemyData(type: 'basic', position: Vector2(200, -50), delay: 0.3),
          EnemyData(type: 'basic', position: Vector2(300, -50), delay: 0.3),
          EnemyData(type: 'basic', position: Vector2(400, -50), delay: 0.3),
          EnemyData(type: 'basic', position: Vector2(500, -50), delay: 0.3),
        ],
        prewaveDelay: 10,
      ),
    ]));

    // Add the button test
    add(
      ButtonComponent(
        text: 'Restart',
        onPressed: () {
          print("yay! Restart callback works");
        },
        normalSprite: await Sprite.load('ui/return_btn.png'),
        hoverSprite: await Sprite.load('ui/return_btn_hover.png'),
        pressedSprite: await Sprite.load('ui/return_btn_pressed.png'),
        position: Vector2(100, 100),
        size: Vector2.all(50)
      ),
    );
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
  }

  @override
  void onPanStart(DragStartInfo info){
    player.startShooting();
  }

  @override
  void onPanEnd(DragEndInfo info){
    player.stopShooting();
  }
}

void main() {
  runApp(GameWidget(game: SpaceShooterGame()));
}