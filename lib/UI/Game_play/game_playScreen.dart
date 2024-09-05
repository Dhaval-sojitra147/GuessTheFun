import 'dart:convert';
import 'dart:developer' as dev;
import 'package:celebrity_quiz/Infrastructure/Base/AdHelper/facebook_adManager.dart';
import 'package:get/get.dart';
import '../../Infrastructure/Commons/Constant/export.dart';

class GamePlayScreen extends GetView<GamePlayController> {
  const GamePlayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GamePlayController controller = Get.put(GamePlayController(contexts: context));
    // FacebookAdController facebookAdController = Get.put(FacebookAdController());
    CelebHomeController celebHomeController = Get.put(CelebHomeController());
    NetworkController networkController = Get.put(NetworkController());
    SettingController settingController = Get.put(SettingController());
    AdMobServices adMobServices = Get.put(AdMobServices());

    RxInt eyeOpenFirstValue = int.parse(controller.eyeOpenGrid.first).obs;

    // String zero = "0";
    // String userLevelId = int.parse(controller.subLevelIndex) <= 9
    //     ? "$zero$zero${controller.subLevelIndex}"
    //     : int.parse(controller.subLevelIndex) <= 99
    //         ? "$zero${controller.subLevelIndex}"
    //         : controller.subLevelIndex;
    // onAdComplete() async {
    //   // controller.fireStore
    //   //     .collection(
    //   //     FirebaseConstant.userKey)
    //   //     .doc(userDeviceID)
    //   //     .update(controller
    //   //     .skipLevelDataUpdate(isLoss: true));
    //   // controller.fireStore
    //   //     .collection(
    //   //     FirebaseConstant.userKey)
    //   //     .doc(userDeviceID)
    //   //     .collection(controller.levelName
    //   //     .toLowerCase())
    //   //     .doc(userLevelId)
    //   //     .set(
    //   //     controller.completedLevelData(
    //   //         isLoss: true));
    //   int randomNumber = Random().nextInt(10) + 1;
    //   controller.gameCoin.value = controller.gameCoin.value + randomNumber;
    //   // controller.fireStore
    //   //     .collection(FirebaseConstant.userKey)
    //   //     .doc(userDeviceID)
    //   //     .update({
    //   //   FirebaseConstant.userCoin: (controller.gameCoin.value).toString(),
    //   //   FirebaseConstant.adCoin:
    //   //       (controller.adCoin.value + randomNumber).toString(),
    //   // });
    //
    //   await SharedPref().addStringToSF(StorageConstants.gameCoin, (controller.gameCoin.value).toString());
    //   await SharedPref().addStringToSF(StorageConstants.adCoin, (controller.adCoin.value + randomNumber).toString());
    //   Get.back();
    //   Future.delayed(
    //     const Duration(milliseconds: 500),
    //     () {
    //       Get.offNamed(
    //         RoutesConstants.mainLevelScreen,
    //       );
    //       // Get.back();
    //       // Get.back();
    //     },
    //   );
    // }
   dev.log("this one is height===> ${displayHeight(context)}");
   dev.log("this one is width===> ${displayWidth(context)}");
    return GetBuilder<GamePlayController>(
        init: GamePlayController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async{
              return false;
            },
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: Scaffold(
                body: Stack(
                  children: [
                    Container(
                        height: displayHeight(context),
                        width: displayWidth(context),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(ImageConstants.mainLevelBg),
                              fit: BoxFit.fill),
                        ),
                        child: networkController.outOfNetwork.value
                            ? noInternetDialog(context: context)
                            : SafeArea(
                          bottom: false,

                              child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                            height: displayHeight(context) * 0.12,
                                            width: displayWidth(context),
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      ImageConstants.topBarBase),
                                                  fit: BoxFit.fill),
                                            ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              TweenAnimationBuilder(
                                                duration: const Duration(milliseconds: 1500),
                                                curve: Curves.easeIn,
                                                tween: Tween(begin: -1.0, end: 0.0),
                                                builder: (context, value, child) {
                                                  return Transform.translate(
                                                    offset: Offset(value * 300, 0.0),
                                                    child: Container(
                                                      height: displayHeight(context) * 0.054,
                                                      width: displayWidth(context) * 0.55,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                          BorderRadius.circular(35)),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(4.0),
                                                            child: Image.asset(ImageConstants.timerWatch,
                                                              width: displayWidth(context) *
                                                                  0.1,
                                                            ),
                                                          ),
                                                          Text("${controller.remainTime}",
                                                            style: TextStyleConstant.textBold20(),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                left: displayWidth(context) * 0.03,
                                                                top: displayHeight(context) * 0.01),
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                  width: displayWidth(context) * 0.33,
                                                                  height: displayHeight(context) * 0.017,
                                                                  decoration: BoxDecoration(
                                                                      color: ColorConstants.offWhiteColor,
                                                                      borderRadius: BorderRadius.circular(10)),
                                                                ),
                                                                AnimatedContainer(
                                                                  duration:
                                                                  const Duration(seconds: 1),
                                                                  width: controller.timerContainerWidth.value,
                                                                  height: displayHeight(context) * 0.017,
                                                                  decoration: BoxDecoration(
                                                                      image: const DecorationImage(
                                                                          image: AssetImage(ImageConstants.timerImage),
                                                                          fit: BoxFit.fitHeight),
                                                                      borderRadius: BorderRadius.circular(10)),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: displayWidth(
                                                                              context) *
                                                                              0.065),
                                                                      child: Image.asset(
                                                                        ImageConstants.bronzeStar,
                                                                        width: displayWidth(context) * 0.05,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                          displayWidth(context) *
                                                                              0.06),
                                                                      child: Image
                                                                          .asset(
                                                                        ImageConstants
                                                                            .silverStar,
                                                                        width: displayWidth(
                                                                            context) *
                                                                            0.05,
                                                                      ),
                                                                    ),
                                                                    Image.asset(
                                                                      ImageConstants
                                                                          .goldStar,
                                                                      width: displayWidth(
                                                                          context) *
                                                                          0.05,
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              TweenAnimationBuilder(
                                                duration: const Duration(
                                                    milliseconds: 1500),
                                                curve: Curves.easeIn,
                                                tween: Tween(begin: 1.0, end: 0.0),
                                                builder: (context, value, child) {
                                                  return Transform.translate(
                                                    offset:
                                                    Offset(value * 300, 0.0),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: displayWidth(
                                                              context) *
                                                              0.07),
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
                                                              child: Image(
                                                                image: const AssetImage(
                                                                    ImageConstants.coinIcon),
                                                                height: displayHeight(context) * 0.05,
                                                              ),
                                                            ),
                                                            Text(
                                                              "${controller.gameCoin.value}",
                                                              style:
                                                              TextStyleConstant
                                                                  .textBold16(),
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
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6.0),
                                          child: Stack(
                                            children: [
                                              Container(
                                                  height: displayHeight(context) > 550 &&  displayHeight(context) < 750 ? displayHeight(context)*0.55 : displayHeight(context) < 550  ? displayHeight(context)*0.57 : displayHeight(context) > 1000? displayHeight(context) * 0.5:displayHeight(context)*0.48,
                                                  width: displayHeight(context) > 1000 ? displayWidth(context) *0.7:displayWidth(context),
                                                  decoration: const BoxDecoration(
                                                      color: ColorConstants.white),
                                              child:controller
                                                  .celebImage.isNotEmpty
                                                  ?  Stack(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(displayWidth(context)*0.015),
                                                        child: SizedBox(
                                                          height: displayHeight(context) > 550 &&  displayHeight(context) < 750 ? displayHeight(context)*0.53 :displayHeight(context) < 550  ? displayHeight(context)*0.555 : displayHeight(context) > 1000? displayHeight(context) * 0.465:displayHeight(context)*0.44,
                                                          width: displayHeight(context) > 1000 ? displayWidth(context) *0.7:displayWidth(context)*0.98,

                                                          child: CachedNetworkImage(
                                                                  imageUrl: controller.celebImage,
                                                                  fit: BoxFit.fill,),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.all(displayWidth(context)*0.01),
                                                        child: GridView.builder(
                                                          physics: const NeverScrollableScrollPhysics(),
                                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10,),

                                                          itemCount: 100,
                                                          itemBuilder: (context, index) {
                                                            setEyeOpenAd() {
                                                              index < eyeOpenFirstValue.value ? addEyeOpenUpGrid(isPointShow: true) : addEyeOpenDownGrid(isPointShow: true);

                                                              // add index in eyeOpenGridList
                                                              index < eyeOpenFirstValue.value ? addEyeOpenUpGrid(isPointShow: false) : addEyeOpenDownGrid(isPointShow: false);

                                                              controller.eyeOpenGrid.sort((a, b) => a.compareTo(b));
                                                              controller.gridCutPointShow.sort((a, b) => a.compareTo(b));
                                                            }

                                                            return controller.eyeOpenGrid.isNotEmpty
                                                                ? GestureDetector(
                                                              onTap: () async {
                                                                controller.animationTurns.value = controller.animationTurns.value + 6.27;
                                                                // Future.delayed(const Duration(milliseconds: 500),() {
                                                                //   controller.animationTurns.value = controller.animationTurns.value - 6.27;
                                                                //
                                                                // },);
                                                                if (controller.gameCoin.value >= 12 &&
                                                                    controller.showGrid(index) &&
                                                                    !controller.gridCutPointShow.contains(index)) {
                                                                  // add index in pointShowEye
                                                                  setEyeOpenAd();
                                                                  if (settingController.sound.value) {
                                                                    AudioPlayer.playSound(audioName: AudioConstants.coinBreak);
                                                                  }
                                                                  controller.gameCoin.value = controller.gameCoin.value - 12;
                                                                  await SharedPref().addStringToSF(StorageConstants.gameCoin, controller.gameCoin.value.toString());
                                                                  controller.update();
                                                                } else if (controller.showGrid(index) &&
                                                                    !controller.gridCutPointShow.contains(index)) {
                                                                  controller.timer!.cancel();

                                                                  if (celebHomeController.isGetCoinAdReady.value) {
                                                                    celebHomeController.getCoinAd!.show(
                                                                        onUserEarnedReward:
                                                                            (ad, RewardItem reward) async {
                                                                          controller.updateCoinData(context);
                                                                          setEyeOpenAd();
                                                                        });
                                                                  } else {
                                                                    adMobServices.showInterstitialAd(
                                                                      onAdDismissedFullScreenContent:
                                                                          (ad) {
                                                                        ad.dispose();
                                                                        adMobServices.createInterstitialAd();
                                                                      },
                                                                    );
                                                                    controller.updateCoinData(context);
                                                                    setEyeOpenAd();
                                                                  }

                                                                  // if (facebookAdController.isRewardedAdLoaded && !adMob.value && faceBookAd.value) {
                                                                  //   facebookAdController.showFacebookRewardedAd();
                                                                  //   Future.delayed(const Duration(seconds: 13),
                                                                  //         () async {
                                                                  //       controller.updateCoinData(context);
                                                                  //       setEyeOpenAd();
                                                                  //     },
                                                                  //   );
                                                                  // } else if (!facebookAdController.isRewardedAdLoaded && facebookAdController.isInterstitialAdLoaded && !adMob.value && faceBookAd.value) {
                                                                  //   facebookAdController.showFacebookInterstitialAd();
                                                                  //   Future.delayed(
                                                                  //     const Duration(seconds: 13),
                                                                  //         () async {
                                                                  //       controller.updateCoinData(context);
                                                                  //       setEyeOpenAd();
                                                                  //     },
                                                                  //   );
                                                                  // }
                                                                  //
                                                                  // if (!adMob.value && !faceBookAd.value) {
                                                                  //   await UnityAdController().showUnityRewardedAd(
                                                                  //     onComplete: (placementId) async {
                                                                  //       controller.updateCoinData(context);
                                                                  //       await UnityAdController().loadUnityRewardedAd();
                                                                  //       setEyeOpenAd();
                                                                  //     },
                                                                  //   );
                                                                  // }
                                                                }
                                                              },
                                                              child: AnimatedRotation(
                                                                turns: controller.showGrid(index) ? 1 : controller.optionOne.value ||
                                                                    controller.optionTwo.value ||
                                                                    controller.optionThree.value ||
                                                                    controller.optionFour.value ? 50.0 : 0.0,
                                                                duration: int.parse(controller.eyeOpenGrid.first) - 10  == index || int.parse(controller.eyeOpenGrid.last) + 5 == index
                                                                    ? const Duration(milliseconds: 200)
                                                                    :  int.parse(controller.eyeOpenGrid.first) - 9  == index || int.parse(controller.eyeOpenGrid.last) + 6 == index
                                                                    ? const Duration(milliseconds: 300)
                                                                    :  int.parse(controller.eyeOpenGrid.first) - 8  == index || int.parse(controller.eyeOpenGrid.last) + 7 == index
                                                                    ? const Duration(milliseconds: 400)
                                                                    :  int.parse(controller.eyeOpenGrid.first) - 7  == index || int.parse(controller.eyeOpenGrid.last) + 8 == index
                                                                    ? const Duration(milliseconds: 500)
                                                                    :  int.parse(controller.eyeOpenGrid.first) - 6  == index || int.parse(controller.eyeOpenGrid.last) + 9 == index
                                                                    ? const Duration(milliseconds: 600)
                                                                    :  int.parse(controller.eyeOpenGrid.first) - 5  == index || int.parse(controller.eyeOpenGrid.last) + 10 == index
                                                                    ? const Duration(milliseconds: 700)
                                                                    :const Duration(milliseconds: 250),
                                                                child: AnimatedContainer(
                                                                  duration:const Duration(milliseconds: 250),
                                                                  transformAlignment: Alignment.center,
                                                                  decoration: BoxDecoration(
                                                                    // gradient: LinearGradient(
                                                                    //   colors: [
                                                                    //     ColorConstants.wrongAnswerColor.withOpacity(1.0),
                                                                    //     ColorConstants.qaPurpleColor.withOpacity(1.0),
                                                                    //   ],
                                                                    //
                                                                    //   begin: AlignmentDirectional.topStart,
                                                                    //   end: AlignmentDirectional.bottomEnd,
                                                                    // ),
                                                                      color: controller.gridCutPointShow.contains(index.toString())
                                                                          ? ColorConstants.transparent
                                                                          : controller.showGrid(index) && !controller.gridCutPointShow.contains(index.toString())
                                                                          ? ColorConstants.lightPurpleColor
                                                                          : controller.showEye(index.toString()),
                                                                      border: Border(
                                                                        right: BorderSide(
                                                                          color: controller.gridCutPointShow.contains(index.toString())
                                                                              ? ColorConstants.transparent
                                                                              : controller.showEyeBorder(index.toString()),
                                                                          width: 2,
                                                                        ),
                                                                        top: BorderSide(
                                                                          color: controller.gridCutPointShow.contains(index.toString())
                                                                              ? ColorConstants.transparent
                                                                              : controller.showEyeBorder(index.toString()),
                                                                          width: 2,
                                                                        ),
                                                                      )),
                                                                  child: controller.showGrid(index) &&
                                                                      !controller.gridCutPointShow.contains(index
                                                                          .toString())
                                                                      ? Center(
                                                                      child: Text("-2",
                                                                        style: TextStyleConstant.textBold14(color: ColorConstants.purpleColor.withOpacity(0.6)),
                                                                      ))
                                                                      : const SizedBox(),
                                                                ),
                                                              ),
                                                            )
                                                                : Container(
                                                              // width: displayHeight(context) > 1000
                                                              //     ? displayWidth(context) * 0.06
                                                              //     : displayWidth(context) * 0.096,
                                                              // height: displayHeight(context) > 1000
                                                              //     ? displayHeight(context) * 0.04
                                                              //     : displayHeight(context) * 0.052,
                                                              decoration:
                                                              BoxDecoration(
                                                                  color: ColorConstants.redColor,
                                                                  border: Border(
                                                                    right: BorderSide(
                                                                      color: controller.showEyeBorder(index.toString()),
                                                                      width: 2,
                                                                    ),
                                                                    top: BorderSide(
                                                                      color: controller.showEyeBorder(index.toString()),
                                                                      width: 2,
                                                                    ),
                                                                  )),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: controller.showFirstHint.value && controller.showHint.value,
                                                        child: TweenAnimationBuilder(
                                                          duration: const Duration(milliseconds: 1500),
                                                          curve: Curves.easeInOut,
                                                          tween: Tween(begin: 1.0, end: 0.0),
                                                          builder: (context, value, child) {
                                                            return Transform.translate(
                                                                offset: Offset(value * 50, value * 10),
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(
                                                                      top: displayHeight(context) < 750 ? displayHeight(context)* 0.42 : displayHeight(context) * 0.32,
                                                                      left: displayWidth(context) * 0.15),
                                                                  child: AnimatedContainer(
                                                                      duration: const Duration(milliseconds: 500),
                                                                      transform: Matrix4.rotationZ(6.28),
                                                                      height: displayHeight(context) * 0.12,
                                                                      width: displayWidth(context) * 0.7,
                                                                      decoration:
                                                                      const BoxDecoration(
                                                                          image: DecorationImage(image: AssetImage(ImageConstants.hintBase),fit: BoxFit.fill)
                                                                      ),
                                                                      child: !controller.showSecondHint.value &&
                                                                          controller.showHint.value
                                                                          ? Center(
                                                                        child: Text(
                                                                          controller.hintText[0],
                                                                          style: TextStyleConstant.textBold22(
                                                                              color: ColorConstants.purpleColor.withOpacity(0.5)),
                                                                          textAlign: TextAlign.center,
                                                                        ),
                                                                      )
                                                                          : Center(
                                                                        child: Text(
                                                                          controller.hintText[1],
                                                                          style: TextStyleConstant.textBold22(
                                                                              color: ColorConstants.purpleColor.withOpacity(0.5)),
                                                                          textAlign: TextAlign.center,
                                                                        ),
                                                                      )),
                                                                ));
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ) : const SizedBox(),
                                              ),

                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                              decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(ImageConstants.qaBase),
                                                fit: BoxFit.fill),
                                          ),
                                            child: Center(
                                              child: TweenAnimationBuilder(
                                                duration:
                                                const Duration(milliseconds: 1500),
                                                curve: Curves.easeIn,
                                                tween: Tween(begin: 1.0, end: 0.0),
                                                builder: (context, value, child) {
                                                  return Transform.translate(
                                                    offset: Offset(value * 500, 0.0),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(padding: EdgeInsets.only(left: displayWidth(context) * 0.02,),
                                                          child: Text(
                                                            AppConstants.que.tr,
                                                            style: TextStyleConstant.textBold32(
                                                                color: ColorConstants.white),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left: displayWidth(context) * 0.02,
                                                              top: displayHeight(context) < 550 || displayHeight(context) > 1000? displayHeight(context) * 0.01 :displayHeight(context) * 0.03),
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: optionButton(
                                                                    index: 0,
                                                                    option: controller.optionOne.value,
                                                                    context: context),
                                                              ),
                                                              optionButton(
                                                                  index: 1,
                                                                  option: controller.optionTwo.value,
                                                                  context: context)
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left: displayWidth(context) * 0.02),
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: optionButton(
                                                                    index: 2,
                                                                    option: controller.optionThree.value,
                                                                    context: context),
                                                              ),
                                                              optionButton(
                                                                  index: 3,
                                                                  option: controller.optionFour.value,
                                                                  context: context),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TweenAnimationBuilder(
                                      duration: const Duration(milliseconds: 1500),
                                      curve: Curves.easeIn,
                                      tween: Tween(begin: 1.0, end: 0.0),
                                      builder: (context, value, child) {
                                        return Transform.translate(
                                          offset: Offset(value * -300, 0.0),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top:  displayHeight(context) * 0.145,
                                                left: displayHeight(context) > 1000
                                                    ? displayWidth(context) * 0.16
                                                    :  displayWidth(context) * 0.05),
                                            child: GestureDetector(
                                              onTap: !controller.optionOne.value && !controller.optionTwo.value && !controller.optionThree.value &&!controller.optionFour.value? () {
                                                controller.timer!.cancel();
                                                controller.animationController.dispose();
                                                settingController.vibration.value ==
                                                    true ? Vibration.vibrate(duration: 100, amplitude: 128) :Vibration.vibrate(duration: 0, amplitude: 0);
                                                Get.back();
                                                Get.offNamed(RoutesConstants.levelScreen, arguments: [
                                                  {"levelName": controller.levelName},
                                                  {"levelIndex": controller.levelIndex.value},
                                                  {"levelTotalLength": controller.levelLength.value},
                                                ]) ;
                                                // QuitDialog().quitDialog(
                                                //   context: context,
                                                //   alignmentGeometry:  const Alignment(-0.8,-0.7),
                                                //   onNoTap: () {
                                                //     controller.startPlayingTimer(context);
                                                //     controller.timerContainerWidth.value = displayWidth(context) * (controller.remainTime.value * 0.016);
                                                //     Get.back();
                                                //   },
                                                //   onTap: () {
                                                //     settingController.vibration.value ==
                                                //         true ? Vibration.vibrate(duration: 100, amplitude: 128) :Vibration.vibrate(duration: 0, amplitude: 0);
                                                //     Get.back();
                                                //     Get.offNamed(RoutesConstants.levelScreen, arguments: [
                                                //       {"levelName": controller.levelName},
                                                //       {"levelIndex": controller.levelIndex.value},
                                                //       {"levelTotalLength": controller.levelLength.value},
                                                //     ]) ;
                                                //
                                                //   },);

                                              } : (){},
                                              child: Container(
                                                width: displayWidth(context) * 0.12,
                                                height: displayHeight(context) * 0.06,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(image: AssetImage(ImageConstants.backIconButton), fit: BoxFit.fill),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    TweenAnimationBuilder(
                                      duration: const Duration(milliseconds: 1500),
                                      curve: Curves.easeIn,
                                      tween: Tween(begin: 1.0, end: 0.0),
                                      builder: (context, value, child) {
                                        return Transform.translate(
                                          offset: Offset(value * 300, 0.0),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: displayHeight(context) > 550 &&  displayHeight(context) < 750 ? displayHeight(context)*0.63 : displayHeight(context) < 550 ? displayHeight(context)*0.65 : displayHeight(context) * 0.57,
                                                left: displayHeight(context) > 1000
                                                    ? displayWidth(context) * 0.7
                                                    : displayWidth(context) * 0.78),
                                            child: GestureDetector(
                                              onTap: () {
                                                controller.timer!.cancel();
                                                HintDialog().hintDialog(context: context);
                                              },
                                              child: Container(
                                                width: displayHeight(context) > 1000 ? displayWidth(context) * 0.15:displayWidth(context) * 0.18,
                                                height: displayHeight(context) * 0.085,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(image: AssetImage(ImageConstants.hintIcon), fit: BoxFit.fill),
                                                ),
                                                child: !controller.showFirstHint.value ||
                                                    !controller.showSecondHint.value
                                                    ? Align(
                                                    alignment: const Alignment(0.78, -0.85),
                                                    child: CircleAvatar(radius: displayWidth(context) * 0.024,
                                                      backgroundColor: ColorConstants.white,
                                                      child: CircleAvatar(
                                                          radius: displayWidth(context) * 0.022,
                                                          backgroundColor: Colors.red,
                                                          child: Center(
                                                              child: Text(!controller.showFirstHint.value ? "2" : "1", style: TextStyleConstant.textBold10(color: ColorConstants.white),
                                                              ))),
                                                    ))
                                                    : const SizedBox(),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    // Visibility(
                                    //   visible: controller.isBonusLevel.value,
                                    //   child: DelayedDisplay(
                                    //     delay: const Duration(milliseconds: 3000),
                                    //     child: TweenAnimationBuilder(
                                    //       duration: const Duration(milliseconds: 1500),
                                    //       curve: Curves.easeIn,
                                    //       tween: Tween(begin: 1.0, end: 0.0),
                                    //       builder: (context, value, child) {
                                    //         return Transform.translate(
                                    //           offset: Offset(0.0,value * 300),
                                    //           child: Align(
                                    //               alignment: Alignment.bottomCenter,
                                    //               child: Text(AppConstants.bonusLevel.tr,style: TextStyleConstant.textBold28(color: ColorConstants.white))),
                                    //         );
                                    //       },
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                            )),
                    Visibility(
                      visible: controller.showGridSuggestion.value || controller.showHintSuggestion.value ,
                      child: Container(
                        height: displayHeight(context),
                        width: displayWidth(context),
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(controller.showGridSuggestion.value ? ImageConstants.gridOpenGuide : ImageConstants.hintGuide),opacity: 0.7,fit: BoxFit.fill)
                        ),
                      ),
                    ),
                    // Visibility(
                    //   visible: controller.showGridSuggestion.value ,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       controller.showGridSuggestion.value = false;
                    //       addEyeOpenUpGrid(isPointShow: true);
                    //       addEyeOpenUpGrid(isPointShow: false);
                    //       controller.update();
                    //     },
                    //     child: Align(
                    //       alignment: const Alignment(0,-0.54),
                    //       child: Container(
                    //         height: displayHeight(context) *0.05,
                    //         width: displayWidth(context) * 0.7,
                    //         decoration: BoxDecoration(
                    //             color: Colors.blue.withOpacity(0.4)
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Visibility(
                      visible: controller.showGridSuggestion.value || controller.showHintSuggestion.value ,
                      child: GestureDetector(
                        onTap: () {
                          if(controller.showGridSuggestion.value == true){
                            controller.showGridSuggestion.value = false;
                            addEyeOpenDownGrid(isPointShow: true);
                            addEyeOpenDownGrid(isPointShow: false);
                            SharedPref().setBoolToSF(StorageConstants.watchGridGuide, false);
                          }else{
                            controller.showHintSuggestion.value = false;
                            controller.showFirstHint.value = true;
                            controller.showHint.value = true;
                            if(controller.showHint.value){
                              Future.delayed(const Duration(seconds: 5),() {
                                controller.showHint.value = false;
                              },);
                            }
                            SharedPref().setBoolToSF(StorageConstants.watchHintGuide, false);
                          }

                          controller.update();
                        },
                        child: Align(
                          alignment: controller.showGridSuggestion.value ?displayHeight(context) > 550 && displayHeight(context) < 750 ? const Alignment(0, -0.15) :const Alignment(0,-0.2) :displayHeight(context) > 550 && displayHeight(context) < 750 ? const Alignment(1.1, 0.6) :const Alignment(1.1, 0.4),
                          child: Container(
                            height: displayHeight(context)*0.15,
                            width: displayWidth(context)*0.3,
                            decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage(controller.showGridSuggestion.value ? ImageConstants.gridTap : ImageConstants.hintTap),fit: BoxFit.fill),

                            ),

                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.showGridSuggestion.value || controller.showHintSuggestion.value ,
                      child: Align(
                        alignment: controller.showGridSuggestion.value ? const Alignment(0,0.5) : const Alignment(0, 0),
                        child: Text(
                          controller.showGridSuggestion.value ? AppConstants.gridGuide.tr : AppConstants.hintGuide.tr,style: TextStyleConstant.textBold20(color: ColorConstants.white),textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  GestureDetector optionButton({context, required int index, required option}) {
    SettingController settingController = Get.put(SettingController());
    return GestureDetector(
      onTap: !controller.optionOne.value &&
              !controller.optionTwo.value &&
              !controller.optionThree.value &&
              !controller.optionFour.value
          ? () async {
        settingController.vibration.value ==
            true ? Vibration.vibrate(duration: 100, amplitude: 128) :Vibration.vibrate(duration: 0, amplitude: 0);
        index == 0 ? controller.optionOne.value = true : index == 1 ? controller.optionTwo.value = true : index == 2 ? controller.optionThree.value = true : controller.optionFour.value = true;

        if (controller.options[index] == controller.celebName) {
                controller.remainTime.value > 13 ? controller.gameCoin.value = controller.gameCoin.value + 30 : controller.remainTime.value > 6 ? controller.gameCoin.value = controller.gameCoin.value + 20 : controller.gameCoin.value = controller.gameCoin.value + 10;
                controller.update();

                if (settingController.sound.value) {
                  AudioPlayer.playResultSound(isWinner: true);
                }

                for (int i = 0; i <= 99; i++) {
                  controller.eyeOpenGrid.add(i.toString());
                  controller.gridCutPointShow.add(i.toString());
                  Future.delayed(const Duration(seconds: 1), () {
                    controller.eyeOpenGrid.remove(i.toString());
                    controller.gridCutPointShow.remove(i.toString());
                  });
                }
                Future.delayed(
                  const Duration(seconds: 2),
                      () async {
                    controller.updateLocalLevelDetail(isLoss: false);

                    var winLocal = await SharedPref().getStringValuesSF(
                        controller.levelName.toLowerCase());
                    var winData = jsonDecode(winLocal);
                    winData.add(controller.completedLevelData());
                    await SharedPref().addStringToSF(controller.levelName.toLowerCase(), jsonEncode(winData));

                    // this one use when update direct into firebase.
                    // await controller.fireStore.collection(FirebaseConstant.userKey).doc(userDeviceID).update(controller.updateLevelDetail(isLoss: false));
                    await controller.fireStore.collection(FirebaseConstant.userKey).doc(userDeviceID).collection(controller.levelName.toLowerCase()).doc(controller.levelId).set(controller.completedLevelData());
                  },
                );
                // if (!controller.isBonusLevel.value) {
                //
                // } else {
                //   // controller.fireStore
                //   //     .collection(FirebaseConstant.userKey)
                //   //     .doc(userDeviceID)
                //   //     .update({
                //   //   FirebaseConstant.userCoin:
                //   //       controller.gameCoin.value.toString()
                //   // });
                //   await SharedPref().addStringToSF(StorageConstants.gameCoin, controller.gameCoin.value.toString());
                // }

                // if (controller.levelIds.value.length % 10 == 0 &&
                //     controller.bonusCount.value == 0) {
                //   controller.isBonusLevel.value = true;
                //   controller.bonusCount.value = controller.bonusCount.value + 1;
                // } else {
                //   controller.isBonusLevel.value = false;
                //   controller.bonusCount.value = 0;
                // }

                Future.delayed(
                  const Duration(milliseconds: 2000),
                  () {
                    WinDialog().winDialog(context: context);
                    },
                );
              } else {
                if (settingController.sound.value) {
                  AudioPlayer.playResultSound(isWinner: false);
                }
                Future.delayed(const Duration(milliseconds: 2),() {
                  LoseDialog().loseDialog(context: context);
                },);
              }

              controller.timer!.cancel();
              controller.update();
            }
          : () {},
      child: Container(
        width: displayWidth(context) * 0.45,
        height: displayHeight(context) * 0.08,
        decoration: BoxDecoration(
            color: option
                ? ColorConstants.rightAnswerColor
                : ColorConstants.wrongAnswerColor,
            border: option ? Border.all(color: ColorConstants.white,width: displayWidth(context)*0.005) :Border.all(color: ColorConstants.wrongAnswerColor,width: 0),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(
          controller.options.isNotEmpty ? controller.options[index] : "",
          style: TextStyle(
            // overflow: TextOverflow.ellipsis,
            color: option ? ColorConstants.black : ColorConstants.purpleColor,
            height: 0.8,
            fontSize: Get.width * 0.061,
            fontFamily: "OdudaBold",
          ),
          textAlign: TextAlign.center,
        )),
      ),
    );
  }

  addEyeOpenUpGrid({required bool isPointShow}) {
    var gridFirstValue = int.parse(controller.eyeOpenGrid.first);

    var gridOne = gridFirstValue < 15 ? "0${(gridFirstValue - 5)}" : "${(gridFirstValue - 5)}";
    var gridTwo = gridFirstValue < 15 ? "0${(gridFirstValue - 6)}" : "${(gridFirstValue - 6)}";
    var gridThree = gridFirstValue < 15 ? "0${(gridFirstValue - 7)}" : "${(gridFirstValue - 7)}";
    var gridFour = gridFirstValue < 15 ? "0${(gridFirstValue - 8)}" : "${(gridFirstValue - 8)}";
    var gridFive = gridFirstValue < 15 ? "0${(gridFirstValue - 9)}" : "${(gridFirstValue - 9)}";
    var gridSix = gridFirstValue < 15 ? "0${(gridFirstValue - 10)}" : "${(gridFirstValue - 10)}";

    return isPointShow
        ? controller.gridCutPointShow.addAll([
            "${(gridFirstValue - 5)}",
            "${(gridFirstValue - 6)}",
            "${(gridFirstValue - 7)}",
            "${(gridFirstValue - 8)}",
            "${(gridFirstValue - 9)}",
            "${(gridFirstValue - 10)}"
          ])
        : controller.eyeOpenGrid
            .addAll([gridOne, gridTwo, gridThree, gridFour, gridFive, gridSix]);
  }

  addEyeOpenDownGrid({required bool isPointShow}) {
    var gridLastValue = int.parse(controller.eyeOpenGrid.last);

    var gridOne = (gridLastValue + 5).toString();
    var gridTwo = (gridLastValue + 6).toString();
    var gridThree = (gridLastValue + 7).toString();
    var gridFour = (gridLastValue + 8).toString();
    var gridFive = (gridLastValue + 9).toString();
    var gridSix = (gridLastValue + 10).toString();

    return isPointShow
        ? controller.gridCutPointShow
            .addAll([gridOne, gridTwo, gridThree, gridFour, gridFive, gridSix])
        : controller.eyeOpenGrid
            .addAll([gridOne, gridTwo, gridThree, gridFour, gridFive, gridSix]);
  }
}
