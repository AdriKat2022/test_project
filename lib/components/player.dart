import 'package:flame/components.dart';
import 'package:test_project/space_shooter_game.dart';
import 'package:test_project/components/bullet.dart';

class Player extends SpriteAnimationComponent with HasGameReference<SpaceShooterGame> {

  late final SpawnComponent _bulletSpawner;

  Player() : super(
    size: Vector2(100, 150),
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    position = game.size/2;

    // Load Animation
    animation = await game.loadSpriteAnimation(
      'ships/player_sheet.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.2,
        textureSize: Vector2(32, 48),
      ),
    );

    // Create Bullet Spawner
    _bulletSpawner = SpawnComponent(
      period: .2,
      selfPositioning: true,
      factory: (index) {
        return Bullet(
          position: position + Vector2(0, -height/2),
        );
      },
      autoStart: false,
    );

    game.add(_bulletSpawner);
  }

  void move(Vector2 delta){
    position.add(delta);
  }

  void startShooting(){
    _bulletSpawner.timer.start();
  }

  void stopShooting(){
    _bulletSpawner.timer.stop();
  }
}