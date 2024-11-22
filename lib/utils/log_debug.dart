import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';

class LogDebug {

  /// Map of Texts were a key was used to log the message.
  static final indexHudMessages = <int, TextComponent>{};


  static final interval = 15;
  static final minY = 200;
  static final maxY = 800;
  static final xZeroKeyPosition = 50;
  static final xKeyPosition = 300;

  /// Store the last position of the HUD message so it doesn't overlap.
  static int lastYZeroKeyPosition = minY;
  /// Store the last position of the indexed HUD message so it doesn't overlap.
  static int lastYKeyPosition = minY;

  /// Print a message to the console.
  static void printLog(Object message) {
    if (const bool.fromEnvironment('DEBUG', defaultValue: false || true)) {
      print(message);
    }
  }

  /// Print a message to the HUD.
  /// 
  /// [key] is used to identify the message and replace it if needed. Ignored if the value is 0.
  /// [duration] is the time in seconds the message will be displayed. Ignored if there is a key.
  static void printToHUD(FlameGame game, String message, {double duration = 3, int key = 0}) {
    if (const bool.fromEnvironment('DEBUG', defaultValue: false) || true) {
      // Add a quick text to the game screen.
      if (key != 0){
        if (indexHudMessages.containsKey(key)){
          final text = indexHudMessages[key]!;
          // Remove the text effect.
          text.removeAll(text.children);
          text.text = message;
          text.add(OpacityEffect.fadeIn(EffectController(duration: 0)));
          text.add(OpacityEffect.fadeOut(EffectController(atMinDuration: duration, duration: 1)));
        }
        else {
          // Find a free position to display the message using the lastYKeyPosition.
          lastYKeyPosition += interval;
          final text = TextComponent(text: message, position: Vector2(xKeyPosition.toDouble(), lastYKeyPosition.toDouble()));
          text.add(OpacityEffect.fadeOut(EffectController(duration: duration)));
          game.add(text);
          indexHudMessages[key] = text;
        }
      }
      else {
        final text = TextComponent(text: message, position: Vector2(xZeroKeyPosition.toDouble(), lastYZeroKeyPosition.toDouble()));
        text.add(RemoveEffect(delay: duration));
        game.add(text);
      }
    }
  }
}