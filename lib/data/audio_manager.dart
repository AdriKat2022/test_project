import 'package:flame_audio/flame_audio.dart';

class AudioManager {

  static void playMusic() {
    // FlameAudio.bgm.play('sounds/click.wav');
  }

  static void stopMusic() {
    // FlameAudio.bgm.stop();
  }

  static void playSound(String sound) {
    final audioFile = audioFiles[sound];
    if (audioFile == null) {
      throw ArgumentError('Sound $sound not found!');
    }
    FlameAudio.play(audioFile);
  }

  static void loadSounds() async {
    await FlameAudio.audioCache.loadAll([
      ...audioFiles.values
    ]);
  }

  static final audioFiles = <String, String>{
    'click': 'sounds/click.wav',
  };
}