import 'package:flame/collisions.dart';
import 'package:test_project/space_shooter_game.dart';
import 'package:flame/components.dart';
import 'package:test_project/utils/poolable_object.dart';

class Bullet extends SpriteAnimationComponent with HasGameReference<SpaceShooterGame> implements PoolableObject {

  bool isPooled = true;

  Bullet({
    super.position
  }) : super(
      size: Vector2(25,50),
      anchor: Anchor.center,
    );
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(RectangleHitbox(collisionType: CollisionType.passive));

    animation = await game.loadSpriteAnimation(
      'bullets/player_bullet_sheet.png',
      SpriteAnimationData.sequenced(
        // Sprites are vertically aligned and are 6 by 15 pixels
        amount: 4,
        stepTime: 0.05,
        textureSize: Vector2(6, 16),
      ),
    );
  }

  @override
  void update(double dt){
    if (isPooled) return;
    super.update(dt);
    position.y += dt * -700;

    if (position.y < -height){
      deleteBullet();
    }
  }

  void deleteBullet(){
    removeFromParent();
    pool();
  }
  
  @override
  void pool() {
    isPooled = true;
  }
  
  @override
  void reset() {
    // TODO: implement reset
  }
  
  @override
  void unpool() {
    isPooled = false;
  }
}