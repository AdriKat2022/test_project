import 'package:flame/components.dart';

/// Define here a move strategy class that will be used to move the component (an enemy for instance).
abstract class MoveStrategy extends PositionComponent {

  /// Moves the component according to the current time.
  void move(double time) {
    position += v(time);
  }

  /// Returns the current velocity of the component at the given time.
  /// This function should be overridden by the concrete move strategy.
  Vector2 v(time){
    print('This is a move strategy that has not been implemented yet.');
    return Vector2.zero();
  }
}

class LinearMoveStrategy extends MoveStrategy {

  final Vector2 velocity;

  LinearMoveStrategy(this.velocity);

  @override
  Vector2 v(time) {
    return velocity;
  }
}

// ZigZags right and left.
class ZigZagMoveStrategy extends MoveStrategy {

  /// Amplitude of the zigzag.
  final double amplitude;
  /// Frequency of the zigzag.
  final double frequency;
  /// Base velocity.
  final Vector2 velocity;

  ZigZagMoveStrategy(this.amplitude, this.frequency, this.velocity);

  @override
  Vector2 v(time) {
    return velocity + Vector2(amplitude * (time * frequency).sin(), 0);
  }
}

/// Allows for a custom move strategy to be defined with a custom function.
class CustomMoveStrategy extends MoveStrategy {

  final Vector2 Function(double time) customFunction;

  CustomMoveStrategy(this.customFunction);

  @override
  Vector2 v(time) {
    return customFunction(time);
  }
}