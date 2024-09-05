import 'package:celebrity_quiz/Infrastructure/Base/AdHelper/facebook_adManager.dart';
import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class TimeOutDialog {
  GamePlayController gamePlayController = Get.put(GamePlayController());
  AdMobServices adMobServices = Get.put(AdMobServices());
  // FacebookAdController facebookAdController = Get.put(FacebookAdController());
  // UnityAdController unityAdManager = Get.put(UnityAdController());
  SettingController settingController = Get.put(SettingController());


  void timeOutDialog({context, required String levelName, required int levelIndex,}) {

    onAdComplete()async{
      gamePlayController.timeOutAdShow  = gamePlayController.timeOutAdShow+1;
      // await gamePlayController.fireStore
      //     .collection(FirebaseConstant.userKey)
      //     .doc(userDeviceID)
      //     .update({
      //   FirebaseConstant.timeOutAd:gamePlayController.timeOutAdShow.toString()
      // });
     await SharedPref().addStringToSF(StorageConstants.timeOutAdShow, gamePlayController.timeOutAdShow.toString());
      gamePlayController.remainTime.value = 20;
      // gamePlayController.startPlayingTimer(context);

      Get.back();
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
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
                data: MediaQuery.of(context).copyWith(textScaleFactor: 0.87),
                child: Container(
                  height: displayHeight(context) > 550 && displayHeight(context) < 750 ? displayHeight(context) *0.56 :displayHeight(context) * 0.53,
                  width: displayWidth(context) * 0.8,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage(ImageConstants.timeOutPopUPBase)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: displayHeight(context) * 0.12),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: displayWidth(context) * 0.1),
                          child: Column(
                            children: [
                              Text(AppConstants.outOfTime.tr,
                                  style: TextStyleConstant.textBold28(
                                      color: ColorConstants.purpleColor
                                          .withOpacity(0.7),
                                    shadow: const Shadow(
                                        blurRadius: 40.0,
                                        color: Colors.grey,
                                        offset: Offset(2.0, 2.0),
                                  ),),
                                  textAlign: TextAlign.center),
                              SizedBox(height: displayHeight(context)*0.02,),
                              Text(AppConstants.watchAdForTime.tr,
                                  style: TextStyleConstant.textBold24(
                                      color: ColorConstants.purpleColor
                                          .withOpacity(0.7),
                                    shadow: const Shadow(
                                        blurRadius: 40.0,
                                        color: Colors.grey,
                                        offset: Offset(2.0, 2.0),
                                  ),),
                                  textAlign: TextAlign.center),
                              SizedBox(height: displayHeight(context)*0.02,),
                              Image(
                                  image:
                                      const AssetImage(ImageConstants.watchVideoIcon),
                                  height: displayHeight(context) * 0.07),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: displayHeight(context) *0.12,
                          child: GestureDetector(
                              onTap: () async {
                                gamePlayController.animationController.forward();
                                Future.delayed(const Duration(milliseconds: 200), () {
                                  gamePlayController.animationController.reverse();
                                });

                                Future.delayed(const Duration(seconds: 1),() async{
                                  if (gamePlayController.isTimeAdReady.value) {
                                    gamePlayController.timeOutAd!.show(
                                        onUserEarnedReward:
                                            (ad, RewardItem reward) async {
                                          onAdComplete();
                                        });
                                  }else{
                                    adMobServices.showInterstitialAd(onAdDismissedFullScreenContent: (ad) {
                                      onAdComplete();
                                      ad.dispose();
                                      adMobServices.createInterstitialAd();
                                    });
                                  }

                                  ////////// facebook Ad ///////////
                                  // if(facebookAdController.isRewardedAdLoaded && !adMob.value && faceBookAd.value){
                                  //   facebookAdController.showFacebookRewardedAd();
                                  //   Future.delayed(const Duration(seconds: 15),() {
                                  //     onAdComplete(isReawardAdMob: false);
                                  //
                                  //     gamePlayController.showTimeOutAd.value = true;
                                  //   },);
                                  // }else if(!facebookAdController.isRewardedAdLoaded && facebookAdController.isInterstitialAdLoaded && !adMob.value && faceBookAd.value){
                                  //   facebookAdController.showFacebookInterstitialAd();
                                  //   Future.delayed(const Duration(seconds: 10),() async {
                                  //     onAdComplete(isReawardAdMob: false);
                                  //
                                  //     gamePlayController.showTimeOutAd.value = true;
                                  //   },);
                                  // }
                                  //
                                  //
                                  // ////////// Unity Ad //////////
                                  // if(!adMob.value && !faceBookAd.value) {
                                  //   await UnityAdController().showUnityRewardedAd(onComplete: (placementId) async {
                                  //     await UnityAdController().loadUnityRewardedAd();
                                  //     onAdComplete(isReawardAdMob: false);
                                  //     gamePlayController.showTimeOutAd.value = true;
                                  //   },);
                                  // }

                                },);
                              },
                              child: ScaleTransition(
                                scale: Tween<double>(
                                  begin: 1.0,
                                  end: 0.7,
                                ).animate(gamePlayController.animationController),
                                child: Image(
                                    image: const AssetImage(
                                        ImageConstants.watchAdButton),
                                    height: displayHeight(context) * 0.08),
                              )),
                        ),
                        Positioned(
                          bottom: 0,
                          child: GestureDetector(
                              onTap: () async {
                                Future.delayed(const Duration(seconds: 1),() async{
                                  if (gamePlayController.isTimeAdReady.value) {
                                    gamePlayController.timeOutAd!.show(
                                        onUserEarnedReward:
                                            (ad, RewardItem reward) async {
                                          onAdComplete();
                                        });
                                  }else{
                                    adMobServices.showInterstitialAd(onAdDismissedFullScreenContent: (ad) {
                                      onAdComplete();
                                      ad.dispose();
                                      adMobServices.createInterstitialAd();
                                    });
                                  }

                                  ////////// facebook Ad ///////////
                                  // if(facebookAdController.isRewardedAdLoaded && !adMob.value && faceBookAd.value){
                                  //   facebookAdController.showFacebookRewardedAd();
                                  //   Future.delayed(const Duration(seconds: 15),() {
                                  //     onAdComplete(isReawardAdMob: false);
                                  //
                                  //     gamePlayController.showTimeOutAd.value = true;
                                  //   },);
                                  // }else if(!facebookAdController.isRewardedAdLoaded && facebookAdController.isInterstitialAdLoaded && !adMob.value && faceBookAd.value){
                                  //   facebookAdController.showFacebookInterstitialAd();
                                  //   Future.delayed(const Duration(seconds: 10),() async {
                                  //     onAdComplete(isReawardAdMob: false);
                                  //
                                  //     gamePlayController.showTimeOutAd.value = true;
                                  //   },);
                                  // }
                                  //
                                  //
                                  // ////////// Unity Ad //////////
                                  // if(!adMob.value && !faceBookAd.value) {
                                  //   await UnityAdController().showUnityRewardedAd(onComplete: (placementId) async {
                                  //     await UnityAdController().loadUnityRewardedAd();
                                  //     onAdComplete(isReawardAdMob: false);
                                  //     gamePlayController.showTimeOutAd.value = true;
                                  //   },);
                                  // }

                                },);
                              },
                              child: Image.asset(
                                ImageConstants.retryButton,
                                height: displayHeight(context) * 0.11,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
