// import 'dart:io';
// import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
// import 'package:get/get.dart';
//
// class UnityAdController extends GetxController{
//
//   RxBool loadRewardAd = false.obs;
//
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       await UnityAdController().loadUnityIntAd();
//       await UnityAdController().loadUnityRewardedAd();
//     });
//   }
//
//   Future<void> loadUnityIntAd() async {
//     await UnityAds.load(
//       placementId: Platform.isAndroid ? 'Interstitial_Android' : "Interstitial_iOS",
//       onComplete: (placementId) => print('Load Complete $placementId'),
//       onFailed: (placementId, error, message) =>
//           print('Load Failed $placementId: $error $message'),
//     );
//   }
//
//   Future<void> showUnityIntAd({dynamic Function(String)? onComplete}) async {
//     UnityAds.showVideoAd(
//         placementId: Platform.isAndroid ? 'Interstitial_Android' : "Interstitial_iOS",
//         onStart: (placementId) => print('Video Ad $placementId started'),
//         onClick: (placementId) => print('Video Ad $placementId click'),
//         onSkipped: (placementId) => print('Video Ad $placementId skipped'),
//         onComplete: onComplete ?? (placementId) async {
//           await loadUnityIntAd();
//         },
//         onFailed: (placementId, error, message) async {
//           await loadUnityIntAd();
//         });
//   }
//
//   Future<void> loadUnityRewardedAd() async {
//     await UnityAds.load(
//       placementId: Platform.isAndroid ? 'Rewarded_Android' : "Rewarded_iOS",
//       onComplete: (placementId) {
//         print('Load Complete $placementId');
//       },
//       onFailed: (placementId, error, message) =>
//           print('Load Failed $placementId: $error $message'),
//     );
//   }
//
//   Future<void> showUnityRewardedAd(
//       {dynamic Function(String)? onComplete}) async {
//     UnityAds.showVideoAd(
//         placementId: Platform.isAndroid ? 'Rewarded_Android' : "Rewarded_iOS",
//         onStart: (placementId) => print('Video Ad $placementId started'),
//         onClick: (placementId) => print('Video Ad $placementId click'),
//         onSkipped: (placementId) => print('Video Ad $placementId skipped'),
//         onComplete: onComplete ?? (placementId) async {
//           await loadUnityRewardedAd();
//         },
//         onFailed: (placementId, error, message) async {
//           await loadUnityRewardedAd();
//         });
//   }
// }