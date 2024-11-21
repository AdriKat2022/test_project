
import 'package:flame/components.dart';
import 'package:test_project/UI/button.dart';
import 'package:test_project/UI/hearts_bar.dart';
import 'package:test_project/UI/score_component.dart';
import 'package:test_project/space_shooter_game.dart';

class GameUI extends Component with HasGameReference<SpaceShooterGame>{

  final Function restartGameFunction;
  final HeartsBarComponent heartsBar = HeartsBarComponent(lives: SpaceShooterGame.playerMaxHp);
  final ScoreComponent scoreComponent = ScoreComponent();


  GameUI({required this.restartGameFunction});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    add(heartsBar);
    add(scoreComponent);

    // Add the restart button.
    add(
      ButtonComponent(
        text: 'Restart',
        onPressed: () {
          restartGameFunction();
        },
        normalSprite: await Sprite.load('ui/buttons/return_btn.png'),
        hoverSprite: await Sprite.load('ui/buttons/return_btn_hover.png'),
        pressedSprite: await Sprite.load('ui/buttons/return_btn_pressed.png'),
        position: Vector2(100, 100),
        size: Vector2.all(50)
      ),
    );

    priority = 10;
  }
}