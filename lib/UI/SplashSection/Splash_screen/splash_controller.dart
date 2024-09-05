import 'dart:convert';
import 'dart:developer';

import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

var userDeviceID;
RxBool isTestFlight = false.obs;
var appVersionNumber;
var appBuildNumber;

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging
      .instance; // Change here
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo? androidInfo;
  IosDeviceInfo? iosInfo;
  RxString fireStoreDeviceToken = ''.obs;
  RxString deviceId = ''.obs;
  TimerController timerController = Get.put(TimerController());
  SettingController settingController = Get.put(SettingController());
  late AnimationController animationController;
  bool rotateGlass = true;

  @override
  void onInit() async {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 3500),
      vsync: this,
    );
    super.onInit();
    time();
    getDeviceInfo();
    // getAdsInfo();
    getNewVersionInfo();
    // getCeleb();
    // getSharedPreferencesData();
    if (settingController.sound.value) {
      AudioPlayer.playSound(audioName: AudioConstants.splashTheme);
    }

    animationController.forward();
    // Future.delayed(Duration(milliseconds: 3500),() {
    //   animationController.reset();
    // },);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  //  getCeleb() async {
  //  var celebData = await FirebaseFirestore.instance
  //         .collection(FirebaseConstant.gamePlay)
  //         .doc(FirebaseConstant.legend).collection(FirebaseConstant.legendFive).get();
  //
  //  log("===leveldata=> ${jsonEncode(celebData.docs.map((e) => e.data()).toList())}");
  //      return celebData.docs;
  // }

  time() async {
    Timer(
      const Duration(milliseconds: 3500),
          () async {
        await onNormalSignUpTap();
        // Get.toNamed(RoutesConstants.celebHomeScreen);
      },
    );
  }




  Future<void> getNewVersionInfo() async{
    var versionData = await fireStore
        .collection(FirebaseConstant.appVersion)
        .doc(Platform.isAndroid ? FirebaseConstant.androidVersion : FirebaseConstant.iosVersion).get();
    appVersionNumber = versionData.data()![FirebaseConstant.versionNumber];
    appBuildNumber = int.parse(versionData.data()![FirebaseConstant.buildNumber]);
    isTestFlight.value = versionData.data()![FirebaseConstant.isTestFlight];
    log("this one is app  update version ====> ${appVersionNumber}");
    log("this one is app  update version ====> ${appBuildNumber}");
    log("this one is app  update version ====> ${isTestFlight}");

  }

  Future<void> getDeviceInfo() async {
    try {
      if (Platform.isAndroid) {
        androidInfo = await deviceInfo.androidInfo;
      } else if (Platform.isIOS) {
        iosInfo = await deviceInfo.iosInfo;
      }
      print("token is get success ><");

     // await FirebaseMessaging.instance.setAutoInitEnabled(true);
     //  final fcmToken = await FirebaseMessaging.instance.getToken();
     //
     //  print("token is get success >$fcmToken<");


    } on PlatformException {
      debugPrint('Android PlatformException Info');
    }

  }

  onNormalSignUpTap() async {
    final Map<String, dynamic> userFirstData = {
      FirebaseConstant.userDeviceId: Platform.isIOS ? iosInfo!
          .identifierForVendor : androidInfo!.id,
      FirebaseConstant.userLoginTimeKey: DateTime.now().toString(),
      FirebaseConstant.userLastLoginTimeKey: DateTime.now().toString(),
      FirebaseConstant.userDeviceToken: fireStoreDeviceToken.value,
      FirebaseConstant.userDeviceTypeKey: Platform.isIOS ? "IOS" : "Android",
      FirebaseConstant.userDeviceModelKey: Platform.isIOS ? iosInfo!.name : androidInfo!.board,
      FirebaseConstant.userCoin:'50',
      FirebaseConstant.id:[],
      FirebaseConstant.noobExist:true,
      FirebaseConstant.internExist:true,
      FirebaseConstant.expertExist:true,
      FirebaseConstant.masterExist:true,
      FirebaseConstant.legendExist:true,
      FirebaseConstant.remainTime:"0",
      FirebaseConstant.goldStar:"0",
      FirebaseConstant.adCoin:"50",
      FirebaseConstant.winCoin:"0",
      FirebaseConstant.purchaseCoinAd:"0",
      FirebaseConstant.claimBonusAd:"0",
      FirebaseConstant.lossAd:"0",
      FirebaseConstant.timeOutAd:"0",
      FirebaseConstant.hintAd:"0",
    };



    // get user info
    DocumentReference<Map<String, dynamic>> userRef = fireStore
        .collection(FirebaseConstant.userKey)
        .doc(Platform.isIOS ? iosInfo!.identifierForVendor : androidInfo!.id);

    if ((await userRef.get()).exists) {
      var data = await userRef.get();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      userDeviceID = data[FirebaseConstant.userDeviceId];
      var readDisclaimer = prefs.getBool(StorageConstants.readDisclaimer) ?? false;

      final Map<String, dynamic> userData = {
        FirebaseConstant.userDeviceId: Platform.isIOS ? iosInfo!.identifierForVendor : androidInfo!.id,
        FirebaseConstant.userLastLoginTimeKey: DateTime.now().toString(),
        FirebaseConstant.userDeviceToken: fireStoreDeviceToken.value,
        FirebaseConstant.userDeviceTypeKey: Platform.isIOS ? "IOS" : "Android",
        FirebaseConstant.userDeviceModelKey: Platform.isIOS ? iosInfo!.name : androidInfo!.board,
      };
        fireStore.collection(FirebaseConstant.userKey).doc(Platform.isIOS ? iosInfo!.identifierForVendor : androidInfo!.id).update(userData);

      // InAppUpdate.checkForUpdate().then((updateInfo) {
      //   if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
      //     if (updateInfo.immediateUpdateAllowed) {
      //       // Perform immediate update
      //       InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
      //         if (appUpdateResult == AppUpdateResult.success) {
      //
      //         }
      //       });
      //     }
      //   }
      // }
      // );
      if(readDisclaimer){
        Get.offAllNamed(RoutesConstants.celebHomeScreen);
      }else{
        Get.offAll(()=>const WelcomeScreen());
      }

      SharedPref().addStringToSF(StorageConstants.userDeviceToken, fireStoreDeviceToken.value);
    } else {
      fireStore.collection(FirebaseConstant.userKey).doc(Platform.isIOS ? iosInfo!.identifierForVendor : androidInfo!.id).set(userFirstData);
      userDeviceID = Platform.isIOS ? iosInfo!.identifierForVendor : androidInfo!.id;
     Get.off(()=>const WelcomeScreen());
    }
  }


}
