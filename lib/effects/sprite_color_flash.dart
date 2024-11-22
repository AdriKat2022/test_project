import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';

/// Effect that makes the passed sprite flash red using a color effect.
class SpriteColorFlash {

  /// The component to apply the effect to.
  Component sprite;

  final double fadeInDuration;
  final double holdDuration;
  final double fadeOutDuration;

  /// The color to flash the sprite.
  final Color color;

  double timer = 0.0;

  /// Constructor for the SpriteRedFlash effect.
  SpriteColorFlash(this.sprite, this.fadeInDuration, this.holdDuration, this.fadeOutDuration, this.color);

  /// Activate the effect.
  void activate() {
    sprite.add(ColorEffect(
      color,
      EffectController(
        duration: fadeInDuration,
        atMaxDuration: holdDuration,
        reverseDuration: fadeOutDuration,
      ),
    ));
  }
}