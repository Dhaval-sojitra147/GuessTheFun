import 'package:celebrity_quiz/Infrastructure/Base/AdHelper/facebook_adManager.dart';
import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class GetCoinsDialog {
  CelebHomeController celebHomeController = Get.put(CelebHomeController());
  // FacebookAdController facebookAdController = Get.put(FacebookAdController());
  AdMobServices adMobServices = Get.put(AdMobServices());
  // UnityAdController unityAdManager = Get.put(UnityAdController());
  SettingController settingController = Get.put(SettingController());

  updateData() async{
    celebHomeController.adCoin = celebHomeController.adCoin + 10;
    celebHomeController.purchaseCoinAdShow = celebHomeController.purchaseCoinAdShow + 1;
    // await fireStore
    //     .collection(FirebaseConstant.userKey)
    //     .doc(userDeviceID)
    //     .update({
    //   FirebaseConstant.userCoin: (celebHomeController.userScore.value + 10).toString(),
    //   FirebaseConstant.adCoin: celebHomeController.adCoin.value.toString(),
    //   FirebaseConstant.purchaseCoinAd: celebHomeController.purchaseCoinAdShow.value.toString(),
    // });

    await SharedPref().addStringToSF(StorageConstants.gameCoin, (celebHomeController.userScore.value + 10).toString());
    await SharedPref().addStringToSF(StorageConstants.adCoin, celebHomeController.adCoin.value.toString());
    await SharedPref().addStringToSF(StorageConstants.purchaseCoinAdShow, celebHomeController.purchaseCoinAdShow.value.toString());
    SharedPref().setBoolToSF(StorageConstants.coinExist, false);
    Get.offAll(() => CelebHomeScreen());
  }

  void getCoinsDialog(
      {context}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "hello",
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          alignment: const Alignment(0.8,-0.9),
          child: DelayedDisplay(
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: ColorConstants.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              content: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 0.8),
                child: Container(
                  height: displayHeight(context) * 0.53,
                  width: displayWidth(context) * 0.8,
                  decoration: BoxDecoration(
                    image: const DecorationImage(image: AssetImage(ImageConstants.getCoinPopUpBase)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: displayHeight(context)*0.12),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: displayHeight(context) < 1000 ? EdgeInsets.symmetric(horizontal: displayWidth(context)*0.07):EdgeInsets.symmetric(horizontal: displayWidth(context)*0.2),
                              child: Text(AppConstants.getCoinTitle.tr,style: TextStyleConstant.textBold28(color: ColorConstants.purpleColor.withOpacity(0.5),shadow: const Shadow(
                                blurRadius: 40.0,
                                color: Colors.grey,
                                offset: Offset(2.0, 2.0),),),textAlign: TextAlign.center,),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: displayHeight(context)*0.02),
                              child: Container(
                                height: displayHeight(context)*0.1,
                                width: displayWidth(context)*0.4,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(image: AssetImage(ImageConstants.coinIcon))
                                ),
                              ),
                            ),

                          ],
                        ),
                        Align(
                          alignment: const Alignment(0, 0.5),
                          child: GestureDetector(
                              onTap: () async{
                                settingController.vibration.value ==
                                    true ? Vibration.vibrate(duration: 100, amplitude: 128) :Vibration.vibrate(duration: 0, amplitude: 0);
                                celebHomeController.animationController.forward();
                                Future.delayed(const Duration(milliseconds: 200), () {
                                  celebHomeController.animationController.reverse();
                                });

                                /// show Google ad
                                if (celebHomeController.isGetCoinAdReady.value) {
                                  celebHomeController.getCoinAd!.show(
                                    onUserEarnedReward: (ad, RewardItem reward) async{
                                      updateData();
                                    },
                                  );
                                }else{
                                  adMobServices.showInterstitialAd(onAdDismissedFullScreenContent: (ad) {
                                    ad.dispose();
                                    adMobServices.createInterstitialAd();
                                  },);
                                  updateData();
                                }

                                /// show facebook ad
                                // if(facebookAdController.isRewardedAdLoaded && !adMob.value && faceBookAd.value){
                                //   facebookAdController.showFacebookRewardedAd();
                                //   Future.delayed(const Duration(seconds: 13),() async {
                                //     updateData();
                                //   },
                                //   );
                                // } else if(!facebookAdController.isRewardedAdLoaded && facebookAdController.isInterstitialAdLoaded && !adMob.value && faceBookAd.value){
                                //   facebookAdController.showFacebookInterstitialAd();
                                //   Future.delayed(const Duration(seconds: 13),() async {
                                //     updateData();
                                //   },);
                                // }
                                //
                                // /// show unity ad
                                // if(!adMob.value && !faceBookAd.value){
                                //   await UnityAdController().showUnityRewardedAd(onComplete: (placementId) async {
                                //     await UnityAdController().loadUnityRewardedAd();
                                //     updateData();
                                //   },);
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
                              child: ScaleTransition(
                                  scale: Tween<double>(
                                    begin: 1.0,
                                    end: 0.7,
                                  ).animate(celebHomeController.animationController),
                                  child: Image.asset(ImageConstants.watchAdButton,height: displayHeight(context)*0.08,))),
                        ),

                        Align(
                          alignment: const Alignment(0,1.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: displayHeight(context) * 0.08,
                              width: displayWidth(context) * 0.35,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(image: AssetImage(ImageConstants.backButton),fit: BoxFit.fill)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),);
  }
}