import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'package:flutter/material.dart';

import 'package:test_project/components/player.dart';

class SpaceShooterGame extends FlameGame with PanDetector {

  late Player player;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    player = Player()
        ..position = size/2
        ..size = Vector2(50, 50)
        ..width = 50
        ..height = 100
        ..anchor = Anchor.center;

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