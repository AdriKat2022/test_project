import 'package:flame/components.dart';
import 'package:test_project/space_shooter_game.dart';
import 'package:test_project/components/bullet.dart';
import 'package:test_project/utils/object_pool.dart';

class Player extends SpriteAnimationComponent with HasGameReference<SpaceShooterGame> {

  late final SpawnComponent _bulletSpawner;
  late final ObjectPool<Bullet> _objectPool;

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

    // Initialize ObjectPool 
    _objectPool = ObjectPool<Bullet>(
      maxSize: 20,
      createObjectFunction: () => Bullet(),
    );

    // Initialize Bullet Spawner using the ObjectPool
    _bulletSpawner = SpawnComponent(
      period: .2,
      selfPositioning: true,
      factory: (index) {

        final bullet = _objectPool.getObject();

        if (bullet != null){
          bullet.position = position + Vector2(0, -height/2);
          return bullet;
        }
        throw Exception("Pool is all occupied!");
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