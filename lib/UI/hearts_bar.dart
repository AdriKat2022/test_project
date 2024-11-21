import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class HeartsBarComponent extends Component {

  // Hold the maximum number of lives the player can have.
  List<SpriteComponent> disabledHearts = [];
  List<SpriteComponent> hearts = [];
  int lives;

  List<ScaleEffect> scaleEffects = [];

  /// HeartSprite
  late final Sprite heartSprite;

  HeartsBarComponent({required this.lives});

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Load heart sprite
    heartSprite = await Sprite.load('ui/heart.png');

    for (int i = 0; i < lives; i++) {
      final heart = SpriteComponent(sprite: heartSprite, size: Vector2(32, 32), anchor: Anchor.center)
        ..position = Vector2(10 + i * 40, 50); // Adjust spacing
      hearts.add(heart);
      add(heart);
    }
  }

  void updateLives(int newLives) {
    if (newLives < lives) {
      List<int> heartsToRemove = [];

      // Remove hearts for lost lives
      for (int i = newLives; i < lives; i++) {
        lives = newLives;
        disabledHearts.add(hearts[i]);
        animateHeartLoss(hearts[i]);
        heartsToRemove.add(i);
      }
      for (final i in heartsToRemove) {
        hearts.removeAt(i);
      }
    }
    else if (newLives > lives) {
      // Re-add hearts for gained lives
      // And cancel animations for the hearts that were lost
      for (final effect in scaleEffects) {
        effect.removeFromParent();
        scaleEffects.remove(effect);
      }
      for (int i = 0; i < newLives; i++) {
        if (i < hearts.length && hearts[i].isMounted) {
          hearts[i].scale = Vector2.all(1);
          continue;
        }
        if (disabledHearts.isNotEmpty) {
          final heart = disabledHearts.removeLast();
          heart.position = Vector2(10 + i * 40, 50); // Adjust spacing
          heart.scale = Vector2.all(1);
          hearts.add(heart);
          add(heart);
          continue;
        }

        final heart = SpriteComponent(sprite: heartSprite, size: Vector2(32, 32), anchor: Anchor.center)
          ..position = Vector2(10 + i * 40, 50); // Adjust spacing
        hearts.add(heart);
        add(heart);
      }
    }

    lives = newLives;
  }

  void animateHeartLoss(SpriteComponent heart) {
    late final scaleEffect;

    scaleEffect = ScaleEffect.to(
      Vector2.zero(),
      EffectController(duration: 0.5, curve: Curves.easeOutExpo),
      onComplete: () {
        remove(heart); // Remove the heart after animation
        scaleEffects.remove(scaleEffect);
      },
    );

    heart.add(scaleEffect);
    scaleEffects.add(scaleEffect);
  }
}
