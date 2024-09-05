import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class LevelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LevelController());
  }
}
