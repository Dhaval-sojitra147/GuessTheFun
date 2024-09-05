import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class AppPages {
  // ignore: constant_identifier_names
  static const INITIAL = RoutesConstants.splashScreen;
  static final routes = [
    GetPage(
      name: RoutesConstants.splashScreen,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: RoutesConstants.celebHomeScreen,
      page: () => CelebHomeScreen(),
      binding: CelebHomeBinding(),
    ),

    GetPage(
      name: RoutesConstants.mainLevelScreen,
      page: () => MainLevelScreen(),
      binding: MainLevelBinding(),
    ),

    GetPage(
      name: RoutesConstants.gamePlayScreen,
      page: () => const GamePlayScreen(),
      binding: GamePlayBinding(),
    ),

    GetPage(
      name: RoutesConstants.levelScreen,
      page: () => LevelScreen(),
      binding: LevelBinding(),
    ),
  ];
}
