
import 'package:flame/components.dart';
import 'package:test_project/UI/button.dart';
import 'package:test_project/UI/color_selector.dart';
import 'package:test_project/UI/hearts_bar.dart';
import 'package:test_project/UI/score_component.dart';
import 'package:test_project/data/font_palette.dart';
import 'package:test_project/effects/fade_out_text_notification.dart';
import 'package:test_project/main.dart';
import 'package:test_project/utils/log_debug.dart';

class GameUI extends Component with HasGameReference<SpaceShooterGame>{

  final HeartsBarComponent heartsBar = HeartsBarComponent(lives: SpaceShooterGame.playerMaxHp);
  final ScoreComponent scoreComponent = ScoreComponent();
  final Function _restartGameFunction;

  late final ColorSelector _colorSelector;
  late final ButtonComponent _restartButton;

  late final FadingNotificationText _beginNotification;

  GameUI({required Function restartGameFunction}) : _restartGameFunction = restartGameFunction;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    final notificationText = FadingNotificationText(text: "Move your ship with [Mouse]", position: Vector2(game.size.x/2, game.size.y/5), defaultFadeOutDuration: 0.5);
    add(notificationText);
    notificationText.triggerEffect(fadeInDuration: 0.5, holdDuration: 8, fadeOutDuration: 0.5);

    _beginNotification = FadingNotificationText(text: "Press [SPACE] to begin !", position: Vector2(game.size.x/2, game.size.y/4), defaultFadeOutDuration: 0.5);
    add(_beginNotification);
    _beginNotification.triggerEffect(fadeInDuration: 0.5, holdDuration: 8, fadeOutDuration: 0.5);

    heartsBar.anchor = Anchor.topLeft;
    heartsBar.position = Vector2(50, 50);
    add(heartsBar);
    scoreComponent.position = Vector2(game.size.x - 50, 50);
    scoreComponent.anchor = Anchor.topRight;
    scoreComponent.scale = Vector2.all(2);
    add(scoreComponent);

    _restartButton = ButtonComponent(
        text: 'Restart',
        onPressed: () {
          LogDebug.printToHUD(game, "Game reset!");
          _restartGameFunction();
        },
        normalSprite: await Sprite.load('ui/buttons/return_btn.png'),
        hoverSprite: await Sprite.load('ui/buttons/return_btn_hover.png'),
        pressedSprite: await Sprite.load('ui/buttons/return_btn_pressed.png'),
        position: Vector2(game.size.x/2 , game.size.y - 50),
        size: Vector2.all(50)
      );
    _restartButton.anchor = Anchor.bottomCenter;
    add(_restartButton);

    _colorSelector = (ColorSelector(
      colors: FontPalette.shipAvailableColors,
      componentsSize: 50,
      spacing: 10,
      onColorSelected: (color) {
        game.player.selectTintColor(color);
      }
    ));
    _colorSelector.position = Vector2(game.size.x - 150, game.size.y - 100);
    _colorSelector.anchor = Anchor.bottomRight;
    add(_colorSelector);

    priority = 10;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    heartsBar.position = Vector2(50, 50);
    scoreComponent.position = Vector2(gameSize.x - 50, 50);
    _restartButton.position = Vector2(gameSize.x/2 , gameSize.y - 50);
    _colorSelector.position = Vector2(gameSize.x - 150, gameSize.y - 50);
  }

  void onGameReset(){
    // Only add the notification if it's not already added.
    if (_beginNotification.parent != null) return;
    add(_beginNotification);
    _beginNotification.triggerEffect(fadeInDuration: 0.5, holdDuration: 8, fadeOutDuration: 0.5);
  }
}