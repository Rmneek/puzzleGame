import 'package:audioplayers/audioplayers.dart';

class SoundService {
  static final _player = AudioPlayer();

  static void playTap() => _player.play(AssetSource("sounds/tap.mp3"));
  static void playDrop() => _player.play(AssetSource("sounds/drop.mp3"));
  static void playWin() => _player.play(AssetSource("sounds/win.mp3"));
}
