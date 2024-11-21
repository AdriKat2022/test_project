import 'package:flame/collisions.dart';
import 'package:flame/effects.dart';
import 'package:flame/components.dart';
import 'package:flutter/animation.dart';
import 'package:test_project/components/bullet.dart';
import 'package:test_project/components/damageable_component.dart';
import 'package:test_project/data/move_strategies.dart';
import 'package:test_project/effects/explosion.dart';
import 'package:test_project/space_shooter_game.dart';
import 'package:test_project/utils/poolable_object.dart';

class Enemy extends SpriteAnimationComponent with HasGameReference<SpaceShooterGame>, CollisionCallbacks, DamageableComponent implements PoolableObject {

  static const enemyBaseSize = 40.0;
  static const enemyBaseSpeedMultiplier = 1.0;

  late MoveStrategy moveStrategy;
  late double speed;

  double timer = 0;
  bool isDead = false;

  Enemy({
      super.position, moveStrategy, int health = 0
    }) : super(
            size: Vector2.all(enemyBaseSize),
            anchor: Anchor.center,
          )
  {
    if (health > 0){
      setMaxHp(health);
    }
  }

  void setSprite(String spriteKey) {
    // Load Animation from the animation manager cache.
    print('Loading sprite: $spriteKey');
    animation = game.animationManagerCache.getSpriteAnimation(spriteKey);
  }
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = await game.loadSpriteAnimation(
      'ships/enemy_basic.png',
      SpriteAnimationData.sequenced(amount: 2, stepTime: 0.4, textureSize: Vector2(7, 6)),
    );
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    if (isPooled) return;
    super.update(dt);
    if (isDead) return;

    position += moveStrategy.move(timer) * speed * enemyBaseSpeedMultiplier * dt;

    if (position.y > game.size.y) {
      disable();
    }

    timer += dt;
  }

  void setSize(Vector2 newSize){
    size.setFrom(newSize * enemyBaseSize);
  }

  void setMoveStrategy(MoveStrategy moveStrategy){
    this.moveStrategy = moveStrategy;
  }

  void initializeEnemy(){
    timer = 0;
    scale = Vector2.all(1);
    isDead = false;
  }

  void death(){
    if (isDead) return;
    isDead = true;

    // TODO: Add score and a sound.
    game.add(Explosion(position: position));
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
    // We're checking for bullets but we could also check for a interface for diversity (like DamageableBody).
    if (other is Bullet){
      if(takeDamage(other.getDamage())){
        death();
      }
      other.deleteBullet();
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