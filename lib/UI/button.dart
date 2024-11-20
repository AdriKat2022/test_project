import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class ButtonComponent extends SpriteComponent with TapCallbacks, HoverCallbacks {
  final String text;
  final VoidCallback onPressed;
  // final double width;
  // final double height;

  final Sprite normalSprite;
  final Sprite? hoverSprite;
  final Sprite? pressedSprite;
  final Sprite? disabledSprite;

  ButtonComponent({
    required this.text,
    required this.onPressed,
    required this.normalSprite,
    this.hoverSprite,
    this.pressedSprite,
    this.disabledSprite, 
    // this.width = 150,
    // this.height = 50,
    super.size,
    super.position,
    super.priority,
  }) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = normalSprite;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // // Draw the button background
    // final paint = Paint()..color = Colors.blue;
    // canvas.drawRect(size.toRect(), paint);

    // Draw the button text
    // final textPainter = TextPainter(
    //   text: TextSpan(
    //     text: text,
    //     style: const TextStyle(
    //       color: Colors.white,
    //       fontSize: 16,
    //     ),
    //   ),
    //   textAlign: TextAlign.center,
    //   textDirection: TextDirection.ltr,
    // );
    // textPainter.layout(maxWidth: width);
    // textPainter.paint(canvas, Offset((width - textPainter.width) / 2, (height - textPainter.height) / 2));
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    sprite = pressedSprite ?? normalSprite;
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    sprite = normalSprite;
    onPressed();
  }

  @override
  void onHoverEnter() {
    super.onHoverEnter();
    sprite = hoverSprite ?? normalSprite;
  }

  @override
  void onHoverExit() {
    super.onHoverExit();
    sprite = normalSprite;
  }
}
