import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class MainLevelScreen extends GetView<MainLevelController> {
  MainLevelScreen({super.key});

  @override
  MainLevelController controller = Get.put(MainLevelController());
  CelebHomeController celebHomeController = Get.put(CelebHomeController());
  NetworkController networkController = Get.put(NetworkController());

  @override
  Widget build(BuildContext context) {
    return Obx(
          ()=> WillPopScope(
        onWillPop: () async{
          return false;
        },
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: Scaffold(
            body: Container(
              height: displayHeight(context),
              width: displayWidth(context),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ImageConstants.mainLevelBg),
                      fit: BoxFit.fill)),
              child:  SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: displayHeight(context) * 0.03,bottom: displayHeight(context)*0.02),
                      child: Container(
                        height: displayHeight(context) * 0.065,
                        width: displayWidth(context) * 0.9,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                              bottomLeft: Radius.circular(50),
                            )),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.offNamedUntil(RoutesConstants.celebHomeScreen,(route) => true,);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: displayHeight(context) * 0.0063,left: displayHeight(context) * 0.0063),
                                  child: Image(
                                    image: const AssetImage(
                                        ImageConstants.backIcon),
                                    height: displayHeight(context) *
                                        0.05,
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: displayWidth(context) * 0.04,
                                  bottom: displayHeight(context) * 0.005),
                              child: Text(
                                AppConstants.levels.tr,
                                style: TextStyleConstant.textBold22(
                                    color: ColorConstants.purpleColor),
                              ),
                            ),
                            const Spacer(),
                            TweenAnimationBuilder(
                              duration: const Duration(milliseconds: 1500),
                              curve: Curves.easeIn,
                              tween: Tween(begin: 1.0, end: 0.0),
                              builder: (context, value, child) {
                                return Transform.translate(offset: Offset(
                                    value * 500,
                                    0.0
                                ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: displayWidth(context) * 0.02),
                                    child: Text(
                                      "${controller.completeLevelId.value.length}/${controller.totalLevel.value}",
                                      style: TextStyleConstant.textBold16(color: ColorConstants.purpleColor),
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    networkController.outOfNetwork.value ? noInternetDialog(context: context) : Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: displayHeight(context)*0.02),

                        child: Container(
                          width: displayWidth(context) * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return TweenAnimationBuilder(duration: const Duration(milliseconds: 1500),
                                curve: Curves.easeInOutCubic,
                                tween: Tween(begin: index.isOdd ?-1.0 :1.0, end: 0.0),
                                builder: (context, value, child) {
                                  return Transform.translate(
                                    offset: index == 0 ? Offset(value * 400, 0.0) : index == 1 ? Offset(value * 500, 0.0) : index == 2 ?Offset(value * 600, 0.0):index == 3 ?Offset(value * 800, 0.0):Offset(value * 1000, 0.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        index == 0 || (index == 1 && controller.completeLevelId.length >= 100) ||(index == 2 && controller.completeLevelId.length >= 200) || (index == 3 && controller.completeLevelId.length >= 300) ||(index == 4 && controller.completeLevelId.length >= 400)  ?
                                        Get.offAndToNamed(RoutesConstants.levelScreen,arguments: [
                                          {
                                            "levelName": controller.levelListName[index]
                                          },
                                          {"levelIndex": index},
                                          {"levelTotalLength": controller.levelLength.value[index]},
                                        ],) :
                                        Get.snackbar(
                                          AppConstants.warning.tr,
                                          "Please clear ${controller.levelListName[index-1]}",
                                          snackStyle: SnackStyle.FLOATING,
                                          backgroundGradient: ColorConstants.queAnsBgGradiant,
                                          snackPosition: SnackPosition.BOTTOM,
                                          duration: const Duration(seconds: 1),
                                          colorText: ColorConstants.redColor,
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(controller.baseImage[index]),
                                                fit: BoxFit.fill)),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: displayWidth(context) * 0.08,
                                                  bottom: displayHeight(context) * 0.035,top: displayHeight(context)*0.035),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    index == 0 ? AppConstants.noob.tr : index == 1 ?AppConstants.intern.tr:index == 2 ? AppConstants.expert.tr:index == 3 ?AppConstants.master.tr:AppConstants.legend.tr,
                                                    style: TextStyleConstant.textBold32(color: controller.levelTextColor[index]),
                                                  ),
                                                  Text(
                                                    controller.completeLevelLength.value.isNotEmpty && controller.levelLength.value.isNotEmpty ?  "${controller.completeLevelLength.value[index]}/${controller.levelLength.value[index]}" : "00/00",
                                                    style: TextStyleConstant.textBold20(color: ColorConstants.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const Spacer(),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: displayWidth(context) * 0.1),
                                              child: Container(
                                                height: displayHeight(context) * 0.08,
                                                width: displayWidth(context) > 600 ? displayWidth(context)*0.12:displayWidth(context) * 0.15,
                                                decoration: BoxDecoration(
                                                    color: ColorConstants.black.withOpacity(0.46),
                                                    borderRadius: BorderRadius.circular(15)),
                                                child:
                                                (index == 1 && controller.completeLevelId.length < 100) ||
                                                    (index == 2 && controller.completeLevelId.length < 200)||
                                                    (index == 3 && controller.completeLevelId.length < 300)||
                                                    (index == 4 && controller.completeLevelId.length < 400) ?
                                                Center(
                                                  child: Image(
                                                    image: const AssetImage(
                                                        ImageConstants.lockedIcon),
                                                    height: displayHeight(context) * 0.06,
                                                  ),
                                                ) : Center(
                                                  child: Image(
                                                    image: AssetImage(controller.smilyImage[index]),height: displayHeight(context)*0.065,),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
