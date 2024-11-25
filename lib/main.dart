import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/UI/game_ui.dart';
import 'package:test_project/components/enemy.dart';
import 'package:test_project/components/wave.dart';
import 'package:test_project/components/player.dart';
import 'package:test_project/data/audio_manager.dart';
import 'package:test_project/data/waves_data_container.dart';
import 'package:test_project/utils/log_debug.dart';
import 'package:test_project/utils/object_pool.dart';

class SpaceShooterGame extends FlameGame with PanDetector, HasCollisionDetection, KeyboardEvents {

  static const int playerMaxHp = 4;

  late final Player player;
  late final WaveManager gameWave;
  late final ObjectPool<Enemy> enemyPool;
  late final GameUI gameUI;

  bool gameStarted = false;
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

    player = Player(maxHP: playerMaxHp.toDouble());
    add(player);

    // Create the enemy pool (could be moved into a LEVEL class).
    enemyPool = ObjectPool<Enemy>(
      maxSize: 70,
      createObjectFunction: () => Enemy(health: 20),
    );

    // Add the waves.
    gameWave = WaveManager(enemyPool: enemyPool, waveDataList: WavesDataContainer.wavePattern_1);
    add(gameWave);

    // Add the UI
    gameUI = GameUI(restartGameFunction: () => resetGame());
    add(gameUI);
    LogDebug.printToHUD(this, "Game loaded!");

  }

  void gameOver(){
    if (gameIsOver) return;
    gameIsOver = true;
    gameUI.onGameOver();
    LogDebug.printToHUD(this, "Game Over!");
  }

  void gameWin(){
    if (gameIsOver) return;
    gameIsOver = true;
    gameUI.onGameWin();
    LogDebug.printToHUD(this, "You Win!");
  }

  void gameStart(){
    gameStarted = true;
    AudioManager.playMusic('main_theme', forceRestart: false);
    player.startShooting();
    gameWave.startRun();
    gameUI.onGameStart();
    gameUI.toogleTutorial(true);
  }

  void resetGame(){
    gameIsOver = false;
    gameStarted = false;
    player.reset();
    gameWave.reset();
    enemyPool.emptyPool();
    gameUI.onGameReset();
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {

    if (event is KeyDownEvent){
      if (event.logicalKey == LogicalKeyboardKey.space){
        if (gameStarted){
          player.switchWeapon();
        }
        else {
          gameStart();
        }
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }
}

void main() {
  runApp(GameWidget(game: SpaceShooterGame()));
}