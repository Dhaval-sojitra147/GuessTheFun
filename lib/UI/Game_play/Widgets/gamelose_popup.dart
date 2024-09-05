import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';
import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class LoseDialog {
  GamePlayController gamePlayController = Get.put(GamePlayController());
  AdMobServices adMobServices = Get.put(AdMobServices());
  // FacebookAdController facebookAdController = Get.put(FacebookAdController());
  SettingController settingController = Get.put(SettingController());
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  void loseDialog(
      {context}) {
    onAdComplete() async {
      // fireStore
      //     .collection(FirebaseConstant.userKey)
      //     .doc(userDeviceID)
      //     .update(gamePlayController.updateLevelDetail(isLoss: true));

      gamePlayController.updateLocalLevelDetail(isLoss: true);

      if(!gamePlayController.isBonusLevel.value){
        fireStore
            .collection(FirebaseConstant.userKey)
            .doc(userDeviceID)
            .collection(gamePlayController.levelName.toLowerCase())
            .doc(gamePlayController.levelId)
            .set(gamePlayController.completedLevelData(isLoss: true));

        var winLocal = await SharedPref().getStringValuesSF(gamePlayController.levelName.toLowerCase());
        var winData = jsonDecode(winLocal);
        winData.add(gamePlayController.completedLevelData(isLoss: true));
        await SharedPref().addStringToSF(gamePlayController.levelName.toLowerCase(), jsonEncode(winData));
      }
      if(gamePlayController.randomNumber.value == int.parse(gamePlayController.subLevelIndex)){
        int randomNumber = Random().nextInt(5) + int.parse(gamePlayController.subLevelIndex);
        gamePlayController.randomNumber.value = randomNumber;

      }
      Get.back();
      for (int i = 0; i <= 99; i++) {
        gamePlayController.eyeOpenGrid.add(i.toString());
        gamePlayController.gridCutPointShow.add(i.toString());
      }
      if(gamePlayController.options[0] == gamePlayController.celebName){
        gamePlayController.optionOne.value = true;
      }else if(gamePlayController.options[1] == gamePlayController.celebName){
        gamePlayController.optionTwo.value = true;
      }else if(gamePlayController.options[2] == gamePlayController.celebName){
        gamePlayController.optionThree.value = true;
      }else{
        gamePlayController.optionFour.value = true;
      }

      Future.delayed(const Duration(seconds: 5),() => WinDialog().onAdComplete(context: context,isSkip: true));
      // Get.back();
      // Future.delayed(
      //   const Duration(milliseconds: 500),
      //       () {
      //         Get.offNamed(RoutesConstants.levelScreen,arguments: [
      //           {
      //             "levelName": gamePlayController.levelName
      //           },
      //           {"levelIndex": gamePlayController.levelIndex.value},
      //           {"levelTotalLength": gamePlayController.levelLength.value},
      //         ]);
      //     // Get.back();
      //     // Get.back();
      //   },
      // );
    }


    onRetryComplete()async{
      gamePlayController.loseAdShow  = gamePlayController.loseAdShow+1;
      // fireStore
      //     .collection(FirebaseConstant.userKey)
      //     .doc(userDeviceID)
      //     .update({FirebaseConstant.lossAd:gamePlayController.loseAdShow.toString()});
      await SharedPref().addStringToSF(StorageConstants.loseAdShow, gamePlayController.loseAdShow.toString());
      // gamePlayController.eyeOpenGrid.value = ["32","33","34","35","36","37"];
      // gamePlayController.gridCutPointShow.value = [];
      gamePlayController.remainTime.value = 20;

      // gamePlayController.startPlayingTimer(context);
      Get.back();
    }


    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: WillPopScope(
            onWillPop:() async{
              // Get.offNamed(RoutesConstants.levelScreen,arguments: [
              //   {
              //     "levelName": gamePlayController.levelName
              //   },
              //   {"levelIndex": gamePlayController.levelIndex.value},
              // ]);
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
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: displayHeight(context) > 550 && displayHeight(context) < 750 ? displayHeight(context) *0.57: displayHeight(context) * 0.51,
                        width: displayWidth(context) * 0.85,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage(ImageConstants.losePopUpBase)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: displayHeight(context) > 1000 ? displayHeight(context) * 0.15 :  displayHeight(context) * 0.1,left: displayWidth(context)*0.08,right: displayWidth(context)*0.1),
                          child: Column(
                            children: [
                             SizedBox(height: displayHeight(context)*0.01,),
                              Text("${AppConstants.levels.tr} ${int.parse(gamePlayController.subLevelIndex)+1}",style: TextStyleConstant.textBold28(color: ColorConstants.purpleColor),),
                              SizedBox(height: displayHeight(context)*0.01,),
                              Text(AppConstants.guessWrong.tr,
                                  style: TextStyleConstant.textBold26(
                                      color: ColorConstants.purpleColor
                                          .withOpacity(0.8),
                                    shadow: const Shadow(
                                    blurRadius: 40.0,
                                    color: Colors.grey,
                                    offset: Offset(2.0, 2.0),),
                                  ),
                                  textAlign: TextAlign.center),
                              SizedBox(height: displayHeight(context)*0.01,),
                              Image(image: const AssetImage(ImageConstants.watchVideoIcon), height: displayHeight(context) * 0.04),
                              SizedBox(height: displayHeight(context)*0.01,),

                              Text(AppConstants.watchAd.tr,
                                  style: TextStyleConstant.textBold24(
                                      color: ColorConstants.purpleColor
                                          .withOpacity(0.7),
                                    shadow: const Shadow(
                                    blurRadius: 40.0,
                                    color: Colors.grey,
                                    offset: Offset(2.0, 2.0),),
                                  ),
                                  textAlign: TextAlign.center),


                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: displayHeight(context) * 0.11 ,
                        child: GestureDetector(
                            onTap: () async {
                              settingController.vibration.value ==
                                  true ?Vibration.vibrate(duration: 100, amplitude: 128) :null;
                              gamePlayController.animationController.forward();
                              Future.delayed(const Duration(milliseconds: 200), () {
                                gamePlayController.animationController.reverse();
                              });
                              Future.delayed(const Duration(seconds: 1),()
                              async {
                                if (gamePlayController.isLossAdReady.value) {
                                  gamePlayController.lossAd!.show(
                                      onUserEarnedReward:
                                          (ad, RewardItem reward) async {
                                        onAdComplete();
                                      });
                                } else{
                                  adMobServices.showInterstitialAd(
                                      onAdDismissedFullScreenContent: (ad) {
                                        onAdComplete();
                                        ad.dispose();
                                        adMobServices.createInterstitialAd();
                                      });
                                }

                                // ////////// facebook Ad ///////////
                                // if(facebookAdController.isRewardedAdLoaded && !adMob.value && faceBookAd.value){
                                //   facebookAdController.showFacebookRewardedAd();
                                //   Future.delayed(const Duration(seconds: 15),() {
                                //     onAdComplete();
                                //   },);
                                // }else if(!facebookAdController.isRewardedAdLoaded && facebookAdController.isInterstitialAdLoaded && !adMob.value && faceBookAd.value){
                                //   facebookAdController.showFacebookInterstitialAd();
                                //   Future.delayed(const Duration(seconds: 10),() async {
                                //     onAdComplete();
                                //   },);
                                // }
                                //
                                //
                                // ////////// Unity Ad //////////
                                // if(!adMob.value && !faceBookAd.value) {
                                //   await UnityAdController().showUnityRewardedAd(onComplete: (placementId) async {
                                //     await UnityAdController().loadUnityRewardedAd();
                                //     onAdComplete();
                                //   },);
                                // }
                              });

                            },
                            child: ScaleTransition(
                              scale: Tween<double>(
                                begin: 1.0,
                                end: 0.7,
                              ).animate(gamePlayController.animationController),
                              child: Image(
                                  image: const AssetImage(
                                      ImageConstants.skipLevelButton),
                                  height: displayHeight(context) * 0.08),
                            )),
                      ),
                      Positioned(
                        bottom: 0,
                        child: GestureDetector(
                            onTap: () {
                              settingController.vibration.value ==
                                  true ? Vibration.vibrate(duration: 100, amplitude: 128) :Vibration.vibrate(duration: 0, amplitude: 0);
                              Future.delayed(const Duration(seconds: 1),()
                              async {
                                gamePlayController.optionOne.value = false;
                                gamePlayController.optionTwo.value = false;
                                gamePlayController.optionThree.value = false;
                                gamePlayController.optionFour.value = false;
                                if (gamePlayController.isLossAdReady.value) {
                                  gamePlayController.lossAd!.show(
                                      onUserEarnedReward:
                                          (ad, RewardItem reward) async {
                                        onRetryComplete();
                                      });
                                } else {
                                  adMobServices.showInterstitialAd(
                                      onAdDismissedFullScreenContent: (ad) {
                                        onRetryComplete();

                                        ad.dispose();
                                        adMobServices.createInterstitialAd();
                                      });
                                }

                                ////////// facebook Ad ///////////
                                // if(facebookAdController.isRewardedAdLoaded && !adMob.value && faceBookAd.value){
                                //   facebookAdController.showFacebookRewardedAd();
                                //   Future.delayed(const Duration(seconds: 15),() {
                                //     onRetryComplete(isReawardAdMob: false);
                                //   },);
                                // }else if(!facebookAdController.isRewardedAdLoaded && facebookAdController.isInterstitialAdLoaded && !adMob.value && faceBookAd.value){
                                //   facebookAdController.showFacebookInterstitialAd();
                                //   Future.delayed(const Duration(seconds: 10),() async {
                                //     onRetryComplete(isReawardAdMob: false);
                                //   },);
                                // }
                                //
                                //
                                // ////////// Unity Ad //////////
                                // if(!adMob.value && !faceBookAd.value) {
                                //   await UnityAdController().showUnityRewardedAd(
                                //     onComplete: (placementId) async {
                                //       await UnityAdController().loadUnityRewardedAd();
                                //       onRetryComplete(isReawardAdMob: false);
                                //     },);
                                // }

                              });
                              // Get.back();
                              // Get.offNamed(RoutesConstants.mainLevelScreen);
                            },
                            child: Image.asset(
                              ImageConstants.retryButton,
                              height: displayHeight(context) * 0.11,
                            )),
                      )

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),);

  }
}
