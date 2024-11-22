import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:test_project/data/font_palette.dart';
import 'package:test_project/space_shooter_game.dart';
import 'package:test_project/utils/log_debug.dart';

class FadingNotificationText extends TextComponent with HasGameReference<SpaceShooterGame> implements OpacityProvider {

  @override
  double opacity = 0;

  FadingNotificationText({
    required String text,
    required Vector2 position,
    required double defaultFadeOutDuration,
    TextStyle? textStyle,
    Anchor anchor = Anchor.topCenter,
  }) : super(
          text: text,
          position: position,
          textRenderer: TextPaint(
            style: textStyle ?? const TextStyle(fontFamily: FontPalette.primaryTextFont, fontSize: 24, color: Colors.white),
          ),
          anchor: anchor,
        ) {
  }

  

  /// Changes the text dynamically.
  void setText(String newText) {
    text = newText;
  }

  /// Trigger the text effect.
  void triggerEffect({double fadeInDuration = 0, double holdDuration = 3, double blinkSpeed = 1, int blinkCount = 0, double fadeOutDuration = 0.5, bool fadeOutWhileBlinking = false}) {

    print("triggering effect");

    if (blinkCount > 0) {
      // Create a one blink controller.
      final oneBlinkController = EffectController(
        duration: 0,
        reverseDuration: 0,
        atMaxDuration: 1 / blinkSpeed,
        atMinDuration: 1 / blinkSpeed,
      );

      // Create one blink effect.
      final oneBlinkEffect = OpacityEffect.fadeIn(
        oneBlinkController,
        onComplete: () {
          // Hide the text after the fade-out completes.
          removeFromParent();
        },
      );
    }
    else {
      print("simple effect: fadein=$fadeInDuration s, hold=$holdDuration s, fadeout=$fadeOutDuration s");
      // Add a simple fade-out effect if no flicker is required.
      add(
        OpacityEffect.fadeIn(
          EffectController(
            duration: fadeInDuration,
            atMaxDuration: holdDuration,
            reverseDuration: fadeOutDuration,

          ),
          onComplete: () {
            // Hide the text after the fade-out completes.
            removeFromParent();
            LogDebug.printToHUD(game, "effect DONE");
          },
        ),
      );
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    print("opacity: $opacity");
  }

}
