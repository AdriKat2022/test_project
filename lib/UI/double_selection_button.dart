import 'dart:ui';

import 'package:flame/components.dart';

/// This class allows to put two buttons side by side (like two arrows) with the possibility to put something in between.
class DoubleSelectionButton extends PositionComponent {

  final PositionComponent leftButton;
  final PositionComponent rightButton;
  final PositionComponent? middleComponent;

  DoubleSelectionButton({
    required this.leftButton,
    required this.rightButton,
    this.middleComponent,
  }) {
    leftButton.anchor = Anchor.center;
    rightButton.anchor = Anchor.center;
    middleComponent?.anchor = Anchor.center;
  }

  @override
  void render(Canvas canvas) {
    leftButton.render(canvas);
    rightButton.render(canvas);
    middleComponent?.render(canvas);
  }

  @override
  void update(double dt) {
    leftButton.update(dt);
    rightButton.update(dt);
    middleComponent?.update(dt);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    leftButton.onGameResize(gameSize);
    rightButton.onGameResize(gameSize);
    middleComponent?.onGameResize(gameSize);
  }

  @override
  void onMount() {
    super.onMount();
    leftButton.onMount();
    rightButton.onMount();
    middleComponent?.onMount();
  }

  @override
  void onRemove() {
    super.onRemove();
    leftButton.onRemove();
    rightButton.onRemove();
    middleComponent?.onRemove();
  }
}