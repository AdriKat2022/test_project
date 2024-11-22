import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:test_project/utils/log_debug.dart';

class AudioManager {

  static late final FlameGame game;

  static final musicFiles = <String, String>{
    'main_theme': 'sounds/main_music.wav',
  };

  static final soundFiles = <String, String>{
    'click': 'sounds/click.wav',
    'explosion': 'sounds/explosion.wav',
    'player_bullet': 'sounds/player_bullet.wav',
    // 'player_hurt': 'sounds/player_hurt.wav',
    'enemy_hurt': 'sounds/enemy_hurt.wav',
    // 'score': 'sounds/score.wav',
    // 'game_over': 'sounds/game_over.wav',
    // 'game_win': 'sounds/game_win.wav',
  };

  static void playMusic(String music) {
    final audioFile = musicFiles[music];
    if (audioFile == null) {
      LogDebug.printToHUD(game, 'Music $music not found!');
      // throw ArgumentError('Music $music not found!');
      return;
    }
    LogDebug.printToHUD(game, 'Playing music $music');
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play(audioFile);
  }

  static void stopMusic() {
    FlameAudio.bgm.stop();
  }

  static void playSound(String sound) {
    final audioFile = soundFiles[sound];
    if (audioFile == null) {
      throw ArgumentError('Sound $sound not found!');
    }
    FlameAudio.play(audioFile);
  }

  static void initialize() async {
    await FlameAudio.audioCache.loadAll([
      ...soundFiles.values
    ]);
  }
}