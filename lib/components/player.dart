import 'package:flame/components.dart';

class Player extends SpriteComponent {
  void move(Vector2 delta){
    position.add(delta);
  }
}