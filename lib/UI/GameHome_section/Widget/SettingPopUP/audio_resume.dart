import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class Handler extends WidgetsBindingObserver {

  CelebHomeController celebHomeController = Get.put(CelebHomeController());
  TimerController timerController = Get.put(TimerController());

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    if (celebHomeController.music) {
      if (state != AppLifecycleState.resumed) {
        AudioPlayer.stopMusic();// Audio player is a custom class with resume and pause static methods
      }
      else{
        // AudioPlayer.playMusic();
      }
    }

    if(state != AppLifecycleState.resumed){
      timerController.timer!.cancel();
    }else{
      timerController.startTimer();
    }

    if(state ==  AppLifecycleState.paused){
      celebHomeController.updateUserData();
    }

  }
}
