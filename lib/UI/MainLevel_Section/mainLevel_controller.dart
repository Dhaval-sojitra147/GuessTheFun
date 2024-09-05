import 'dart:convert';
import 'dart:developer';
import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class MainLevelController extends GetxController {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  @override
  void onInit() async {
    // TODO: implement onInit
    noobExist.value = await SharedPref().getBoolValuesSF(StorageConstants.noobExist);
    internExist.value = await SharedPref().getBoolValuesSF(StorageConstants.internExist);
    expertExist.value = await SharedPref().getBoolValuesSF(StorageConstants.expertExist);
    masterExist.value= await SharedPref().getBoolValuesSF(StorageConstants.masterExist);
    legendExist.value = await SharedPref().getBoolValuesSF(StorageConstants.legendExist);
    getUserData();
    getGameCelebrityData();
    completeLevelId;
    update();
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();

  }

  List<String> baseImage = [ImageConstants.noobBase, ImageConstants.internBase, ImageConstants.expertBase, ImageConstants.masterBase, ImageConstants.legendBase];
  List<String> levelListName = [AppConstants.noob.tr, AppConstants.intern.tr, AppConstants.expert.tr, AppConstants.master.tr, AppConstants.legend.tr,];
  List<String> smilyImage = [ImageConstants.noobSmily, ImageConstants.internSmily, ImageConstants.expertSmily, ImageConstants.internSmily, ImageConstants.legendSmily];
  List<Color> levelTextColor = [ColorConstants.yellowColor, ColorConstants.offYellowColor, ColorConstants.offWhiteColor, ColorConstants.offBlackColor, ColorConstants.yellowOpacityColor];
  RxList completeLevelLength = [].obs;
  RxList levelLength = [].obs;
  RxList completeLevelId = [].obs;
  RxInt totalLevel = 0.obs;
  RxBool noobExist = false.obs;
  RxBool internExist = false.obs;
  RxBool expertExist = false.obs;
  RxBool masterExist = false.obs;
  RxBool legendExist = false.obs;



  getUserData() async {

    var noobData = await getUserLevelData(FirebaseConstant.noob);
    var internData = !internExist.value ? await getUserLevelData(FirebaseConstant.intern):[];
    var expertData = !expertExist.value ? await getUserLevelData(FirebaseConstant.expert):[];
    var masterData = !masterExist.value ? await getUserLevelData(FirebaseConstant.master):[];
    var legendData = !legendExist.value ? await getUserLevelData(FirebaseConstant.legend):[];
    completeLevelLength.value.addAll([
      noobData.length,
      internData.length,
      expertData.length,
      masterData.length,
      legendData.length
    ]);

    // get complete levle id from local Storage
    var storeLevelId = await SharedPref().getStringValuesSF(StorageConstants.levelID);
    var levelId = storeLevelId.isNotEmpty ? jsonDecode(storeLevelId) : [];
    completeLevelId.value = levelId;
  }

  getUserLevelData(String level) async {
    var winData = [];
    bool userEnter = await SharedPref().getBoolValuesSF(StorageConstants.userEnter);

    if(!userEnter && ((level == FirebaseConstant.noob && !noobExist.value) ||
        (level == FirebaseConstant.intern && !internExist.value) ||
        (level == FirebaseConstant.expert && !expertExist.value) ||
        (level == FirebaseConstant.master && !masterExist.value) ||
        (level == FirebaseConstant.legend && !legendExist.value))){
      var winLocal = await SharedPref().getStringValuesSF(level);
      winData = await jsonDecode(winLocal);

      return winData;
    }else {

      /// TODO : Reduce Read Request from here
      log("DATA GETTING FROM FIREBASE");
      QuerySnapshot<Map<String, dynamic>> userLevelData = await fireStore
          .collection(FirebaseConstant.userKey)
          .doc(userDeviceID)
          .collection(level)
          .get();

      return userLevelData.docs;
    }

  }

  getGameCelebrityData() async {
    // noob length
    var noobLevelOneData = await gameCelebrityData(
        level: StorageConstants.noobJsonData, subLevelData: FirebaseConstant.noobOne);
    var noobLevelTwoData = await gameCelebrityData(
        level: StorageConstants.noobJsonData, subLevelData: FirebaseConstant.noobTwo);
    var noobLevelThreeData = await gameCelebrityData(
        level: StorageConstants.noobJsonData, subLevelData: FirebaseConstant.noobThree);
    var noobLevelFourData = await gameCelebrityData(
        level: StorageConstants.noobJsonData, subLevelData: FirebaseConstant.noobFour);
    var noobLevelFiveData = await gameCelebrityData(
        level: StorageConstants.noobJsonData, subLevelData: FirebaseConstant.noobFive);
    var noobLength = noobLevelOneData.length +  /// noob
        noobLevelTwoData.length +
        noobLevelThreeData.length +
        noobLevelFourData.length +
        noobLevelFiveData.length;

    // intern length
    var internLevelOneData = await gameCelebrityData(
        level: StorageConstants.internJsonData,
        subLevelData: FirebaseConstant.internOne);
    var internLevelTwoData = await gameCelebrityData(
        level: StorageConstants.internJsonData,
        subLevelData: FirebaseConstant.internTwo);
    var internLevelThreeData = await gameCelebrityData(
        level: StorageConstants.internJsonData,
        subLevelData: FirebaseConstant.internThree);
    var internLevelFourData = await gameCelebrityData(
        level: StorageConstants.internJsonData,
        subLevelData: FirebaseConstant.internFour);
    var internLevelFiveData = await gameCelebrityData(
        level: StorageConstants.internJsonData,
        subLevelData: FirebaseConstant.internFive);
    var internLength = internLevelOneData.length +    /// intern
        internLevelTwoData.length +
        internLevelThreeData.length +
        internLevelFourData.length +
        internLevelFiveData.length;

    // expert length
    var expertLevelOneData = await gameCelebrityData(
        level: StorageConstants.expertJsonData,
        subLevelData: FirebaseConstant.expertOne);
    var expertLevelTwoData = await gameCelebrityData(
        level: StorageConstants.expertJsonData,
        subLevelData: FirebaseConstant.expertTwo);
    var expertLevelThreeData = await gameCelebrityData(
        level: StorageConstants.expertJsonData,
        subLevelData: FirebaseConstant.expertThree);
    var expertLevelFourData = await gameCelebrityData(
        level: StorageConstants.expertJsonData,
        subLevelData: FirebaseConstant.expertFour);
    var expertLevelFiveData = await gameCelebrityData(
        level: StorageConstants.expertJsonData,
        subLevelData: FirebaseConstant.expertFive);
    var expertLength =  expertLevelOneData.length +  /// expert
        expertLevelTwoData.length +
        expertLevelThreeData.length +
        expertLevelFourData.length +
        expertLevelFiveData.length;

    // master length
    var masterLevelOneData = await gameCelebrityData(
        level: StorageConstants.masterJsonData,
        subLevelData: FirebaseConstant.masterOne);
    var masterLevelTwoData = await gameCelebrityData(
        level: StorageConstants.masterJsonData,
        subLevelData: FirebaseConstant.masterTwo);
    var masterLevelThreeData = await gameCelebrityData(
        level: StorageConstants.masterJsonData,
        subLevelData: FirebaseConstant.masterThree);
    var masterLevelFourData = await gameCelebrityData(
        level: StorageConstants.masterJsonData,
        subLevelData: FirebaseConstant.masterFour);
    var masterLevelFiveData = await gameCelebrityData(
        level: StorageConstants.masterJsonData,
        subLevelData: FirebaseConstant.masterFive);
    var masterLength = masterLevelOneData.length +   /// master
        masterLevelTwoData.length +
        masterLevelThreeData.length +
        masterLevelFourData.length +
        masterLevelFiveData.length;

    // expert length
    var legendLevelOneData = await gameCelebrityData(
        level: StorageConstants.legendJsonData,
        subLevelData: FirebaseConstant.legendOne);
    var legendLevelTwoData = await gameCelebrityData(
        level: StorageConstants.legendJsonData,
        subLevelData: FirebaseConstant.legendTwo);
    var legendLevelThreeData = await gameCelebrityData(
        level: StorageConstants.legendJsonData,
        subLevelData: FirebaseConstant.legendThree);
    var legendLevelFourData = await gameCelebrityData(
        level: StorageConstants.legendJsonData,
        subLevelData: FirebaseConstant.legendFour);
    var legendLevelFiveData = await gameCelebrityData(
        level: StorageConstants.legendJsonData,
        subLevelData: FirebaseConstant.legendFive);
    var legendLength =  legendLevelOneData.length +   /// legend
        legendLevelTwoData.length +
        legendLevelThreeData.length +
        legendLevelFourData.length +
        legendLevelFiveData.length;

    levelLength.value.addAll([
      noobLength, internLength, expertLength, masterLength, legendLength
    ]);

    totalLevel.value = noobLength + internLength + expertLength + masterLength + legendLength;
  }

  gameCelebrityData(
      {required String level, required String subLevelData}) async {
    Map<String, dynamic> celebJsonData = {};

    var jsonText = await rootBundle.loadString(level);
    celebJsonData = json.decode(jsonText);

    return celebJsonData[subLevelData];

    // var celebrityData = FirebaseFirestore.instance
    //     .collection(FirebaseConstant.gamePlay)
    //     .doc(level)
    //     .collection(subLevelData)
    //     .get();
    //
    // return celebrityData;
  }
}
