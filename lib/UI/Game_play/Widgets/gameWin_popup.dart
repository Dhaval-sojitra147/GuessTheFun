import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';
import 'package:celebrity_quiz/Infrastructure/Base/AdHelper/facebook_adManager.dart';
import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class WinDialog {
  GamePlayController gamePlayController = Get.put(GamePlayController());
  SettingController settingController = Get.put(SettingController());
  AdMobServices adMobServices = Get.put(AdMobServices());
  // FacebookAdController facebookAdController = Get.put(FacebookAdController());


  void winDialog(
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
              child: WillPopScope(
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
                      data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: displayHeight(context) > 550 && displayHeight(context) < 750 ? displayHeight(context) *0.57 : displayHeight(context) * 0.53,
                            width: displayWidth(context) * 0.8,
                            decoration: BoxDecoration(
                              image: const DecorationImage(image: AssetImage(ImageConstants.winPopUpBase)),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: displayHeight(context) <550 ? displayHeight(context)*0.08:displayHeight(context)*0.1),
                              child: Column(
                                children: [
                                  Text("${AppConstants.levels.tr} ${int.parse(gamePlayController.subLevelIndex)+1}",style: TextStyleConstant.textBold28(
                                    color: ColorConstants.purpleColor.withOpacity(0.8),
                                    shadow: const Shadow(
                                        blurRadius: 40.0,
                                        color: Colors.grey,
                                        offset: Offset(2.0, 2.0),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: displayHeight(context) < 1000 ? EdgeInsets.only(top: displayHeight(context)*0.02,bottom: displayHeight(context)*0.01) : EdgeInsets.only(top: 0),
                                    child: Container(
                                      height: displayHeight(context)*0.11,
                                      width: displayWidth(context)*0.5,
                                      decoration: BoxDecoration(
                                          color: ColorConstants.purpleColor,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.grey.withOpacity(0.7),
                                              width: 5
                                          )
                                      ),
                                      child: Center(child: Image.asset(gamePlayController.starImage().value)),
                                    ),
                                  ),
                                  Text(AppConstants.winLine.tr,style: TextStyleConstant.textBold24(color: ColorConstants.purpleColor.withOpacity(0.5),
                                    shadow: const Shadow(
                                    blurRadius: 40.0,
                                    color: Colors.grey,
                                    offset: Offset(2.0, 2.0),
                                  ),),),
                                  SizedBox(height: displayHeight(context)*0.02,),
                                  Container(
                                    height: displayHeight(context)*0.06,
                                    width: displayWidth(context)*0.25,
                                    decoration: BoxDecoration(
                                        color: ColorConstants.offWhiteColor,
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: Image(image: AssetImage(ImageConstants.coinIcon),),
                                        ),
                                        Text(gamePlayController.remainTime.value > 13 ? "30" : gamePlayController.remainTime.value > 6 ? "20" : "10" ,style: TextStyleConstant.textBold24(
                                          shadow: Shadow(
                                              blurRadius: 10.0,
                                              color: Colors.grey.withOpacity(0.5),
                                              offset: Offset(2.0, 2.0),
                                        ),),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: displayHeight(context)*0.016,),

                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: GestureDetector(
                                onTap: () async {
                                  settingController.vibration.value ==
                                      true ? Vibration.vibrate(duration: 100, amplitude: 128) :Vibration.vibrate(duration: 0, amplitude: 0);
                                  gamePlayController.animationController.forward();
                                  Future.delayed(const Duration(milliseconds: 200), () {
                                    gamePlayController.animationController.reverse();
                                  });
                                  if((int.parse(gamePlayController.subLevelIndex) > 5 && int.parse(gamePlayController.subLevelIndex) == gamePlayController.randomNumber.value)){
                                    adMobServices.showInterstitialAd(
                                        onAdDismissedFullScreenContent: (ad) async {
                                          int randomNumber = Random().nextInt(5) + int.parse(gamePlayController.subLevelIndex);
                                          gamePlayController.randomNumber.value = randomNumber;
                                          // dev.log("this one is random number log==> ${gamePlayController.randomNumber.value}");
                                          onAdComplete(context: context,isSkip: false);
                                          // gamePlayController.startPlayingTimer(context);
                                          ad.dispose();
                                          adMobServices.createInterstitialAd();
                                        });
                                  }else{
                                    onAdComplete(context: context,isSkip: false);
                                    gamePlayController.startPlayingTimer(context);
                                  }

                                },
                                child: ScaleTransition(
                                    scale: Tween<double>(
                                      begin: 1.0,
                                      end: 0.7,
                                    ).animate(gamePlayController.animationController),
                                    child: Image.asset(ImageConstants.nextLevelButton,height: displayHeight(context)*0.11,))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
    );
  }

  onAdComplete({required context,required bool isSkip}) async {
    if (gamePlayController.levelIds.length % 100 == 0) {
      Get.back();
      Get.offNamed(
          RoutesConstants.levelScreen,
          arguments: [
            {"levelName": gamePlayController.levelName},
            {"levelIndex": gamePlayController.levelIndex.value},
            {"levelTotalLength": gamePlayController.levelLength.value},
          ]);
    } else {
      Future.delayed(const Duration(milliseconds: 500), () async {
        int levelIndex = int.parse(gamePlayController.subLevelIndex) + 1;

        /// this condition use for continue playing after every 20 level this condition using for get next json data
        if(gamePlayController.levelIds.length % 20 == 0){
          Map<String, dynamic> celebJsonData = {};
          var jsonText =  await rootBundle.loadString("assets/json/${gamePlayController.levelName.toLowerCase()}.json");
          celebJsonData = json.decode(jsonText);
          List<dynamic> celebData = celebJsonData[gamePlayController.levelIds.length == 20 ? "${gamePlayController.levelName.toLowerCase()}Two" : gamePlayController.levelIds.length == 40 ?"${gamePlayController.levelName.toLowerCase()}Three" :gamePlayController.levelIds.length == 60 ?"${gamePlayController.levelName.toLowerCase()}Four" :gamePlayController.levelIds.length == 80 ?"${gamePlayController.levelName.toLowerCase()}Five":""];
          celebData.shuffle();
          gamePlayController.celebData.addAll(celebData);
          dev.log("this one is player winning dataId =====> ${gamePlayController.celebData.length}");
        }
        var data = gamePlayController.celebData[levelIndex];
        gamePlayController.levelId = data[FirebaseConstant.id];
        if (!gamePlayController.levelIds.contains(gamePlayController.levelId)) {
          gamePlayController.levelIds.add(gamePlayController.levelId);
          dev.log("this one is player winning dataId =====> ${gamePlayController.levelIds}");
        }
        SharedPref().setBoolToSF(StorageConstants.userEnter, false);

        gamePlayController.celebImage = data[FirebaseConstant.imageUrl];
        gamePlayController.eyeOpenGrid.value = data[FirebaseConstant.eyeOpenGrid];
        gamePlayController.gridCutPointShow.value = [];
        gamePlayController.options.value = data[FirebaseConstant.options];
        gamePlayController.hintText = data[FirebaseConstant.hint];
        gamePlayController.celebName =data[FirebaseConstant.photoName];
        gamePlayController.levelName = gamePlayController.levelName;
        gamePlayController.levelIndex.value = gamePlayController.levelIndex.value;
        gamePlayController.subLevelIndex = (levelIndex).toString();
        gamePlayController.timerContainerWidth =
        displayHeight(context) > 1000 ? (displayWidth(context) * 0.34).obs : (displayWidth(context) * 0.32).obs;
        gamePlayController.remainTime = 20.obs;
        // gamePlayController.options.shuffle();
        // gamePlayController.options.removeRange(3, 6);
        gamePlayController.options.add(gamePlayController.celebName);
        gamePlayController.options.shuffle();
        gamePlayController.optionOne.value = false;
        gamePlayController.optionTwo.value = false;
        gamePlayController.optionThree.value = false;
        gamePlayController.optionFour.value = false;
        gamePlayController.showFirstHint = false.obs;
        gamePlayController.showSecondHint = false.obs;
        gamePlayController.update();
        !isSkip ? Get.back() : null;

        // Get.back();
        // Get.back();
      },);
    }

  }
}