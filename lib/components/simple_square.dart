import 'dart:ui';

import 'package:flame/components.dart';

/// A simple square that can be customized with color and size
class SimpleSquare extends PositionComponent {

  Color color;
  Paint cachedPaint = Paint();

  SimpleSquare({
    required Vector2 size,
    this.color = const Color(0xFF0000FF),
  }) {
    this.size = size;
    anchor = Anchor.center;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(size.toRect(), cachedPaint);
  }

  void setColor(Color color) {
    if (color == this.color) {
      return;
    }
    this.color = color;
    cachedPaint.color = color;
  }
}