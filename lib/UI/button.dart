import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:test_project/data/audio_manager.dart';

/// Makes a simple button that is interactible with the user (Mouse only).
class ButtonComponent extends SpriteComponent with TapCallbacks, HoverCallbacks {
  final String text;
  /// The function that will be called when the button is pressed.
  final VoidCallback onPressed;

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
    super.size,
    super.position,
    super.priority,
  }) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = normalSprite;
    priority = 10;
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    sprite = pressedSprite ?? normalSprite;
    AudioManager.playSound('click');
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
