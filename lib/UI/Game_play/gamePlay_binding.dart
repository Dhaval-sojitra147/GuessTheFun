import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class GamePlayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GamePlayBinding());
  }
}
