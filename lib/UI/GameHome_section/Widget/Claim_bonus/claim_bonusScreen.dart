import 'dart:developer';

import 'package:celebrity_quiz/Infrastructure/Base/AdHelper/facebook_adManager.dart';
import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
// import 'package:facebook_audience_network/ad/ad_rewarded.dart';
import 'package:get/get.dart';

class ClaimBonusScreen extends StatefulWidget {
  int userScore;
  bool isClaimed;

  ClaimBonusScreen({Key? key, required this.userScore,required this.isClaimed}) : super(key: key);

  @override
  State<ClaimBonusScreen> createState() => _ClaimBonusScreenState();
}

class _ClaimBonusScreenState extends State<ClaimBonusScreen> {
  CelebHomeController celebHomeController = Get.put(CelebHomeController());
  // FacebookAdController facebookAdController = Get.put(FacebookAdController());
  AdMobServices adMobServices = Get.put(AdMobServices());
  RxInt scoreIncrement = 20.obs;
  String seconds = "10800";
  // UnityAdController unityAdManager = Get.put(UnityAdController());
  SettingController settingController = Get.put(SettingController());


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
                  image: AssetImage(ImageConstants.mainLevelBg),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: displayHeight(context) * 0.07,
                    bottom: displayHeight(context) * 0.02),
                child: Container(
                  height: displayHeight(context) * 0.06,
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
                            Get.back();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: displayHeight(context) * 0.0063),
                            child: Image(
                              image: const AssetImage(ImageConstants.backIcon),
                              height: displayHeight(context) * 0.1,
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                            left: displayWidth(context) * 0.04,
                            bottom: displayHeight(context) * 0.005),
                        child: Text(
                          AppConstants.claimBonusTitle.tr,
                          style: TextStyleConstant.textBold22(color: ColorConstants.purpleColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: displayWidth(context) * 0.06,
                    vertical: displayHeight(context) * 0.04),
                child: Container(
                  height: displayHeight(context) * 0.75,
                  width: displayWidth(context),
                  decoration: BoxDecoration(
                      color: ColorConstants.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: !widget.isClaimed ?  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: displayHeight(context) * 0.04),
                        child: Text(
                          AppConstants.getBonus.tr,
                          style: TextStyleConstant.textBold24(
                              color: ColorConstants.blue),
                        ),
                      ),
                      SizedBox(
                          height: displayHeight(context) * 0.15,
                          width: displayWidth(context) * 0.3,
                          child: const Image(
                            image: AssetImage(ImageConstants.coinIcon),
                            fit: BoxFit.fill,
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                            top: displayHeight(context) * 0.02,
                            bottom: displayHeight(context) * 0.03),
                        child: Container(
                          height: displayHeight(context) * 0.06,
                          width: displayWidth(context) * 0.27,
                          decoration: BoxDecoration(
                              color: ColorConstants.grey.withOpacity(0.7),
                              border: Border.all(
                                  color: ColorConstants.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Image(
                                  image: AssetImage(ImageConstants.coinIcon),
                                ),
                              ),
                              Text(
                                "${scoreIncrement.value}",
                                style: TextStyleConstant.textBold24(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        AppConstants.watchAdDoubleCoin.tr,
                        style: TextStyleConstant.textBold24(
                          color: ColorConstants.blue,
                        ),
                      ),
                      Text(
                        AppConstants.doubleBonus.tr,
                        style: TextStyleConstant.textBold24(
                            color: ColorConstants.blue),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: displayHeight(context) * 0.02,
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            settingController.vibration.value ==
                                true ? Vibration.vibrate(duration: 100, amplitude: 128) : Vibration.vibrate(duration: 0, amplitude: 0);

                            ////// Google Ad///////

                            if (celebHomeController.isClaimBonusAdReady.value) {
                              celebHomeController.claimBonusAd!.show(
                                  onUserEarnedReward: (ad, RewardItem reward) async {
                                updateData();
                              });
                            } else {
                              adMobServices.showInterstitialAd(
                                onAdDismissedFullScreenContent: (ad) {
                                  ad.dispose();
                                  adMobServices.createInterstitialAd();
                                },
                              );
                              updateData();
                            }

                            ////// Facebook Ad///////
                            // if (facebookAdController.isRewardedAdLoaded &&
                            //     !adMob.value &&
                            //     faceBookAd.value) {
                            //   facebookAdController.showFacebookRewardedAd();
                            //   Future.delayed(
                            //     const Duration(seconds: 13),
                            //     () async {
                            //       updateData();
                            //     },
                            //   );
                            // } else if (!facebookAdController
                            //         .isRewardedAdLoaded &&
                            //     facebookAdController.isInterstitialAdLoaded &&
                            //     !adMob.value &&
                            //     faceBookAd.value) {
                            //   facebookAdController.showFacebookInterstitialAd();
                            //   Future.delayed(
                            //     const Duration(seconds: 13),
                            //     () async {
                            //       updateData();
                            //     },
                            //   );
                            // }
                            //
                            // ////// Unity Ad///////
                            //
                            // if (!adMob.value && !faceBookAd.value) {
                            //   await UnityAdController().showUnityRewardedAd(
                            //     onComplete: (placementId) async {
                            //       await UnityAdController()
                            //           .loadUnityRewardedAd();
                            //       updateData();
                            //     },
                            //   );
                            // }
                            // else{
                            //   Get.snackbar(
                            //     AppConstants.sorry.tr,
                            //     AppConstants.adNotAvailable.tr,
                            //     snackStyle: SnackStyle.FLOATING,
                            //     backgroundGradient: ColorConstants.queAnsBgGradiant,
                            //     snackPosition: SnackPosition.BOTTOM,
                            //     duration: const Duration(seconds: 1),
                            //     colorText: ColorConstants.redColor,
                            //   );
                            // }
                          },
                          child: Container(
                            height: displayHeight(context) * 0.08,
                            width: displayWidth(context) * 0.45,
                            decoration: const BoxDecoration(
                                image: DecorationImage(image: AssetImage(ImageConstants.watchAdButton),fit: BoxFit.fill)),

                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          int score = widget.userScore + scoreIncrement.value;
                          // await fireStore.collection(FirebaseConstant.userKey).doc(userDeviceID).update({
                          //   FirebaseConstant.userCoin: widget.userScore.toString(),
                          //   FirebaseConstant.remainTime: "10800"
                          // });
                          settingController.vibration.value ==
                              true ? Vibration.vibrate(duration: 100, amplitude: 128) :Vibration.vibrate(duration: 0, amplitude: 0);
                          await SharedPref().addStringToSF(StorageConstants.gameCoin, score.toString());
                          await SharedPref().addStringToSF(StorageConstants.remainTime, "10800");
                          SharedPref().setBoolToSF(StorageConstants.coinExist, false);

                          Get.offAll(() => CelebHomeScreen());
                        },
                        child: Container(
                          height: displayHeight(context) * 0.08,
                          width: displayWidth(context) * 0.45,
                          decoration: BoxDecoration(
                              gradient: ColorConstants.buttonGradient,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: ColorConstants.white.withOpacity(0.95),
                                  width: 5)),
                          child: Center(
                              child: Text(
                            AppConstants.justClaim.tr,
                            style: TextStyleConstant.textBold26(
                                color: ColorConstants.white),
                          )),
                        ),
                      ),
                    ],
                  ) : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: displayHeight(context) * 0.04),
                        child: Text(
                          AppConstants.bonusClaim.tr,
                          style: TextStyleConstant.textBold24(
                              color: ColorConstants.grey),
                        ),
                      ),
                      SizedBox(
                          height: displayHeight(context) * 0.15,
                          width: displayWidth(context) * 0.3,
                          child: const Image(
                            image: AssetImage(ImageConstants.coinIcon),
                            fit: BoxFit.fill,
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  /// update Data in sharedPrefrence
  updateData() async {
    scoreIncrement.value = 40;
    int score = widget.userScore + scoreIncrement.value;
    int adCoin = celebHomeController.adCoin.value + 40;
    int bonusAdShow = celebHomeController.claimBonusAdShow.value + 1;
    // await fireStore
    //     .collection(FirebaseConstant.userKey)
    //     .doc(userDeviceID)
    //     .update({
    //   FirebaseConstant.remainTime: seconds,
    //   FirebaseConstant.userCoin: widget.userScore.toString(),
    //   FirebaseConstant.adCoin: celebHomeController.adCoin.toString(),
    //   FirebaseConstant.claimBonusAd: celebHomeController.claimBonusAdShow.toString(),
    // });

    log("this one is userScore =====> $score");
    await SharedPref().addStringToSF(StorageConstants.remainTime, seconds);
    await SharedPref().addStringToSF(StorageConstants.gameCoin, score.toString());
    await SharedPref().addStringToSF(StorageConstants.adCoin, adCoin.toString());
    await SharedPref().addStringToSF(StorageConstants.claimBonusAdShow, bonusAdShow.toString());
    SharedPref().setBoolToSF(StorageConstants.coinExist, false);

    Get.offAll(() => CelebHomeScreen());
  }
}
