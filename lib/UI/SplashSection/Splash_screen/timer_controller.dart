import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class TimerController extends GetxController{
  RxInt remainingSeconds = 0.obs; // 3 hours in seconds
  Timer? timer;


  @override
  void onInit() {
    startTimer();
    getRemainSecond();
    update();
    super.onInit();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
        update();
      } else {
        timer?.cancel();
        update();
      }
    });
  }

  RxString remainTime = "".obs;

  getRemainSecond()async{

    remainingSeconds.value = int.parse(await SharedPref().getStringValuesSF(StorageConstants.remainTime));

    return remainingSeconds.value;
  }
}