import 'dart:developer';

import 'package:celebrity_quiz/Infrastructure/Base/AdHelper/facebook_adManager.dart';
import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class HintDialog {
  GamePlayController gamePlayController = Get.put(GamePlayController());
  AdMobServices adMobServices = Get.put(AdMobServices());
  // FacebookAdController facebookAdController = Get.put(FacebookAdController());
  SettingController settingController = Get.put(SettingController());

  void hintDialog(
      {context}) {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          alignment: const Alignment(0.7,0.2),
          child: GetBuilder<GamePlayController>(
              init: GamePlayController(),
              builder: (controller) {
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
                        data: MediaQuery.of(context).copyWith(textScaleFactor: displayHeight(context) > 550 && displayHeight(context) < 1000? 1.0 :0.8),
                        child: Container(
                          height: displayHeight(context) > 550 && displayHeight(context) < 750 ? displayHeight(context) *0.6: displayHeight(context) * 0.53,
                          width: displayWidth(context) * 0.8,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(gamePlayController.showFirstHint.value  && gamePlayController.showSecondHint.value ? ImageConstants.outOfHintBAse:ImageConstants.hintPopUpBase)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: displayHeight(context) < 550 ? displayHeight(context)*0.09:displayHeight(context)*0.12),
                                child: !gamePlayController.showFirstHint.value  ? Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: displayWidth(context)*0.02),
                                      child: Text(AppConstants.adForHint.tr,style: TextStyleConstant.textBold26(
                                        color: ColorConstants.purpleColor.withOpacity(0.5),
                                        shadow: const Shadow(
                                            blurRadius: 30.0,
                                            color: Colors.grey,
                                            offset: Offset(2.0, 2.0),
                                        ),
                                      ),
                                        textAlign: TextAlign.center,),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: displayHeight(context)*0.05),
                                      child: Image(image: const AssetImage(ImageConstants.watchVideoIcon),height: displayHeight(context)*0.1),
                                    ),
                                  ],
                                ) : gamePlayController.showFirstHint.value  && !gamePlayController.showSecondHint.value? Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: displayWidth(context)*0.05),
                                      child: Text("${AppConstants.hint1.tr}${gamePlayController.hintText[0]}",style: TextStyleConstant.textBold20(
                                        color: ColorConstants.purpleColor,
                                        shadow: const Shadow(
                                              blurRadius: 40.0,
                                              color: Colors.grey,
                                              offset: Offset(2.0, 2.0),),),textAlign: TextAlign.center),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: displayWidth(context)*0.02,vertical: displayHeight(context)*0.04),
                                      child: Text(AppConstants.showMoreHint.tr,style: TextStyleConstant.textBold26(
                                        color: ColorConstants.purpleColor.withOpacity(0.5),
                                        shadow: const Shadow(
                                            blurRadius: 40.0,
                                            color: Colors.grey,
                                            offset: Offset(2.0, 2.0),
                                      ),
                                      ),
                                          textAlign: TextAlign.center),
                                    ),

                                  ],
                                ) : Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: displayWidth(context)*0.05),
                                      child: Text("${AppConstants.hint1.tr}${gamePlayController.hintText[0]}",style: TextStyleConstant.textBold18(color: ColorConstants.purpleColor.withOpacity(0.8),shadow: const Shadow(
                                        blurRadius: 40.0,
                                        color: Colors.grey,
                                        offset: Offset(2.0, 2.0),),),textAlign: TextAlign.center,maxLines: 1,),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: displayWidth(context)*0.05,left: displayWidth(context)*0.05,bottom: displayHeight(context)*0.01),
                                      child: Text("${AppConstants.hint2.tr}${gamePlayController.hintText[1]}",style: TextStyleConstant.textBold18(color: ColorConstants.purpleColor.withOpacity(0.8),shadow: const Shadow(
                                        blurRadius: 40.0,
                                        color: Colors.grey,
                                        offset: Offset(2.0, 2.0),),),textAlign: TextAlign.center,maxLines: 2,),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: displayWidth(context)*0.05,left: displayWidth(context)*0.05,top: displayHeight(context)*0.01,bottom: displayHeight(context)*0.01),
                                      child: Text(AppConstants.outHint.tr,style: TextStyleConstant.textBold20(color: ColorConstants.purpleColor.withOpacity(0.8),shadow: const Shadow(
                                        blurRadius: 40.0,
                                        color: Colors.grey,
                                        offset: Offset(2.0, 2.0),),),textAlign: TextAlign.center),
                                    ),
                                    Image(image: const AssetImage(ImageConstants.sadSmily),height: displayHeight(context)*0.1,width: displayWidth(context)*0.5,),
                                    SizedBox(height: displayHeight(context)*0.01,)
                                  ],
                                ),
                              ),
                              !gamePlayController.showFirstHint.value || !gamePlayController.showSecondHint.value ?
                              Positioned(
                                bottom: displayHeight(context)*0.11,
                                child: GestureDetector(
                                  onTap: () async {
                                    settingController.vibration.value ==
                                        true ? Vibration.vibrate(duration: 100, amplitude: 128) :Vibration.vibrate(duration: 0, amplitude: 0);
                                    gamePlayController.animationController.forward();
                                    Future.delayed(const Duration(milliseconds: 200), () {
                                      gamePlayController.animationController.reverse();
                                    });
                                    if (gamePlayController.isRewardedAdReady.value) {
                                      gamePlayController.hintShowAd!.show(
                                          onUserEarnedReward:
                                              (AdWithoutView ad, RewardItem reward) async{
                                            onAdComplete(context: context,isReawardAdMob: true);
                                          }

                                      );
                                    }else{
                                      adMobServices.showInterstitialAd(onAdDismissedFullScreenContent: (ad) {
                                        onAdComplete(context: context,isReawardAdMob: false);

                                        ad.dispose();
                                        adMobServices.createInterstitialAd();
                                      });
                                    }

                                    // ////////// facebook Ad ///////////
                                    // if(facebookAdController.isRewardedAdLoaded && !adMob.value && faceBookAd.value){
                                    //   facebookAdController.showFacebookRewardedAd();
                                    //   Future.delayed(const Duration(seconds: 15),() {
                                    //     onAdComplete(context: context,isReawardAdMob: false);
                                    //   },);
                                    // }else if(!facebookAdController.isRewardedAdLoaded && facebookAdController.isInterstitialAdLoaded && !adMob.value && faceBookAd.value){
                                    //   facebookAdController.showFacebookInterstitialAd();
                                    //   Future.delayed(const Duration(seconds: 10),() async {
                                    //     onAdComplete(context: context,isReawardAdMob: false);
                                    //   },);
                                    // }
                                    //
                                    //
                                    // ////////// Unity Ad //////////
                                    // if(!adMob.value && !faceBookAd.value) {
                                    //   await UnityAdController().showUnityRewardedAd(onComplete: (placementId) async {
                                    //     await UnityAdController().loadUnityRewardedAd();
                                    //     onAdComplete(context: context,isReawardAdMob: false);
                                    //   },);
                                    // }


                                  },
                                  child: ScaleTransition(
                                    scale: Tween<double>(
                                      begin: 1.0,
                                      end: 0.7,
                                    ).animate(gamePlayController.animationController),
                                    child: Container(
                                      height: displayHeight(context) * 0.1,
                                      width: displayWidth(context) * 0.45,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(image: AssetImage(ImageConstants.watchAdButton),fit: BoxFit.fill)),
                                    ),
                                  ),
                                ),
                              ) : const SizedBox(),
                              Positioned(
                                bottom: displayHeight(context)*0.025,
                                child: GestureDetector(
                                  onTap: () {
                                    gamePlayController.startPlayingTimer(context);
                                    gamePlayController.timerContainerWidth.value = displayWidth(context) * (gamePlayController.remainTime.value * 0.016);
                                    Get.back();
                                  },
                                  child: Container(
                                    height: displayHeight(context) * 0.09,
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
                );
              }
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),);

  }
  onAdComplete({required context,required bool isReawardAdMob})async{
    gamePlayController.hintAdShow = gamePlayController.hintAdShow + 1;

    // await gamePlayController.fireStore
    //     .collection(FirebaseConstant.userKey)
    //     .doc(userDeviceID)
    //     .update({
    //   FirebaseConstant.hintAd: gamePlayController.hindAdShow.toString(),
    // });
    await SharedPref().addStringToSF(StorageConstants.hintAdShow,gamePlayController.hintAdShow.toString());
    if(!isReawardAdMob){
      if (gamePlayController.showFirstHint.value) {
        gamePlayController.showSecondHint.value = true;
        gamePlayController.showHint.value = true;
        if(gamePlayController.showHint.value){
          Future.delayed(const Duration(seconds: 5),() {
            gamePlayController.showHint.value = false;
          },);
        }
      } else {
        gamePlayController.showFirstHint.value = true;
        gamePlayController.showHint.value = true;
        if(gamePlayController.showHint.value){
          Future.delayed(const Duration(seconds: 5),() {
            gamePlayController.showHint.value = false;
          },);
        }
      }
      gamePlayController.startPlayingTimer(context);
      gamePlayController.timerContainerWidth.value = displayWidth(context) * (gamePlayController.remainTime.value * 0.016);
    }

    gamePlayController.update();

    Get.back();
  }
}