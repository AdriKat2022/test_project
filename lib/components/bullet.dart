import 'package:test_project/space_shooter_game.dart';
import 'package:flame/components.dart';

class Bullet extends SpriteAnimationComponent with HasGameReference<SpaceShooterGame> {
  Bullet({
    super.position,
  }) : super(
      size: Vector2(25,50),
      anchor: Anchor.center,
    );
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();

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
    super.update(dt);
    position.y += dt * -700;

    if (position.y < -height){
      removeFromParent();
    }
  }
}