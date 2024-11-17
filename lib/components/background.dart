import 'package:flame/components.dart';

class Background extends SpriteComponent {
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('background_placeholder.png');
    size = Vector2(800, 600); // Set appropriate dimensions
  }
}