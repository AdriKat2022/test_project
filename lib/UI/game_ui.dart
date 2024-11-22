
import 'package:flame/components.dart';
import 'package:test_project/UI/button.dart';
import 'package:test_project/UI/color_selector.dart';
import 'package:test_project/UI/hearts_bar.dart';
import 'package:test_project/UI/score_component.dart';
import 'package:test_project/data/font_palette.dart';
import 'package:test_project/effects/fade_out_text_notification.dart';
import 'package:test_project/space_shooter_game.dart';
import 'package:test_project/utils/log_debug.dart';

class GameUI extends Component with HasGameReference<SpaceShooterGame>{

  final Function restartGameFunction;
  final HeartsBarComponent heartsBar = HeartsBarComponent(lives: SpaceShooterGame.playerMaxHp);
  final ScoreComponent scoreComponent = ScoreComponent();

  late final ColorSelector colorSelector;
  late final ButtonComponent restartButton;

  GameUI({required this.restartGameFunction});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    final notificationText = FadingNotificationText(text: "Move your ship with [Mouse]", position: Vector2(game.size.x/2, game.size.y/5), defaultFadeOutDuration: 0.5);
    add(notificationText);
    notificationText.triggerEffect(fadeInDuration: 0.5, holdDuration: 3, fadeOutDuration: 0.5);

    heartsBar.anchor = Anchor.topLeft;
    heartsBar.position = Vector2(50, 50);
    add(heartsBar);
    scoreComponent.position = Vector2(game.size.x - 50, 50);
    scoreComponent.anchor = Anchor.topRight;
    scoreComponent.scale = Vector2.all(2);
    add(scoreComponent);

    restartButton = ButtonComponent(
        text: 'Restart',
        onPressed: () {
          LogDebug.printToHUD(game, "Restart reset!");
          restartGameFunction();
        },
        normalSprite: await Sprite.load('ui/buttons/return_btn.png'),
        hoverSprite: await Sprite.load('ui/buttons/return_btn_hover.png'),
        pressedSprite: await Sprite.load('ui/buttons/return_btn_pressed.png'),
        position: Vector2(game.size.x/2 , game.size.y - 50),
        size: Vector2.all(50)
      );
    restartButton.anchor = Anchor.bottomCenter;
    add(restartButton);

    colorSelector = (ColorSelector(
      colors: FontPalette.shipAvailableColors,
      componentsSize: 50,
      spacing: 10,
      onColorSelected: (color) {
        // LogDebug.printToHUD(game, "Color selected: $color");
        game.player.selectTintColor(color);
      }
    ));
    colorSelector.position = Vector2(game.size.x - 150, game.size.y - 100);
    colorSelector.anchor = Anchor.bottomRight;
    add(colorSelector);

    priority = 10;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    heartsBar.position = Vector2(50, 50);
    scoreComponent.position = Vector2(gameSize.x - 50, 50);
    restartButton.position = Vector2(gameSize.x/2 , gameSize.y - 50);
    colorSelector.position = Vector2(gameSize.x - 150, gameSize.y - 50);
  }
}