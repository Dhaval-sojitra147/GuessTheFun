import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';
import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class GamePlayController extends GetxController with GetSingleTickerProviderStateMixin{
  BuildContext? contexts;

  GamePlayController({this.contexts});
  dynamic argumentData = Get.arguments;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  NetworkController networkController = Get.put(NetworkController());
  SettingController settingController = Get.put(SettingController());
  late AnimationController animationController;
  var bonusLevel;
  // AnimationController? openGridAnimationController ;
  // AnimationController? closeGridAnimationController;


  Timer? timer;
  RxInt userScore = 0.obs;
  RxList<dynamic> eyeOpenGrid = [].obs;
  String celebImage = "";
  RxList<dynamic> options = [].obs;
  String celebName = "";
  String levelId = "";
  String subLevelIndex = "";
  String levelName = "";
  RxInt levelIndex = 0.obs;
  RxList levelIds = [].obs;
  String gameQue = "";
  List<dynamic> hintText = [];
  RxBool optionOne = false.obs;
  RxBool optionTwo = false.obs;
  RxBool optionThree = false.obs;
  RxBool optionFour = false.obs;

  RxBool showFirstHint = false.obs;
  RxBool showSecondHint = false.obs;
  RxBool showHint = false.obs;
  String zero = "0";
  RxList celebData = [].obs;
  RxInt bonusCount = 0.obs;
  RxBool showGridSuggestion = false.obs;
  RxBool showHintSuggestion = false.obs;
  RxDouble animationTurns = 0.0.obs;
  RxInt randomNumber = 0.obs;

  // /******** eye Open Grid******** //

  RxList<dynamic> gridCutPointShow = [].obs;

  // /******** Timer ******** //

  RxDouble timerContainerWidth = 0.0.obs;
  RxInt remainTime = 20.obs;
  RxInt gameCoin = 0.obs;
  RxInt adCoin = 0.obs;
  RxInt winCoin = 0.obs;
  RxInt goldStar = 0.obs;
  RxInt hintAdShow = 0.obs;
  RxInt timeOutAdShow = 0.obs;
  RxInt loseAdShow = 0.obs;
  RxInt purchaseCoin = 0.obs;
  RxInt levelLength = 0.obs;
  RxBool isBonusLevel = false.obs;
  // RxBool showTimeOutAd = false.obs;

  // /******** Google Ad /******** //

  // Reward Ad
  RewardedInterstitialAd? rewardedInterstitialAd;
  RewardedInterstitialAd? hintShowAd;
  RewardedInterstitialAd? winRewardAd;
  RewardedInterstitialAd? timeOutAd;
  RewardedInterstitialAd? lossAd;
  RewardedInterstitialAd? skipLevelAd;
  RxBool isRewardedAdReady = false.obs;
  RxBool isWinRewardedAdReady = false.obs;
  RxBool isTimeAdReady = false.obs;
  RxBool isLossAdReady = false.obs;
  RxBool isSkipLevelAdReady = false.obs;

  // Interstitial Ad
  InterstitialAd? interstitialAd;

  @override
  void onInit() async {
    super.onInit();

    getUserData();
    celebImage = argumentData[0]["celebImage"];
    eyeOpenGrid.value = argumentData[1]["eyeOpenGrid"];
    options.value = argumentData[2]["option"];
    hintText = argumentData[3]["hint"];
    celebName = argumentData[4]["celebName"];
    levelId = argumentData[5]["levelId"];
    levelName = argumentData[6]["levelName"];
    levelIndex.value = argumentData[7]["levelIndex"];
    subLevelIndex = argumentData[8]["subLevelIndex"];
    celebData.value = argumentData[9]["celebData"];
    levelLength.value = argumentData[10]["levelTotalLength"];

    // dev.log("this one is random number log ======> ${randomNumber.value}");

    showGridSuggestion.value = await SharedPref().getBoolValuesSF(StorageConstants.watchGridGuide);
    showHintSuggestion.value = await SharedPref().getBoolValuesSF(StorageConstants.watchHintGuide);

    // getBonusLevelData();
    // options.shuffle();
    // options.removeRange(3,6);

    options.add(celebName);
    options.shuffle();
    int random = int.parse(subLevelIndex) + Random().nextInt(5);
    randomNumber = random.obs;

    completedLevelData();
    startPlayingTimer(contexts!);
    loadRewardedAd(contexts!);
    loadWinRewardedAd(contexts!);
    loadTimeRewardedAd(contexts!);
    loadLossRewardedAd(contexts!);
    skipLevelRewardedAd();
    Get.find<CelebHomeController>().userScore = gameCoin;
    animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

  }

  @override
  void dispose() {
    timer!.cancel();
    hintShowAd!.dispose();
    winRewardAd!.dispose();
    timeOutAd!.dispose();
    lossAd!.dispose();
    skipLevelAd!.dispose();
    animationController.dispose();
    // openGridAnimationController!.dispose();
    // closeGridAnimationController!.dispose();
    super.dispose();
  }


  void startPlayingTimer(BuildContext context) {
    timerContainerWidth = displayHeight(context) > 1000 ? (displayWidth(context) * 0.34).obs : (displayWidth(context) * 0.32).obs;

    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (remainTime.value == 0) {
          timer.cancel();
          settingController.vibration.value ==
              true ? Vibration.vibrate(duration: 100, amplitude: 128) :Vibration.vibrate(duration: 0, amplitude: 0);

          TimeOutDialog().timeOutDialog(context: context,levelName: levelName,levelIndex: levelIndex.value);
          update();
        } else {
          if (timerContainerWidth.value >= 0.0 && !networkController.outOfNetwork.value && !showGridSuggestion.value && !showHintSuggestion.value) {
            remainTime--;
            timerContainerWidth.value -= displayWidth(context) * 0.015;
          }
          update();
        }
        // if(remainTime.value < 6){
        //   animationController.repeat(max: 10,period: Duration(seconds: 1));
        // }
        if (settingController.sound.value) {
          AudioPlayer.playTenSec(remainSec: remainTime.value);
          AudioPlayer.playTimeUp(remainSec: remainTime.value);
        }
      },
    );
  }


  updateCoinData(context) async{
    adCoin = adCoin + 12;
    purchaseCoin = purchaseCoin + 1;
    // await fireStore
    //     .collection(FirebaseConstant.userKey)
    //     .doc(userDeviceID)
    //     .update({
    //   FirebaseConstant.adCoin: adCoin.value.toString(),
    //   FirebaseConstant.purchaseCoinAd: purchaseCoin.value.toString(),
    // });
    await SharedPref().addStringToSF(StorageConstants.purchaseCoinAdShow, purchaseCoin.value.toString());
    await SharedPref().addStringToSF(StorageConstants.adCoin, adCoin.value.toString());

    startPlayingTimer(context);
    timerContainerWidth.value = displayWidth(context) * (remainTime.value * 0.016);

  }


  completedLevelData({bool isLoss = false}){
    final Map<String,dynamic> completeLevelData = {
      FirebaseConstant.photoName : celebName,
      FirebaseConstant.eyeOpenGrid : ["32","33","34","35","36","37"],
      FirebaseConstant.hint : hintText,
      FirebaseConstant.imageUrl : celebImage,
      FirebaseConstant.levelCategory : levelName,
      FirebaseConstant.id : levelId,
      FirebaseConstant.options : options.value,
      FirebaseConstant.starDetail: isLoss ? ImageConstants.silverStar :remainTime > 13 ?ImageConstants.goldStar :remainTime >6 ?ImageConstants.silverStar:ImageConstants.bronzeStar,
      FirebaseConstant.userLevel : int.parse(subLevelIndex) <= 9 ? "$zero$zero$subLevelIndex" : int.parse(subLevelIndex) <= 99 ?"$zero$subLevelIndex" : subLevelIndex,
    };

    return completeLevelData;
  }

  updateUserData(String levelExist,bool isLoss) {
    var data = {
      FirebaseConstant.userCoin: gameCoin.value.toString(),
      FirebaseConstant.adCoin: isLoss ? (adCoin.value+2).toString() : adCoin.value.toString(),
      FirebaseConstant.winCoin:  !isLoss? remainTime.value > 13 ? (winCoin.value+30).toString() : remainTime > 6 ? (winCoin.value+20).toString() :(winCoin.value+10).toString() : (winCoin.value).toString(),
      FirebaseConstant.goldStar: !isLoss? remainTime.value > 13 ? (goldStar.value+1).toString() : (goldStar.value).toString(): (goldStar.value).toString(),
      FirebaseConstant.id: levelIds,
      levelExist: false,
    };
    return data;
  }

  updateLevelDetail({required bool isLoss}){
    // ignore: unrelated_type_equality_checks
    final Map<String, dynamic> userData = levelIndex == 0
        ? updateUserData(FirebaseConstant.noobExist,isLoss)
        : levelIndex == 1
        ? updateUserData(FirebaseConstant.internExist,isLoss)
        : levelIndex == 2
        ? updateUserData(FirebaseConstant.expertExist,isLoss)
        : levelIndex == 3
        ? updateUserData(FirebaseConstant.masterExist,isLoss)
        : updateUserData(FirebaseConstant.legendExist,isLoss);

    return userData;
  }

  updateSharedPrefrenceUserData(String levelExist,bool isLoss)async{
    int localWinCoin = int.parse(await SharedPref().getStringValuesSF(StorageConstants.winCoin));
    int localGoldStar = int.parse(await SharedPref().getStringValuesSF(StorageConstants.goldStar));

    String adCoins =  isLoss ? (adCoin.value+2).toString() : adCoin.value.toString();
    String winCoins =  !isLoss? remainTime.value > 13 ? (localWinCoin+30).toString() : remainTime > 6 ? (localWinCoin +20).toString() :(localWinCoin +10).toString() : (localWinCoin).toString();
    String goldStars =  !isLoss? remainTime.value > 13 ? (localGoldStar +1).toString() : (localGoldStar).toString(): (localGoldStar).toString();


    await SharedPref().addStringToSF(StorageConstants.gameCoin, gameCoin.value.toString());
    await SharedPref().addStringToSF(StorageConstants.adCoin, adCoins);
    await SharedPref().addStringToSF(StorageConstants.winCoin, winCoins);
    await SharedPref().addStringToSF(StorageConstants.goldStar, goldStars);
    await SharedPref().addStringToSF(StorageConstants.levelID, jsonEncode(levelIds));


    SharedPref().setBoolToSF(levelExist,false);
  }

  updateLocalLevelDetail({required bool isLoss}){
    levelIndex == 0
        ? updateSharedPrefrenceUserData(FirebaseConstant.noobExist,isLoss)
        : levelIndex == 1
        ? updateSharedPrefrenceUserData(FirebaseConstant.internExist,isLoss)
        : levelIndex == 2
        ? updateSharedPrefrenceUserData(FirebaseConstant.expertExist,isLoss)
        : levelIndex == 3
        ? updateSharedPrefrenceUserData(FirebaseConstant.masterExist,isLoss)
        : updateSharedPrefrenceUserData(FirebaseConstant.legendExist,isLoss);
  }

  /// /////////// open grid on onTap//////
  bool showGrid(int index) {
    if (index + 1 == int.parse(eyeOpenGrid.first) - 4 ||
        index + 1 == int.parse(eyeOpenGrid.first) - 5 ||
        index + 1 == int.parse(eyeOpenGrid.first) - 6 ||
        index + 1 == int.parse(eyeOpenGrid.first) - 7 ||
        index + 1 == int.parse(eyeOpenGrid.first) - 8 ||
        index + 1 == int.parse(eyeOpenGrid.first) - 9 ||
        index + 1 == int.parse(eyeOpenGrid.last) + 6 ||
        index + 1 == int.parse(eyeOpenGrid.last) + 7 ||
        index + 1 == int.parse(eyeOpenGrid.last) + 8 ||
        index + 1 == int.parse(eyeOpenGrid.last) + 9 ||
        index + 1 == int.parse(eyeOpenGrid.last) + 10||
        index + 1 == int.parse(eyeOpenGrid.last) + 11
    ) {
      return true;
    } else {
      return false;
    }
  }

  RxString starImage(){
    if(remainTime > 13){
      return ImageConstants.goldStar.obs;
    }else if(remainTime <= 13 && remainTime > 6){
      return ImageConstants.silverStar.obs;
    }else{
      return ImageConstants.bronzeStar.obs;
    }
  }

  /// /////// open eye grid ///////
  Color showEye(String index) {
    if (eyeOpenGrid.contains(index)) {
      return Colors.transparent;
    }
    return ColorConstants.redColor;
  }

  Color showEyeBorder(String index) {
    if (eyeOpenGrid.contains(index)) {
      return Colors.transparent;
    }
    return Colors.black.withOpacity(0.2);
  }

  getUserData()  async{

    gameCoin.value = int.parse(await SharedPref().getStringValuesSF(StorageConstants.gameCoin));
    adCoin.value = int.parse(await SharedPref().getStringValuesSF(StorageConstants.adCoin));
    winCoin.value = int.parse(await SharedPref().getStringValuesSF(StorageConstants.winCoin));
    goldStar.value = int.parse(await SharedPref().getStringValuesSF(StorageConstants.goldStar));
    hintAdShow.value = int.parse(await SharedPref().getStringValuesSF(StorageConstants.hintAdShow));
    timeOutAdShow.value = int.parse(await SharedPref().getStringValuesSF(StorageConstants.timeOutAdShow));
    loseAdShow.value = int.parse(await SharedPref().getStringValuesSF(StorageConstants.loseAdShow));
    purchaseCoin.value = int.parse(await SharedPref().getStringValuesSF(StorageConstants.purchaseCoinAdShow));

    var storeLevelId = await SharedPref().getStringValuesSF(StorageConstants.levelID);
    var levelLocalId = jsonDecode(storeLevelId);
    levelIds.value = levelLocalId;
    dev.log("==gameCoin====> $levelIds");

    if(!levelIds.contains(levelId)){
      levelIds.add(levelId);
    }
  }

  // getBonusLevelData() async{
  //   var jsonText =  await rootBundle.loadString(StorageConstants.bonusJsonData);
  //   bonusLevel = json.decode(jsonText);
  //   return bonusLevel;
  // }

  void loadRewardedAd(context) {
    RewardedInterstitialAd.load(
      adUnitId: AdMobServices.rewardedInterstitialAdUnitId.toString(),
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          hintShowAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {

              isRewardedAdReady.value = false;
              startPlayingTimer(context);
              timerContainerWidth.value = displayWidth(context) * (remainTime.value * 0.016);
              if (showFirstHint.value) {
                showSecondHint.value = true;
                showHint.value = true;
                if(showHint.value){
                  Future.delayed(const Duration(seconds: 5),() {
                    showHint.value = false;
                  },);
                }
              } else {
                showFirstHint.value = true;
                showHint.value = true;
                if(showHint.value){
                  Future.delayed(const Duration(seconds: 5),() {
                    showHint.value = false;
                  },);
                }
              }
              loadRewardedAd(context);
            },
          );

          isRewardedAdReady.value = true;
        },
        onAdFailedToLoad: (err) {
          if (kDebugMode) {
            print('Failed to load a rewarded ad: ${err.message}');
          }
          isRewardedAdReady.value = false;
        },
      ),
    );
  }

  void loadWinRewardedAd(context) {
    RewardedInterstitialAd.load(
      adUnitId: AdMobServices.rewardedInterstitialAdUnitId.toString(),
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          winRewardAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {

              isWinRewardedAdReady.value = false;
              startPlayingTimer(context);

              loadWinRewardedAd(context);
            },
          );

          isWinRewardedAdReady.value = true;
        },
        onAdFailedToLoad: (err) {
          if (kDebugMode) {
            print('Failed to load a rewarded ad: ${err.message}');
          }
          isWinRewardedAdReady.value = false;
        },
      ),
    );
  }

  void loadTimeRewardedAd(context) {
    RewardedInterstitialAd.load(
      adUnitId: AdMobServices.rewardedInterstitialAdUnitId.toString(),
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          timeOutAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              isTimeAdReady.value = false;
              remainTime.value = 20;
              startPlayingTimer(context);
              loadTimeRewardedAd(context);
            },
          );
          isTimeAdReady.value = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
          isTimeAdReady.value = false;
        },
      ),
    );
  }

  void loadLossRewardedAd(context) {
    RewardedInterstitialAd.load(
      adUnitId: AdMobServices.rewardedInterstitialAdUnitId.toString(),
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(

        onAdLoaded: (ad) {
          lossAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              isLossAdReady.value = false;
              remainTime.value = 20;
              startPlayingTimer(context);
              loadLossRewardedAd(context);
            },
          );

          isLossAdReady.value = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
          isLossAdReady.value = false;
        },

      ),
    );
  }

  void skipLevelRewardedAd() {
    RewardedInterstitialAd.load(
      adUnitId: AdMobServices.rewardedInterstitialAdUnitId.toString(),
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          skipLevelAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {

              isSkipLevelAdReady.value = false;

              skipLevelRewardedAd();
            },
          );

          isSkipLevelAdReady.value = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
          isSkipLevelAdReady.value = false;
        },
      ),
    );
  }

}
