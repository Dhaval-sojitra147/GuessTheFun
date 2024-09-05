import 'dart:developer';

import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:celebrity_quiz/UI/GameHome_section/Widget/LeaderBoard/leaderboard.dart';
import 'package:celebrity_quiz/UI/Update_popup/update_popup.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CelebHomeScreen extends GetView<CelebHomeController> {
  CelebHomeScreen({super.key,});

  @override
  CelebHomeController controller = Get.put(CelebHomeController());
  NetworkController networkController = Get.put(NetworkController());
  TimerController timerController = Get.put(TimerController());
  MainLevelController mainLevelController = Get.put(MainLevelController());
  ContainerTransitionType transitionType = ContainerTransitionType.fadeThrough;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    // log("this one testing log=====> ${int.parse(controller.buildNumber.value) >= int.parse(appBuildNumber)}");
    // log("this one testing log=====> ${int.parse(controller.buildNumber.value)}");
    // log("this one testing log=====> ${int.parse(appBuildNumber)}");
    return Obx(() => WillPopScope(
      onWillPop: () async {
        QuitDialog().quitDialog(
          context: context,
          alignmentGeometry:  const Alignment(0.8,-0.7),);
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
                    image: AssetImage(ImageConstants.homeBg),
                    fit: BoxFit.fill)),
            child:  networkController.outOfNetwork.value || controller.showPopUp.value ? noInternetDialog(context: context):
            controller.buildNumber.value >= appBuildNumber || isTestFlight.value?
            Column(
              children: [
                Row(
                  children: [
                    TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeIn,
                      tween: Tween(begin: -1.0, end: 0.0),
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(value * 150, 0.0),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: displayHeight(context) * 0.06,
                                        bottom: displayHeight(context) * 0.05,
                                        left: displayWidth(context) * 0.05,
                                        right: displayWidth(context) * 0.02),
                                    child: OpenContainer(
                                      transitionType: transitionType,
                                      transitionDuration: const Duration(milliseconds: 1000),
                                      openBuilder: (context, action) {
                                        return timerController.remainingSeconds.value == 0 ? ClaimBonusScreen(
                                          userScore: controller.userScore.value,
                                          isClaimed: false,
                                        ) : ClaimBonusScreen(
                                          userScore: controller.userScore.value,
                                          isClaimed: true,
                                        );
                                      },
                                      closedElevation: 6.0,
                                      closedBuilder: (BuildContext context, VoidCallback openContainer) {
                                        return SizedBox(
                                            height: displayHeight(context) * 0.05,
                                            width: displayWidth(context) * 0.1,
                                            child: Center(child: Image(image: const AssetImage(ImageConstants.giftIcon),height: displayHeight(context)*0.04))

                                        );
                                      },
                                    ),
                                  ),
                                  timerController.remainingSeconds.value == 0 ?
                                  Positioned(
                                    right: displayWidth(context)*0.015,
                                      bottom: displayHeight(context)*0.093,
                                      child: CircleAvatar(radius: displayWidth(context)*0.009,backgroundColor: ColorConstants.white,child: CircleAvatar(radius: displayWidth(context)*0.008,backgroundColor: Colors.red),))
                                      : const SizedBox(),
                                ],
                              ),

                              timerController.remainingSeconds.value != 0 ?  Obx(
                                    ()=> Container(
                                  height: displayHeight(context) * 0.05,
                                  width: displayWidth(context) * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: ColorConstants.white,
                                  ),
                                  child: Center(
                                      child: Text(
                                          controller.formatDuration(timerController.remainingSeconds.value),
                                          style: TextStyleConstant.textBold20(color: ColorConstants.brownColor.withOpacity(0.8)))),
                                ),
                              ) : const SizedBox(),
                            ],
                          ),
                        );
                      },
                    ),
                    const Spacer(),
                    TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeIn,
                        tween: Tween(begin: 1.0, end: 0.0),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(value * 150, 0.0),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: displayWidth(context) * 0.015),
                              child: Container(
                                height: displayHeight(context) * 0.05,
                                width: displayWidth(context) * 0.33,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: ColorConstants.white,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: displayHeight(context) * 0.01,
                                          left: displayWidth(context) * 0.01),
                                      child: const Image(
                                        image: AssetImage(ImageConstants.coinIcon),
                                      ),
                                    ),
                                    Obx(
                                      ()=> Text(
                                        "${controller.userScore.value}",
                                        style: TextStyleConstant.textBold16(color: ColorConstants.brownColor.withOpacity(0.8)),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        GetCoinsDialog().getCoinsDialog(context: context);
                                      },
                                      child: Image(
                                        image: const AssetImage(
                                            ImageConstants.coinPurchaseIon),
                                        height: displayHeight(context) * 0.05,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                  ],
                ),
                Padding(
                  padding:
                  EdgeInsets.only(left: displayWidth(context) * 0.8),
                  child: GestureDetector(
                      onTap: () {
                        // UpdateDialog().updateDialog(context);
                        QuitDialog().quitDialog(
                          context: context,
                          alignmentGeometry:  const Alignment(0.8,-0.7),);
                      },
                      child: TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeIn,
                        tween: Tween(begin: 1.0, end: 0.0),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(value * 300, 0.0),
                            child: Image(
                              image: const AssetImage(ImageConstants.exitIcon),
                              height: displayHeight(context) * 0.07,
                            ),
                          );
                        },
                      )),
                ),
                DelayedDisplay(
                  fadingDuration: const Duration(milliseconds: 1500),
                  child: Padding(
                    padding:
                    EdgeInsets.only(top: displayHeight(context) * 0.06),
                    child: Image(image: const AssetImage(ImageConstants.logoWithFrame), height: displayHeight(context) * 0.2,),
                  ),
                ),
                DelayedDisplay(
                  fadingDuration: const Duration(milliseconds: 1500),
                  child: Padding(
                    padding: EdgeInsets.only(top: displayHeight(context) * 0.07),
                    child: GestureDetector(
                        onTap: () async {
                          controller.animationController.forward();
                          Future.delayed(const Duration(milliseconds: 200), () {
                                controller.animationController.reverse();
                              });
                          // log("this one is fcm key demo");
                          // controller.getToken();
                                    Future.delayed(const Duration(milliseconds: 100), () async {
                                      Get.toNamed(RoutesConstants.mainLevelScreen);
                                    });
                                  },
                                  child: ScaleTransition(
                                    scale: Tween<double>(
                                      begin: 1.0,
                                      end: 0.7,
                                    ).animate(controller.animationController),
                                    child: Image(
                                      image: const AssetImage(
                                        ImageConstants.playIcon,
                                      ),
                                      height: displayHeight(context) * 0.15,
                                    ),
                                  )),
                            ),
                          ),
                TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeIn,
                  tween: Tween(begin: 1.0, end: 0.0),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0.0, value * 200),
                      child: Padding(padding: EdgeInsets.only(top: displayHeight(context) * 0.15),
                      child: Container(
                        height: displayHeight(context) * 0.14,
                        width: displayWidth(context) * 0.86,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(displayWidth(context) * 0.1), topLeft: Radius.circular(displayWidth(context) * 0.1)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  SettingDialog().settingDialog(context);},
                                child: Image.asset(
                                    ImageConstants.settingIcon,
                                    height: displayHeight(context) *
                                        0.05)),
                            GestureDetector(
                                onTap: () async {
                                  // Get.to(()=>LeaderBoard(userCoin: controller.userScore.value.toString(),));
                                  RateUsDialog().rateUsDialog(context);
                                  },
                                child: Image.asset(
                                  ImageConstants.leaderBoardIcon,
                                  height:
                                  displayHeight(context) * 0.05,
                                )),
                            GestureDetector(
                                onTap: () {
                                  Share.share(
                                      AppConstants.shareTitle);
                                  },
                                child: Image.asset(
                                    ImageConstants.shareIcon,
                                    height: displayHeight(context) *
                                        0.05)),
                            GestureDetector(
                                onTap: () {
                                  if (Platform.isAndroid || Platform.isIOS) {
                                    final appId = Platform.isAndroid
                                        ? 'com.guess.the.celebrity.bollywood.trivia.guessing.quiz'
                                        : 'YOUR_IOS_APP_ID';
                                    final url = Uri.parse(
                                      Platform.isAndroid
                                          ? "market://details?id=$appId"
                                          : "https://apps.apple.com/app/id$appId",
                                    );
                                    launchUrl(
                                      url,
                                      mode: LaunchMode
                                          .externalApplication,
                                    );
                                  }
                                  },
                                child: Image.asset(
                                    ImageConstants.moreGameIcon,
                                    height: displayHeight(context) *
                                        0.05)),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
            ],
                      ) : updateDialog(context),
              ),
            ),
          ),
        ));
  }
}
