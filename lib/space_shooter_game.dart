import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';

import 'package:flutter/material.dart';

import 'package:test_project/components/player.dart';

class SpaceShooterGame extends FlameGame with PanDetector {

  late Player player;

  @override
  Future<void> onLoad() async {
    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData('backgrounds/background_placeholder.png'),
        ParallaxImageData('backgrounds/stars_1.png'),
        ParallaxImageData('backgrounds/stars_2.png'),
      ],
      baseVelocity: Vector2(0, -5),
      repeat: ImageRepeat.repeat,
      velocityMultiplierDelta: Vector2(0, 4),
    );
    add(parallax);

    player = Player();
    add(player);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
  }
}

void main() {
  runApp(GameWidget(game: SpaceShooterGame()));
}