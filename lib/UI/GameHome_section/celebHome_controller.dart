import 'dart:convert';
import 'dart:developer';
import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:celebrity_quiz/main.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

RxInt currentLanguageIndex = 0.obs;

class CelebHomeController extends GetxController with GetSingleTickerProviderStateMixin{

  RxInt remainingSeconds = 10800.obs; // 24 hours in seconds
  Timer? timer;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  RxInt userScore = 0.obs;
  RxList completeLevelId = [].obs;
  RxInt adCoin = 0.obs;
  RxInt winCoin = 0.obs;
  RxInt purchaseCoinAdShow = 0.obs;
  RxInt claimBonusAdShow = 0.obs;
  RxInt goldStar = 0.obs;
  RxInt hindAdShow = 0.obs;
  RxInt timeOutAdShow = 0.obs;
  RxInt loseAdShow = 0.obs;
  RxString remainTime = "".obs;
  RxBool showPopUp = false.obs;
  RxString appName = "".obs;
  RxString packageName = "".obs;
  RxString version = "".obs;
  RxInt buildNumber = 0.obs;
  late bool music;
  dynamic argumentData = Get.arguments;


  // RxInt currentLanguageIndex = 0.obs;
  // void getToken() async {
  //   String? fcmKey = await getFcmToken();
  //   if (kDebugMode) {
  //     print('This one is FCM Key : $fcmKey');
  //   }
  // }

  /// Google AdMob
    //claim Bonus
      //Reward Ad
        RxBool isClaimBonusAdReady = false.obs;
        RewardedAd? claimBonusAd;

    //  Get Coin
    RxBool isGetCoinAdReady = false.obs;
    RewardedAd? getCoinAd;

  late AnimationController animationController;

  String formatDuration(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void onInit() async{
    super.onInit();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

     appName.value = packageInfo.appName;
     packageName.value = packageInfo.packageName;
     version.value = packageInfo.version;
     buildNumber.value = int.parse(packageInfo.buildNumber);

    showAds();

    getUserData();
    userScore;
    animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    currentLanguageIndex.value =  await SharedPref().getInt();
    currentLanguageIndex.value == 0 ? TranslationService().changeLocale("en") : TranslationService().changeLocale("hi");
    music = await SharedPref().getBoolValuesSF(StorageConstants.sound);
    // if wish to add bg music in app
    // if (music) {
    //   log("play from here");
    //   // AudioPlayer.playMusic();
    // }
    startTimer();
    loadRewardedAd();
    loadGetCoinRewardedAd();
    checkInternetConnection();
    WidgetsBinding.instance!.addObserver(Handler());
  }

  @override
  void dispose() {
    animationController.dispose();
    claimBonusAd!.dispose();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (remainingSeconds.value > 0) {
          remainingSeconds.value--;
          update();
        } else {
          timer?.cancel();
          update();
        }
      });
  }

  void getAppVersion() async{

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    log("this one is appName ===> $appName");
    log("this one is packageName ===> $packageName");
    log("this one is version ===> $version");
    log("this one is buildNumber ===> $buildNumber");
  }
  /// check app connect with internet or not
  checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none ) {
         showPopUp.value = true;
        // await prefs.setBool('first_time', false);
      }else if ( connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
      showPopUp.value = false;

    }
    }

    /// when user close app so update data in firebase
  updateUserData()async{
        await SharedPref().addStringToSF(StorageConstants.remainTime, Get.find<TimerController>().remainingSeconds.value.toString());
        var userEnter = await SharedPref().getBoolValuesSF(StorageConstants.userEnter);
        if(!userEnter){
          var storeLevelId = await SharedPref().getStringValuesSF(StorageConstants.levelID);
          var levelId = jsonDecode(storeLevelId) ;

          final Map<String, dynamic> updateFireStoreData = {
            /// update local Data on Shared preferences
            FirebaseConstant.remainTime:  await SharedPref().getStringValuesSF(StorageConstants.remainTime),
            FirebaseConstant.userCoin: await SharedPref().getStringValuesSF(StorageConstants.gameCoin),
            FirebaseConstant.adCoin:  await SharedPref().getStringValuesSF(StorageConstants.adCoin),
            FirebaseConstant.claimBonusAd: await SharedPref().getStringValuesSF(StorageConstants.claimBonusAdShow),
            FirebaseConstant.purchaseCoinAd: await SharedPref().getStringValuesSF(StorageConstants.purchaseCoinAdShow),
            FirebaseConstant.hintAd: await SharedPref().getStringValuesSF(StorageConstants.hintAdShow),
            FirebaseConstant.goldStar: await SharedPref().getStringValuesSF(StorageConstants.goldStar),
            FirebaseConstant.winCoin: await SharedPref().getStringValuesSF(StorageConstants.winCoin),
            FirebaseConstant.lossAd: await SharedPref().getStringValuesSF(StorageConstants.loseAdShow),
            FirebaseConstant.timeOutAd: await SharedPref().getStringValuesSF(StorageConstants.timeOutAdShow),
            FirebaseConstant.id: levelId,
            FirebaseConstant.noobExist: await SharedPref().getBoolValuesSF(StorageConstants.noobExist),
            FirebaseConstant.internExist: await SharedPref().getBoolValuesSF(StorageConstants.internExist),
            FirebaseConstant.expertExist: await SharedPref().getBoolValuesSF(StorageConstants.expertExist),
            FirebaseConstant.masterExist: await SharedPref().getBoolValuesSF(StorageConstants.masterExist),
            FirebaseConstant.legendExist: await SharedPref().getBoolValuesSF(StorageConstants.legendExist),
          };
          fireStore.collection(FirebaseConstant.userKey).doc(userDeviceID).update(updateFireStoreData);

          // for(int i = 0; i < levelId.length; i++){
          //   if(i < 200){
          //     var winLocal = await SharedPref().getStringValuesSF(StorageConstants.noob);
          //     winData = await jsonDecode(winLocal);
          //     log("========> this one is user level winning category===> ${jsonDecode(winLocal)[i]["level_category"]}");
          //     fireStore
          //         .collection(FirebaseConstant.userKey)
          //         .doc(userDeviceID)
          //         .collection(FirebaseConstant.noob)
          //         .doc(levelId[i])
          //         .set(winData[i]);
          //
          //   }else if(i < 400 && i > 200){
          //     var winLocal = await SharedPref().getStringValuesSF(StorageConstants.intern);
          //     winData = await jsonDecode(winLocal);
          //     log("========> this one is user level winning category===> ${jsonDecode(winLocal)[i]["level_category"]}");
          //
          //     for(int j = 0; j < winData.length; j++){
          //       fireStore
          //           .collection(FirebaseConstant.userKey)
          //           .doc(userDeviceID)
          //           .collection(FirebaseConstant.intern)
          //           .doc(levelId[i])
          //           .set(winData[j]);
          //     }
          //   }else if(i < 600 && i > 400){
          //     var winLocal = await SharedPref().getStringValuesSF(StorageConstants.expert);
          //     winData = await jsonDecode(winLocal);
          //     log("========> this one is user level winnnig category===> ${jsonDecode(winLocal)[i]["level_category"]}");
          //
          //     for(int j = 0; j < winData.length; j++){
          //       fireStore
          //           .collection(FirebaseConstant.userKey)
          //           .doc(userDeviceID)
          //           .collection(FirebaseConstant.expert)
          //           .doc(levelId[i])
          //           .set(winData[j]);
          //     }
          //   }else if(i < 800 && i > 600){
          //     var winLocal = await SharedPref().getStringValuesSF(StorageConstants.master);
          //     winData = await jsonDecode(winLocal);
          //     log("========> this one is user level winnnig category===> ${jsonDecode(winLocal)[i]["level_category"]}");
          //
          //     for(int j = 0; j < winData.length; j++){
          //       fireStore
          //           .collection(FirebaseConstant.userKey)
          //           .doc(userDeviceID)
          //           .collection(FirebaseConstant.master)
          //           .doc(levelId[i])
          //           .set(winData[j]);
          //     }
          //   }else{
          //     var winLocal = await SharedPref().getStringValuesSF(StorageConstants.legend);
          //     winData = await jsonDecode(winLocal);
          //     log("========> this one is user level winning category123===> ${jsonDecode(winLocal)[i]["level_category"]}");
          //     for(int j = 0; j < winData.length; j++){
          //       fireStore
          //           .collection(FirebaseConstant.userKey)
          //           .doc(userDeviceID)
          //           .collection(FirebaseConstant.legend)
          //           .doc(levelId[i])
          //           .set(winData[j]);
          //     }
          //   }
          // }

        }
  }

  /// if user first time app so get data from firebase otherwise get data from sharedPrefrence
  getUserData()  async{
    bool userEnter = await SharedPref().getBoolValuesSF(StorageConstants.userEnter);
    bool coinExist = await SharedPref().getBoolValuesSF(StorageConstants.coinExist);
    if(userEnter){
      DocumentReference<Map<String, dynamic>> userRef = fireStore
          .collection(FirebaseConstant.userKey)
          .doc(userDeviceID);
      var data = await userRef.get();

      userScore.value = !coinExist ? int.parse(await SharedPref().getStringValuesSF(StorageConstants.gameCoin)) : int.parse(data[FirebaseConstant.userCoin]);
      adCoin.value = int.parse(data[FirebaseConstant.adCoin]);
      winCoin.value = int.parse(data[FirebaseConstant.winCoin]);
      claimBonusAdShow.value = int.parse(data[FirebaseConstant.claimBonusAd]);
      purchaseCoinAdShow.value = int.parse(data[FirebaseConstant.purchaseCoinAd]);
      completeLevelId.value.addAll(data[FirebaseConstant.id]);
      goldStar.value = int.parse(data[FirebaseConstant.goldStar]);
      hindAdShow.value = int.parse(data[FirebaseConstant.hintAd]);
      timeOutAdShow.value = int.parse(data[FirebaseConstant.timeOutAd]);
      loseAdShow.value = int.parse(data[FirebaseConstant.lossAd]);
      remainTime.value = !coinExist ? await SharedPref().getStringValuesSF(StorageConstants.remainTime) : data[FirebaseConstant.remainTime];
     log("CompleteLevelId===> ${completeLevelId.value}");

      await SharedPref().addStringToSF(StorageConstants.gameCoin, userScore.value.toString());
      await SharedPref().addStringToSF(StorageConstants.adCoin, adCoin.value.toString());
      await SharedPref().addStringToSF(StorageConstants.winCoin, winCoin.value.toString());
      await SharedPref().addStringToSF(StorageConstants.claimBonusAdShow, claimBonusAdShow.toString());
      await SharedPref().addStringToSF(StorageConstants.purchaseCoinAdShow, purchaseCoinAdShow.toString());
      await SharedPref().addStringToSF(StorageConstants.levelID, jsonEncode(completeLevelId.value));
      await SharedPref().addStringToSF(StorageConstants.goldStar, goldStar.toString());
      await SharedPref().addStringToSF(StorageConstants.hintAdShow, hindAdShow.toString());
      await SharedPref().addStringToSF(StorageConstants.timeOutAdShow, timeOutAdShow.toString());
      await SharedPref().addStringToSF(StorageConstants.loseAdShow, loseAdShow.toString());
      await SharedPref().addStringToSF(StorageConstants.remainTime, remainTime.value);
      SharedPref().setBoolToSF(StorageConstants.noobExist, data[FirebaseConstant.noobExist]);
      SharedPref().setBoolToSF(StorageConstants.internExist, data[FirebaseConstant.internExist]);
      SharedPref().setBoolToSF(StorageConstants.expertExist, data[FirebaseConstant.expertExist]);
      SharedPref().setBoolToSF(StorageConstants.masterExist, data[FirebaseConstant.masterExist]);
      SharedPref().setBoolToSF(StorageConstants.legendExist, data[FirebaseConstant.legendExist]);

    }
    else{
      userScore.value = int.parse(await SharedPref().getStringValuesSF(StorageConstants.gameCoin));
      adCoin.value = int.parse(await SharedPref().getStringValuesSF(StorageConstants.adCoin));
      winCoin.value = int.parse(await SharedPref().getStringValuesSF(StorageConstants.winCoin));
      claimBonusAdShow.value = int.parse(await SharedPref().getStringValuesSF(StorageConstants.claimBonusAdShow));
      purchaseCoinAdShow.value = int.parse(await SharedPref().getStringValuesSF(StorageConstants.purchaseCoinAdShow));
    }
  }

  //////////// Reward Ad ///////////
  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdMobServices.rewardedAdUnitId.toString(),
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          claimBonusAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {

                isClaimBonusAdReady.value = false;

              loadRewardedAd();
            },
          );

            isClaimBonusAdReady.value = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
            isClaimBonusAdReady.value = false;
        },
      ),
    );
  }

  void loadGetCoinRewardedAd() {
    RewardedAd.load(
      adUnitId: AdMobServices.rewardedAdUnitId.toString(),
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          getCoinAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {

              isGetCoinAdReady.value = false;

              loadGetCoinRewardedAd();
            },
          );

          isGetCoinAdReady.value = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
          isGetCoinAdReady.value = false;
        },

      ),
    );
  }

}