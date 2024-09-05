import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class SettingController extends GetxController with GetSingleTickerProviderStateMixin{


  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    sound.value = await SharedPref().getBoolValuesSF(StorageConstants.sound);
    vibration.value = await SharedPref().getBoolValuesSF(StorageConstants.vibration);
    currentIndex.value = await SharedPref().getInt();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

  }

  late AnimationController animationController;

  RxBool sound = true.obs;
  RxBool vibration = true.obs;
  RxInt  currentIndex = 0.obs;


}