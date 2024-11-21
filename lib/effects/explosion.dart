import 'package:flame/components.dart';
import 'package:test_project/space_shooter_game.dart';

/// Creates a little explosion animation (for the moment only one type is available, but we could make a enum to select the one we want). 
class Explosion extends SpriteAnimationComponent with HasGameReference<SpaceShooterGame> {
  Explosion({
    super.position,
  }) : super(
    size: Vector2.all(50),
    anchor: Anchor.center,
    removeOnFinish: true,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    print("effective position: $position");

    animation = await game.loadSpriteAnimation(
      'effects/explosion.png',
      SpriteAnimationData.sequenced(
        amount: 3,
        stepTime: 0.05,
        textureSize: Vector2(8, 8),
        loop: false
      ),
    );
  }
}