import 'dart:developer';

import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class AdMobServices extends GetxController {
  InterstitialAd? interstitialAd;
  BannerAd? bannerAd;
  RewardedAd? rewardedAd;

  ///Android test id
  // static String openAppId = "ca-app-pub-3940256099942544/3419835294";
  // static String interstitialAdId = "ca-app-pub-3940256099942544/1033173712";
  // static String rewardAdId = "ca-app-pub-3940256099942544/5224354917";
  // static String rewardedInterstitialAdId = "ca-app-pub-3940256099942544/5354046379";

  ///Android prod id
  static String openAppId = "ca-app-pub-5033699399153898/1668439033";
  static String interstitialAdId = "ca-app-pub-5033699399153898/1711056668";
  static String rewardAdId = "ca-app-pub-5033699399153898/4525702511";
  static String rewardedInterstitialAdId = "ca-app-pub-5033699399153898/3063349554";



  //iOS test id
  // static String openAppIOSId = "ca-app-pub-3940256099942544/1712485313";
  // static String interstitialAdIOSId = "ca-app-pub-3940256099942544/4411468910";
  // static String rewardAdIOSId = "ca-app-pub-3940256099942544/1712485313";
  // static String rewardedInterstitialAdIOSId = "ca-app-pub-3940256099942544/6978759866";

  ///iOS prod id
  static String openAppIOSId = "ca-app-pub-5033699399153898/1782891628";
  static String interstitialAdIOSId = "ca-app-pub-5033699399153898/8348299971";
  static String rewardAdIOSId = "ca-app-pub-5033699399153898/1559530345";
  static String rewardedInterstitialAdIOSId = "ca-app-pub-5033699399153898/4409054962";

  @override
  void onInit() {
    super.onInit();
    createInterstitialAd();
    // createRewardAd();
  }
  ///////////////////////// App Open Unit Id /////////////////////////

  static String? get appOpenAdUnitId {
    if (Platform.isAndroid) {
      return openAppId;
    } else if (Platform.isIOS) {
      return openAppIOSId;
    }
    return null;
  }


  ///////////////////////// Banner Ads Unit Id /////////////////////////

  // static String? get bannerAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-3940256099942544/6300978111';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-3940256099942544/2934735716';
  //   }
  //   return null;
  // }

  ///////////////////////// Interstitial Ads Unit Id /////////////////////////

  static String? get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return interstitialAdId;
    } else if (Platform.isIOS) {
      return interstitialAdIOSId;
    }
    return null;
  }

  ///////////////////////// Rewarded Ads Unit Id /////////////////////////

  static String? get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return rewardAdId;
    } else if (Platform.isIOS) {
      return rewardAdIOSId;
    }
    return null;
  }

  ///////////////////////// Rewarded Interstitial Ads Unit Id /////////////////////////

  static String? get rewardedInterstitialAdUnitId {
    if (Platform.isAndroid) {
      return rewardedInterstitialAdId;
    } else if (Platform.isIOS) {
      return rewardedInterstitialAdIOSId;
    }
    return null;
  }

  //////////// interstitial Ad ///////////
  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdMobServices.interstitialAdUnitId.toString(),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => interstitialAd = ad,
        onAdFailedToLoad: (LoadAdError error) => interstitialAd = null,
      ),
    );
  }

  void showInterstitialAd({required void Function(InterstitialAd)? onAdDismissedFullScreenContent}) {
    if (interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: onAdDismissedFullScreenContent
      );
      interstitialAd!.show();
      interstitialAd = null;
    }
  }

//////////// reward Ad ///////////

// void createRewardAd() {
//   RewardedAd.load(
//     adUnitId: AdMobServices.rewardedAdUnitId.toString(),
//     request: const AdRequest(),
//     rewardedAdLoadCallback: RewardedAdLoadCallback(
//       onAdLoaded: (ad) => rewardedAd = ad,
//       onAdFailedToLoad: (LoadAdError error) => rewardedAd = null,
//     ),
//   );
// }
//
// void showRewardAd({required void Function(RewardedAd)? onAdWillDismissFullScreenContent}) {
//   if (rewardedAd != null) {
//     rewardedAd!.show(onUserEarnedReward: (ad, reward) {
//
//     },);
//     log("=s==s=s=s=s=s=s=s=> come here2");
//     rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdWillDismissFullScreenContent: onAdWillDismissFullScreenContent,
//     );
//
//     rewardedAd = null;
//   }
// }

}
