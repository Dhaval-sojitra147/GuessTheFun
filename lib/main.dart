import 'package:celebrity_quiz/Infrastructure/Base/Notification/getfcm.dart';
import 'package:celebrity_quiz/Infrastructure/Base/Notification/local_notification_service.dart';
import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

///////////////////////// App Open Ads /////////////////////////

AppOpenAd? appOpenAd;

Future<void> loadAppOpenAds() async {
  await AppOpenAd.load(
      adUnitId: AdMobServices.appOpenAdUnitId.toString(),
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          appOpenAd = ad;
          appOpenAd!.show();
        },
        onAdFailedToLoad: (error) {
          debugPrint("Failed to Load Ads $error");
        },
      ),
      orientation: AppOpenAd.orientationPortrait);
}

void showAds() {
  if (appOpenAd == null) {
    loadAppOpenAds();
    return;
  }
}


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(apiKey: Platform.isAndroid ? "AIzaSyClTbfc5pv9V1AJIRtRfKIgg07J__K-x4U" :"AIzaSyBLUxT0jPEN_5xjPcJ0uRn6k9WyvxZggVI", appId: Platform.isAndroid ?"1:149486477367:android:15078aa65ccc49fb4e1fb2" : "1:149486477367:ios:223c676e5511e1ad4e1fb2", messagingSenderId: "", projectId: "guess-the-celebrities-14c79",));
  await FCM().setNotifications();
  LocalNotification.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,overlays: [SystemUiOverlay.top]);

  await MobileAds.instance.initialize();

  showAds();
  // await UnityAds.init(
  //   gameId: Platform.isAndroid ? AppConstants.androidUnityID : AppConstants.iosUnityID,
  //   onComplete: () => print('Initialization Complete'),
  //   testMode: true,
  //   onFailed: (error, message) => print('Initialization Failed: $error $message'),
  // );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SettingController settingController = Get.put(SettingController());

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    // CelebrityNotification().getNotificationReq(context);

    getSoundValue();

  }

  getSoundValue()async{
    await SharedPref().getBoolValuesSF(StorageConstants.sound);
    await SharedPref().getInt();
  }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Guess the hollywood celebrity',
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      locale: TranslationService.locale,
      translations: TranslationService(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.yellowColor),
        useMaterial3: true,
      ),
    );
  }
}

