import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';

class LogDebug {

  static bool showDebug = false;

  /// Map of Texts were a key was used to log the message.
  static final indexHudMessages = <int, TextComponent>{};

  static final interval = 50;
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
    if (showDebug) {
      print(message);
    }
  }

  /// Print a message to the HUD.
  /// 
  /// [key] is used to identify the message and replace it if needed. Ignored if the value is 0.
  /// [duration] is the time in seconds the message will be displayed.
  static void printToHUD(FlameGame game, String message, {double duration = 3, int key = 0}) {
    if (showDebug) {
      // Add a quick text to the game screen.
      if (key != 0){
        if (indexHudMessages.containsKey(key)){
          final text = indexHudMessages[key]!;
          if (text.parent == null){
            game.add(text);
          }
          // Remove the text effect.
          text.removeAll(text.children);
          text.text = message;
          // text.add(OpacityEffect.fadeIn(EffectController(duration: 0)));
          // text.add(OpacityEffect.fadeOut(EffectController(atMinDuration: duration, duration: 1)));
          text.add(RemoveEffect(delay: duration));
        }
        else {
          // Find a free position to display the message using the lastYKeyPosition.
          lastYKeyPosition += interval;
          if (lastYKeyPosition > maxY){
            lastYKeyPosition = minY;
          }
          final text = TextComponent(text: message, position: Vector2(xKeyPosition.toDouble(), lastYKeyPosition.toDouble()));
          // text.add(OpacityEffect.fadeOut(EffectController(duration: duration)));
          game.add(text);
          indexHudMessages[key] = text;

          text.removeAll(text.children);
          text.add(RemoveEffect(delay: duration));
        }
      }
      else {
        final text = TextComponent(text: message, position: Vector2(xZeroKeyPosition.toDouble(), lastYZeroKeyPosition.toDouble()));
        lastYZeroKeyPosition += interval;
        if (lastYZeroKeyPosition > maxY){
          lastYZeroKeyPosition = minY;
        }
        text.add(RemoveEffect(delay: duration));
        game.add(text);
      }
    }
  }
}