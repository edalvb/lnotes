import 'package:audioplayers/audioplayers.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AudioPlayerService {
  final AudioPlayer _audioPlayer;

  AudioPlayerService() : _audioPlayer = AudioPlayer();

  Future<void> playAlarmSound() async {
    try {
      await _audioPlayer.play(AssetSource('sounds/alarm.mp3'));
    } catch (_) {}
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
