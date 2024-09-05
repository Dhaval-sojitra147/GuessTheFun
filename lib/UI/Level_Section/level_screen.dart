import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class LevelScreen extends GetView<LevelController> {

  LevelScreen({super.key,});

  @override
  LevelController controller = Get.put(LevelController());
  NetworkController networkController = Get.put(NetworkController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => WillPopScope(
      onWillPop: () async {
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
                  fit: BoxFit.fill),),
            child:  networkController.outOfNetwork.value ? noInternetDialog(context: context) :SafeArea(
              child: Column(
                children: [
                  TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.easeIn,
                    tween: Tween(begin: -1.0, end: 0.0),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0.0, value * 300),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                              EdgeInsets.only(
                                  top: displayHeight(context) * 0.03,bottom: displayHeight(context)*0.07),
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
                                          Get.offAndToNamed(RoutesConstants
                                              .mainLevelScreen,);
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
                                        "${controller.levelName} Level",
                                        style: TextStyleConstant.textBold22(color: ColorConstants.purpleColor),
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
                                            padding: EdgeInsets.only(right: displayWidth(context) * 0.02),
                                            child: Text("${controller.completedLevelLength}/${controller.levelLength.value}",
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
                            Obx(() =>
                                Visibility(
                                  visible: controller.levelVisible.value,
                                  child: IndicatorWidget(indicatorColor: ColorConstants.black, selectedIndex: controller.initialIndex.value),
                                )),
                          ],
                        ),);
                    },
                  ),

                  Obx(
                    ()=> Visibility(
                      visible: controller.levelVisible.value,
                      child: Expanded(
                        child: PageView.builder(
                          itemCount: (controller.levelLength.value/10).ceil() ,
                          physics: const NeverScrollableScrollPhysics(),
                          controller: controller.introController!.value,
                          onPageChanged: (index) {
                            controller.initialIndex.value = index;
                          },
                          itemBuilder: (context, index) {
                            return LevelPage(pageId: index);
                          },),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
