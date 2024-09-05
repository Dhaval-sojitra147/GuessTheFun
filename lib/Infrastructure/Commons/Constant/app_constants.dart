import 'dart:io';

class AppConstants {
  static const String appName = "Guess the hollywood celebrity";

  /// Main Level Section
  static const String levels = "levels";
  static const String noob = "noob";
  static const String intern = "intern";
  static const String expert = "expert";
  static const String master = "master";
  static const String legend = "legend";

  /// Win popup
  static const String winLine = "winLine";
  static const String youGot = "youGot";
  static const String guessWrong = "guessWrong";
  static const String watchAd = "watchAd";
  static const String outOfTime = "outOfTime";
  static const String watchAdForTime = "watchAdForTime";
  static const String bonusLevel = "bonusLevel";

  /// Setting
  static const String soundOn = "soundOn";
  static const String soundOff = "soundOff";
  static const String english = "english";
  static const String hindi = "hindi";
  static const String done = "done";
  static const String terms = "terms";

  /// gameScreen
  static const String que = "que";
  static const String gridGuide = "gridGuide";
  static const String hintGuide = "hintGuide";

  //Claim bonus
  static const String claimBonusTitle = "claimBonusTitle";
  static const String getBonus = "getBonus";
  static const String bonusClaim = "bonusClaim";
  static const String watchAdDoubleCoin = "watchAdDoubleCoin";
  static const String doubleBonus = "doubleBonus";
  static const String watchVideo = "watchVideo";
  static const String justClaim = "justClaim";


  /// rates popup
  static const String enjoyGame = "enjoyGame";
  static const String shareSomeTime = "shareSomeTime";
  static const String rateNow = "rateNow";
  static const String later = "later";

   /// snack-bar
  static const String warning = "warning";
  static const String bonusSubtitle = "bonusSubtitle";

  /// bonus screen
  static const String sorry = "sorry";
  static const String adNotAvailable = "adNotAvailable";

  ///hint popup
  static const String adForHint = "adForHint";
  static const String showMoreHint = "showMoreHint";
  static const String hint1 = "hint1";
  static const String hint2 = "hint2";
  static const String outHint = "outHint";
  static const String back = "back";

  /// share app
  static const String url = "https://play.google.com/store/apps/details?id=com.celebquizwho.app";
  // static const String shareTitle = "Download this Application For Great Experience\n$url";
  static String shareTitle = '''🌟 Elevate your device's style with $appName 🌟

Transform your screen with a stunning collection of wallpapers handpicked for you. From breathtaking landscapes to sleek abstract designs, ${AppConstants.appName} has it all.

🎨 Explore thousands of high-definition wallpapers and find the perfect match for your device. With easy-to-use features, setting up your new wallpaper is a breeze!

✨ Features:

Explore a vast library of wallpapers in various categories.
Save your favorites for quick access.
Share your favorite wallpapers with friends effortlessly.
📱 Download $appName now and let your device shine!

${Platform.isIOS ? "" : url}

 #reelwithfun #funnyreel #ReelApp #Personalization
                ''';


  static const String faceBookRewardAdPlacementID = "VID_HD_16_9_15S_LINK#YOUR_PLACEMENT_ID";
  static const String faceBookInterstitialAdPlacementID = "PLAYABLE#YOUR_PLACEMENT_ID";

  /// ads
  static const String androidUnityID = "4828341";
  static const String iosUnityID = "4828340";

  /// get coins
  static const String getCoinTitle = "getCoinTitle";

  /// noInternet popup
  static const String checkInternet = "checkInternet";

  /// quit popup
  static const String quitConfirmation = "quitConfirmation";


  /// Disclaimer section
  static const String disclaimer = "DISCLAIMER";
  static const String disclaimerDetail = "disclaimerDetail";

  /// Disclaimer section
  static const String welcome = "WELCOME";
  static const String welcomeDetail = "welcomeDetail";

  /// LeaderBoard
  static const String leaderBoard = "leaderBoard";


}