import 'package:audioplayers/audioplayers.dart';

class BeepManager {
  final AudioPlayer _shortPlayer = AudioPlayer();
  final AudioPlayer _longPlayer = AudioPlayer();

  final String shortBeepPath;
  final String longBeepPath;

  BeepManager({
    required this.shortBeepPath,
    required this.longBeepPath,
  }) {
    // Preload the sounds (non-blocking)
    _shortPlayer.setSource(AssetSource(shortBeepPath));
    _longPlayer.setSource(AssetSource(longBeepPath));

    // Setup for immediate playback
    _shortPlayer.setReleaseMode(ReleaseMode.stop);
    _longPlayer.setReleaseMode(ReleaseMode.stop);
  }

  void playShort() {
    _shortPlayer.stop();
    _shortPlayer.resume();
  }

  void playLong() {
    _longPlayer.stop();
    _longPlayer.resume();
  }

  void dispose() {
    _shortPlayer.dispose();
    _longPlayer.dispose();
  }
}
