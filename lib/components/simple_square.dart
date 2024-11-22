import 'dart:ui';

import 'package:flame/components.dart';

/// A simple square that can be customized with color and size
class SimpleSquare extends PositionComponent {

  Color _color;
  Paint _cachedPaint = Paint();

  SimpleSquare({
    required Vector2 size,
    Color color = const Color(0xFF0000FF),
  }) : _color = color {
    this.size = size;
    anchor = Anchor.center;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(size.toRect(), _cachedPaint);
  }

  void setColor(Color color) {
    if (color == this._color) {
      return;
    }
    this._color = color;
    _cachedPaint.color = color;
  }
}