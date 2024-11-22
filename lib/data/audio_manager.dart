import 'package:flame/game.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:test_project/utils/log_debug.dart';

class AudioManager {

  static late final FlameGame game;

  static final musicFiles = <String, String>{
    'main_theme': 'sounds/main_music.wav',
  };

  static final soundFileNames = <String, String>{
    'sounds/click.wav': 'click',
    'sounds/explosion.wav': 'explosion',
    'sounds/player_bullet.wav': 'player_bullet',
    'sounds/enemy_hurt.wav': 'enemy_hurt',
    // 'sounds/player_hurt.wav': 'player_hurt',
    // 'sounds/score.wav': 'score',
    // 'sounds/game_over.wav': 'game_over',
    // 'sounds/game_win.wav': 'game_win',
  };

  static var soundFilePools = <String, AudioPool>{};

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

  static void playSound(String soundName) {
    final audioPool = soundFilePools[soundName];
    if (audioPool == null) {
      throw ArgumentError('Sound $soundName not found!');
    }
    audioPool.start();
  }

  static void initialize() async {
    for (final soundFile in soundFileNames.keys) {
      final name = soundFileNames[soundFile];
      if (name == null) {
        throw ArgumentError("Name of sound '$soundFile' not found!");
      }
      soundFilePools[name] = await FlameAudio.createPool(soundFile, minPlayers: 1, maxPlayers: 2);
    }
  }
}