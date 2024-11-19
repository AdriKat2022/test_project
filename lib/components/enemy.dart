import 'package:test_project/space_shooter_game.dart';
import 'package:flame/effects.dart';
import 'package:flame/components.dart';
import 'package:test_project/utils/poolable_object.dart';

class Enemy extends SpriteAnimationComponent with HasGameReference<SpaceShooterGame> implements PoolableObject {

  static const enemySize = 50.0;
  static const enemyBaseSpeed = 100;

  bool isDead = false;

  Enemy({
      super.position,
    }) : super(
            size: Vector2.all(enemySize),
            anchor: Anchor.center,
          );
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'ships/enemy.png',
      SpriteAnimationData.sequenced(
        amount: 2,
        stepTime: .4,
        textureSize: Vector2(7,6),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isDead) return;

    position.y += dt * enemyBaseSpeed;

    if (position.y > game.size.y) {
      disable();
    }
  }

  void initializeEnemy(){
    isDead = false;
  }

  void death(){
    if (isDead) return;
    isDead = true;

    // Stop the animation
    animation = null;

    // Make an effect
    this.add(ScaleEffect.by(
      Vector2.all(0.5),
      EffectController(duration: 0.5),
      onComplete: () => {
        disable()
      }
    ));
  }

  void disable(){
    removeFromParent();
    pool();
  }
  
  @override
  bool isPooled = true;
  
  @override
  void pool() {
    isPooled = true;
  }
  
  @override
  void reset() {
    initializeEnemy();
  }
  
  @override
  void unpool() {
    isPooled = false;
  }

}