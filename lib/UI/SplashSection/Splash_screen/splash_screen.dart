import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  @override
  SplashController controller = Get.put(SplashController());

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Scaffold(
        body: Container(
          height: displayHeight(context),
          width: displayWidth(context),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageConstants.splashBg),
                  fit: BoxFit.fill)),
          child: RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0)
                .animate(controller.animationController),
            child: Center(
              child: Image(
                image: const AssetImage(ImageConstants.splashLoader),
                height: displayHeight(context) * 0.18,
                width: displayWidth(context) * 0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
