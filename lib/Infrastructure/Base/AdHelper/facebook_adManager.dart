// import 'package:celebrity_quiz/Infrastructure/Commons/Constant/app_constants.dart';
// import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
// import 'package:facebook_audience_network/facebook_audience_network.dart';
// import 'package:get/get.dart';
//
// class FacebookAdController extends GetxController{
//
//   bool isRewardedAdLoaded = false;
//
//   // Interstitial Ad
//   bool isInterstitialAdLoaded = false;
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     FacebookAudienceNetwork.init(
//       testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6", //optional// optional
//       iOSAdvertiserTrackingEnabled: true,
//     ).then((value) {
//       loadFacebookInterstitialAd();
//       loadFacebookRewardedVideoAd();
//     });
//   }
//
//   //////////// Facebook interstitial Ad ///////////
//
//   void loadFacebookInterstitialAd() {
//     FacebookInterstitialAd.loadInterstitialAd(
//       placementId: AppConstants.faceBookInterstitialAdPlacementID,
//       listener: (result, value) {
//         print(">> FAN > Interstitial Ad: $result --> $value");
//         if (result == InterstitialAdResult.LOADED) {
//           isInterstitialAdLoaded = true;
//         }
//
//         if (result == InterstitialAdResult.DISMISSED &&
//             value["invalidated"] == true) {
//           isInterstitialAdLoaded = false;
//           loadFacebookInterstitialAd();
//         }
//       },
//     );
//   }
//
//   showFacebookInterstitialAd() {
//     if (isInterstitialAdLoaded == true) {
//       FacebookInterstitialAd.showInterstitialAd();
//     } else {
//       print("Interstial Ad not yet loaded!");
//     }
//   }
//
//   //////////// Facebook Reward Ad ///////////
//
//   void loadFacebookRewardedVideoAd() {
//     FacebookRewardedVideoAd.loadRewardedVideoAd(
//       placementId: AppConstants.faceBookRewardAdPlacementID,
//       listener: (result, value) {
//
//         print("Rewarded Ad: $result --> $value");
//         if (result == RewardedVideoAdResult.LOADED) isRewardedAdLoaded = true;
//         if (result == RewardedVideoAdResult.VIDEO_COMPLETE && result == RewardedVideoAdResult.VIDEO_CLOSED &&
//             (value == true || value["invalidated"] == true)) {
//           isRewardedAdLoaded = false;
//           Get.find<GamePlayController>().remainTime.value = 20;
//
//           loadFacebookRewardedVideoAd();
//         }
//       },
//     );}
//
//   showFacebookRewardedAd() {
//     if (isRewardedAdLoaded == true) {
//       FacebookRewardedVideoAd.showRewardedVideoAd();
//     } else {
//       print("Rewarded Ad not yet loaded!");
//     }
//   }
// }