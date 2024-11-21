import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/text.dart';

class ScoreComponent extends TextComponent {
  int score = 0;

  ScoreComponent() : super(text: 'Score: 0');

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = Vector2(10, 10); // Example: Top-left corner
    textRenderer = TextPaint(style: TextStyle(fontSize: 24, color: Color(0xFFFFFFFF)));
  }

  void updateScore(int newScore) {
    // Throw a little animation
    score = newScore;
    text = 'Score: $score';
  }

  void animateScoreIncrease() {
    add(ScaleEffect.to(
      Vector2(1.5, 1.5), 
      EffectController(duration: 0.2, reverseDuration: 0.2),
    ));
  }
}
