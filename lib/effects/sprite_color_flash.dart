import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';

/// Effect that makes the passed sprite flash red using a color effect.
class SpriteColorFlash {

  /// The component to apply the effect to.
  Component _target;

  final double _fadeInDuration;
  final double _holdDuration;
  final double _fadeOutDuration;

  /// The color to flash the sprite.
  final Color _color;

  double timer = 0.0;

  /// Constructor for the SpriteRedFlash effect.
  SpriteColorFlash(this._target, this._fadeInDuration, this._holdDuration, this._fadeOutDuration, this._color);

  /// Activate the effect.
  void activate() {
    _target.add(ColorEffect(
      _color,
      EffectController(
        duration: _fadeInDuration,
        atMaxDuration: _holdDuration,
        reverseDuration: _fadeOutDuration,
      ),
    ));
  }
}