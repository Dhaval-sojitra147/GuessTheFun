import 'dart:developer';
import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class LevelPage extends GetView<LevelController> {
  LevelPage({super.key, required this.pageId});

  int pageId;
  LevelController levelController = Get.put(LevelController());
  SettingController settingController = Get.put(SettingController());
  List<int> levelLastIndex = [9,19,29,39,49,59,69,79,89,99,109,119,129,139,149,159,169,179,189,199,209,219,229,239,249,259,269,279,289,299,309,319,329,339,349,359,369,379,389,399,409,419,429,439,449,459,469,479,489,499];

  @override
  Widget build(BuildContext context) {
    String page = pageId.toString();
    String zero = "0";
    String mixNumber = page + zero;
    int dataIndex = int.parse(mixNumber);
    return Padding(
        padding: EdgeInsets.all(displayWidth(context) * 0.032),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: displayHeight(context) < 1000
              ? const EdgeInsets.only(top: 0)
              : displayHeight(context) < 550
              ? EdgeInsets.symmetric(
              horizontal: displayWidth(context) * 0.1)
              : EdgeInsets.symmetric(horizontal: displayWidth(context) * 0.08),
          itemCount: 12,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            int levelIndex = index + dataIndex;
            bool checkIndex =  levelLastIndex.contains(controller.completedLevelLength.value) && index != 0 ? levelIndex == controller.completedLevelLength.value + 1 : levelIndex == controller.completedLevelLength.value;
            return Padding(
                padding: displayHeight(context) > 550 ? EdgeInsets.all(displayWidth(context) * 0.01) :EdgeInsets.all(displayWidth(context) * 0.03),
                child: TweenAnimationBuilder(
                  duration: Duration(milliseconds: index == 0 ? 500 : index == 1 ? 600 : index == 2 ? 700 : index == 3 ? 800 : index == 4 ? 900 : index == 5 ? 1000 : index == 6 ? 1100 : index == 7 ? 1200 : index == 8 ? 1300 : index == 10 ? 1400 : 0),
                  curve: Curves.easeIn,
                  tween: Tween(begin: -1.0, end: 0.0),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(value * 600, value * 600),
                      child: GestureDetector(
                          onTap: () {
                            if (index == 9) {
                              controller.introController!.value.previousPage(
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.easeIn);
                            } else if (index == 11) {
                              controller.introController!.value.nextPage(
                                  duration: const Duration(milliseconds: 1000), curve: Curves.easeIn);
                            } else if (checkIndex &&
                                !controller.completeLevelId.value.contains(controller.celebsData[index == 9 ? levelIndex + 1 : index !=0 && levelIndex%20 == 0 ?levelIndex-1: levelIndex]
                                [FirebaseConstant.id])) {
                              settingController.vibration.value ==
                                  true ? Vibration.vibrate(duration: 100, amplitude: 128) :Vibration.vibrate(duration: 0, amplitude: 0);
                              Get.offNamed(
                                RoutesConstants.gamePlayScreen,
                                arguments: [
                                  {
                                    "celebImage": "${controller.celebsData[index == 10 ? levelIndex - 1 : levelIndex][FirebaseConstant.imageUrl]}"
                                  },
                                  {
                                    "eyeOpenGrid": controller.celebsData[index == 10 ? levelIndex - 1 : levelIndex][FirebaseConstant.eyeOpenGrid]
                                  },
                                  {
                                    "option": controller.celebsData[index == 10 ? levelIndex - 1 : levelIndex][FirebaseConstant.options]
                                  },
                                  {
                                    "hint": controller.celebsData[index == 10 ? levelIndex - 1 : levelIndex][FirebaseConstant.hint]

                                  },
                                  {
                                    "celebName": controller.celebsData[index == 10 ? levelIndex - 1 : levelIndex][FirebaseConstant.photoName]
                                  },
                                  {
                                    "levelId": controller.celebsData[index == 10 ? levelIndex - 1 : levelIndex][FirebaseConstant.id]
                                  },
                                  {"levelName": controller.levelName},
                                  {"levelIndex": controller.levelIndex},
                                  {"subLevelIndex": (index == 10 ? levelIndex - 1 : levelIndex).toString()},
                                  {"celebData" :controller.celebsData},
                                  {"levelTotalLength" :controller.levelLength.value}
                                ],
                              );
                            }
                          },
                          child: index == 9 || index == 11
                              ? Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(index == 9
                                        ? ImageConstants.leftArrow
                                        : index == 11
                                        ? ImageConstants.rightArrow
                                        : ImageConstants.lockedLevel),
                                    fit: BoxFit.fill),
                              ))
                              : controller.celebsData.isNotEmpty
                              ?  controller.completeLevelId.value.length >= levelIndex && controller.completeLevelId.isNotEmpty &&
                              controller.completeLevelId.value.contains(controller.celebsData[index == 10 ? levelIndex - 1 : levelIndex][FirebaseConstant.id])
                              ? CachedNetworkImage(
                            imageUrl: controller.celebsData[index == 10 ? levelIndex - 1 : levelIndex][FirebaseConstant.imageUrl],
                            imageBuilder: (context, imageProvider) =>
                                Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: ColorConstants.white, width: displayWidth(context)*0.02),
                                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                  ),
                                  child: Align(
                                    alignment: displayHeight(context) > 1000 ? const Alignment(1.6, -1.6) : displayHeight(context) < 550 ? const Alignment(1.5, -1.6) : const Alignment(1.35, -1.5),
                                    child: Image(
                                      image: AssetImage(controller.celebsData[index == 10 ? levelIndex - 1 : levelIndex][FirebaseConstant.starDetail] ?? ImageConstants.silverStar),
                                      height: displayHeight(context) * 0.04,
                                    ),
                                  ),
                                ),
                            progressIndicatorBuilder: (context, url, progress) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: Container(
                                  height: displayHeight(context) < 1000
                                      ? displayHeight(context) * 0.12
                                      : displayHeight(context) * 0.05,
                                  width: displayWidth(context) < 600
                                      ? displayWidth(context) * 0.1
                                      : displayWidth(context) * 0.04,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),

                                  ),
                                ),

                              );
                            },
                            // progressIndicatorBuilder: (context, url, progress) => CircularProgressIndicator(color: ColorConstants.purpleColor.withOpacity(0.2)),
                            errorWidget: (context, url, error) =>
                                Container(
                                  height: displayHeight(context) < 1000
                                      ? displayHeight(context) * 0.12
                                      : displayHeight(context) * 0.05,
                                  width: displayWidth(context) < 600
                                      ? displayWidth(context) * 0.1
                                      : displayWidth(context) * 0.04,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: ColorConstants.white, width: 8),
                                    image: const DecorationImage(image: AssetImage(ImageConstants.gameLogo), fit: BoxFit.scaleDown),
                                  ),
                                ),
                          )
                              : Container(
                            height: displayHeight(context) < 1000
                                ? displayHeight(context) * 0.12
                                : displayHeight(context) * 0.05,
                            width: displayWidth(context) < 800
                                ? displayWidth(context) * 0.1
                                : displayWidth(context) * 0.04,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: checkIndex
                                    ? const AssetImage(ImageConstants.levelToPlay)
                                    : const AssetImage(ImageConstants.lockedLevel),
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                              : const SizedBox()),
                    );
                  },
                ));
          },
        ));
  }
}
