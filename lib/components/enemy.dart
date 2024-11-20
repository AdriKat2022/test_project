import 'package:flame/collisions.dart';
import 'package:flutter/animation.dart';
import 'package:test_project/components/bullet.dart';
import 'package:test_project/effects/explosion.dart';
import 'package:test_project/space_shooter_game.dart';
import 'package:flame/effects.dart';
import 'package:flame/components.dart';
import 'package:test_project/utils/poolable_object.dart';

class Enemy extends SpriteAnimationComponent with HasGameReference<SpaceShooterGame>, CollisionCallbacks implements PoolableObject {

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

    add(RectangleHitbox());

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
    if (isPooled) return;
    super.update(dt);

    if (isDead) return;

    position.y += dt * enemyBaseSpeed;

    if (position.y > game.size.y) {
      disable();
    }
  }

  void initializeEnemy(){
    scale = Vector2.all(1);
    isDead = false;
  }

  void death(){
    if (isDead) return;
    isDead = true;

    // Make an effect
    this.add(ScaleEffect.by(
      Vector2.all(0.001),
      EffectController(duration: 0.35, curve: Curves.easeOutExpo),
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
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (isDead) return;
    super.onCollisionStart(intersectionPoints, other);
    if (other is Bullet){
      other.deleteBullet();
      // TODO: Add score and a sound
      game.add(Explosion(position: position));
      print("explosion at " + position.toString());
      death();
    }
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