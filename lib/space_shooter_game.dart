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

  static const int playerMaxHp = 100;

  late Player player;

  @override
  Future<void> onLoad() async {

    // Load the parallax background.
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

    // Create the enemy pool (could be moved into a LEVEL class).
    final enemyPool = ObjectPool<Enemy>(
      maxSize: 50,
      createObjectFunction: () => Enemy(health: 20),
    );

    // Add the waves. TODO: Move this to a seperate class for cleaner code.
    add(Wave(enemyPool: enemyPool, waveDataList: [
      WaveData(
        enemies: [
          // 3 enemies in line.
          EnemyData(type: EnemyTypes.basic, position: Vector2(100, -50), delay: 0),
          EnemyData(type: EnemyTypes.basic, position: Vector2(200, -50), delay: 0),
          EnemyData(type: EnemyTypes.basic, position: Vector2(300, -50), delay: 2),
          // 4 enemies in line.
          EnemyData(type: EnemyTypes.zigzag, position: Vector2(200, -50), delay: 0),
          EnemyData(type: EnemyTypes.zigzag, position: Vector2(300, -50), delay: 0),
          EnemyData(type: EnemyTypes.zigzag, position: Vector2(400, -50), delay: 0),
          EnemyData(type: EnemyTypes.zigzag, position: Vector2(500, -50), delay: 0),
        ],
        prewaveDelay: 2,
      ),
      WaveData(
        enemies: [
          EnemyData(type: EnemyTypes.tank, position: Vector2(300, -50), delay: 0),
          EnemyData(type: EnemyTypes.tank, position: Vector2(400, -50), delay: 0),
          EnemyData(type: EnemyTypes.tank, position: Vector2(500, -50), delay: 1),
          EnemyData(type: EnemyTypes.basic, position: Vector2(250, -50), delay: 0),
          EnemyData(type: EnemyTypes.basic, position: Vector2(350, -50), delay: 0),
          EnemyData(type: EnemyTypes.basic, position: Vector2(450, -50), delay: 0),
          EnemyData(type: EnemyTypes.basic, position: Vector2(550, -50), delay: 2),
          // Other Line.
          EnemyData(type: EnemyTypes.basic, position: Vector2(700, -50), delay: 0.3),
          EnemyData(type: EnemyTypes.basic, position: Vector2(600, -50), delay: 0.3),
          EnemyData(type: EnemyTypes.basic, position: Vector2(500, -50), delay: 0.3),
          EnemyData(type: EnemyTypes.basic, position: Vector2(400, -50), delay: 0.3),
          EnemyData(type: EnemyTypes.basic, position: Vector2(300, -50), delay: 0.3),
          EnemyData(type: EnemyTypes.basic, position: Vector2(200, -50), delay: 0.3),
          EnemyData(type: EnemyTypes.basic, position: Vector2(100, -50), delay: 0.3),
        ],
        prewaveDelay: 10,
      ),
    ]));

    // Add the restart button.
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

  void resetGame(){
    player.setMaxHp(playerMaxHp);
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