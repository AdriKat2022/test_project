import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:test_project/UI/game_ui.dart';
import 'package:test_project/components/enemy.dart';
import 'package:test_project/components/wave.dart';
import 'package:test_project/components/player.dart';
import 'package:test_project/data/audio_manager.dart';
import 'package:test_project/data/waves_data_container.dart';
import 'package:test_project/utils/log_debug.dart';
import 'package:test_project/utils/object_pool.dart';

class SpaceShooterGame extends FlameGame with PanDetector, HasCollisionDetection {

  static const int playerMaxHp = 4;

  late final Player player;
  late final WaveManager gameWave;
  late final ObjectPool<Enemy> enemyPool;
  late final GameUI gameUI;

  bool gameIsOver = false;

  @override
  Future<void> onLoad() async {

    AudioManager.game = this;
    AudioManager.initialize();

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

    player = Player(maxHP: playerMaxHp);
    add(player);

    // Create the enemy pool (could be moved into a LEVEL class).
    enemyPool = ObjectPool<Enemy>(
      maxSize: 50,
      createObjectFunction: () => Enemy(health: 20),
    );

    // Add the waves.
    gameWave = WaveManager(enemyPool: enemyPool, waveDataList: WavesDataContainer.wavePattern_1);
    add(gameWave);

    // Add the UI
    gameUI = GameUI(restartGameFunction: () => resetGame());
    add(gameUI);
    LogDebug.printToHUD(this, "Game loaded!");

    AudioManager.playMusic('main_theme');
  }

  void gameOver(){
    if (gameIsOver) return;
    gameIsOver = true;
    LogDebug.printToHUD(this, "Game Over!");
  }

  void gameWin(){
    if (gameIsOver) return;
    gameIsOver = true;
    LogDebug.printToHUD(this, "You Win!");
  }

  void resetGame(){
    gameIsOver = false;
    player.reset();
    gameWave.reset();
    enemyPool.emptyPool();
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