import 'package:celebrity_quiz/Infrastructure/Commons/Constant/audio_constant.dart';
import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';

final assetsAudioPlayer = AssetsAudioPlayer();
final assetsAudioPlayer1 = AssetsAudioPlayer();
final assetsAudioPlayer2 = AssetsAudioPlayer();
final assetsAudioPlayer3 = AssetsAudioPlayer();

class AudioPlayer {
  static void playResultSound({required bool isWinner}) {
    try {
      if (isWinner) {
        assetsAudioPlayer2.stop();
        assetsAudioPlayer.open(
          Audio(AudioConstants.gameWin),
        );
      } else if (!isWinner) {
        assetsAudioPlayer2.stop();
        assetsAudioPlayer.open(
          Audio(AudioConstants.gameLoss),
        );
      }
    } catch (e) {
      print('cannot play audio');
    }
  }

  static void playTenSec({required int remainSec}) {
    try {
      if (remainSec < 6 && remainSec > 0) {
        assetsAudioPlayer2.open(
          Audio(AudioConstants.tenSecRemain),
        );
      }else {
        assetsAudioPlayer2.stop();
      }
    } catch (e) {
      print('cannot play audio');
    }
  }

  static void playTimeUp({required int remainSec}) {
    try {
    if(remainSec == 0){
        assetsAudioPlayer1.open(
          Audio(AudioConstants.timeUp),
        );
        assetsAudioPlayer2.stop();

    }
    } catch (e) {
      print('cannot play audio');
    }
  }

  static void playSound({required String audioName}) {
    try {
      assetsAudioPlayer3.open(
          Audio(audioName));

    } catch (e) {
      print('cannot play audio');
    }
  }
  // static void playMusic() async {
  //   try {
  //     await assetsAudioPlayer1.open(
  //       Audio('assets/audios/music.mp3'),
  //     );
  //     await assetsAudioPlayer1.setLoopMode(LoopMode.single);
  //   } catch (e) {
  //     print('assetsAudioPlayer1 error: $e');
  //   }
  // }

  static void stopMusic() {
    assetsAudioPlayer1.stop();
  }

  static void pauseMusic() {
    assetsAudioPlayer1.pause();
  }

  static void toggleLoop() {
    assetsAudioPlayer1.toggleLoop();
  }
}
