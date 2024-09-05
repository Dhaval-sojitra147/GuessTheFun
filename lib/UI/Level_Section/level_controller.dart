import 'dart:convert';
import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class LevelController extends GetxController with GetSingleTickerProviderStateMixin {
  SettingController settingController = Get.put(SettingController());
  dynamic argumentData = Get.arguments;
  String levelName = "";
  int levelIndex = 0;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  int? index;
  late int langauageIndex;
  RxBool levelVisible = false.obs;
  MainLevelController mainLevelController =Get.put(MainLevelController());

  LevelController({this.index});

  @override
  void onInit() async {
    super.onInit();
    langauageIndex = await SharedPref().getInt();
    levelName = await argumentData[0]["levelName"];
    levelIndex = await argumentData[1]["levelIndex"];
    levelLength.value = await argumentData[2]["levelTotalLength"];
    getUserData();
    completeLevel = await getUserCompleteLevelData();
    celebrityData = await loadCelebJsonData();
    remaingLevelData = await remainLevelList();
    celebsData = await finalCelebData();
    completeLevelId;
    if (celebsData.isNotEmpty && celebrityData!.isNotEmpty) {
      levelVisible.value = true;
    }
    // Get.find<CelebHomeController>().userScore = gameCoin;
    Get.find<MainLevelController>().completeLevelId.value = completeLevelId;
    Get.find<MainLevelController>().completeLevelLength.replaceRange(levelIndex, levelIndex + 1, [completeLevel.length]);

    introController!.value = PageController(initialPage: ((completedLevelLength.value / 10).ceil()) - 1);
    initialIndex.value = ((completedLevelLength.value / 10).ceil()) - 1;
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  RxInt initialIndex = 0.obs;
  Rx<PageController>? introController = PageController().obs;
  RxList completeLevelId = [].obs;
  RxBool noobExist = false.obs;
  RxBool internExist = false.obs;
  RxBool expertExist = false.obs;
  RxBool masterExist = false.obs;
  RxBool legendExist = false.obs;
  RxInt gameCoin = 0.obs;
  var celebrityData;
  var remaingLevelData;
  List celebsData = [];
  var completeLevel;
  var element;
  var data;
  RxInt completedLevelLength = 0.obs;
  RxInt levelLength = 0.obs;

  Map<String, dynamic> celebJsonData = {};

  ///get user data from shared prefrence
  getUserData() async {

    ///get completeLevelId
    var storeLevelId = await SharedPref().getStringValuesSF(StorageConstants.levelID);
    var levelId = jsonDecode(storeLevelId);
    completeLevelId.value = levelId;

    gameCoin.value =  int.parse(await SharedPref().getStringValuesSF(StorageConstants.gameCoin));
    noobExist.value = await SharedPref().getBoolValuesSF(StorageConstants.noobExist);
    internExist.value = await SharedPref().getBoolValuesSF(StorageConstants.internExist);
    expertExist.value = await SharedPref().getBoolValuesSF(StorageConstants.expertExist);
    masterExist.value = await SharedPref().getBoolValuesSF(StorageConstants.masterExist);
    legendExist.value = await SharedPref().getBoolValuesSF(StorageConstants.legendExist);
  }

  /// get userCompleteLevel list
  getUserCompleteLevelData() async {
    // /// get Data From Firebase

    // QuerySnapshot<Map<String, dynamic>> completeLevelData = await fireStore
    //     .collection(FirebaseConstant.userKey)
    //     .doc(userDeviceID)
    //     .collection(levelName.toLowerCase())
    //     .orderBy(FirebaseConstant.userLevel, descending: false)
    //     .get();
    //
    // completedLevelLength.value = completeLevelData.docs.length;
    // update();
    // log ("this one in level Controller winning Data this won is winning Data===a=a=a=a=a=a=> ${jsonEncode(completeLevelData.docs.map((e) => e.data()).toList())}");
    //
    // log("Data get from Firebase Storage");
    //
    // return completeLevelData.docs;
    /// get Data From SharedPreference
    var winData = [];
    noobExist.value = await SharedPref().getBoolValuesSF(StorageConstants.noobExist);
    internExist.value = await SharedPref().getBoolValuesSF(StorageConstants.internExist);
    expertExist.value = await SharedPref().getBoolValuesSF(StorageConstants.expertExist);
    masterExist.value = await SharedPref().getBoolValuesSF(StorageConstants.masterExist);
    legendExist.value = await SharedPref().getBoolValuesSF(StorageConstants.legendExist);
    bool userEnter = await SharedPref().getBoolValuesSF(StorageConstants.userEnter);
    if(userEnter || ((levelIndex == 0 && noobExist.value) ||
        (levelIndex == 1  && internExist.value) ||
        (levelIndex == 2 && expertExist.value) ||
        (levelIndex == 3 && masterExist.value) ||
        (levelIndex == 4 && legendExist.value))){
      QuerySnapshot<Map<String, dynamic>> completeLevelData = await fireStore
          .collection(FirebaseConstant.userKey)
          .doc(userDeviceID)
          .collection(levelName.toLowerCase())
          .orderBy(FirebaseConstant.userLevel, descending: false)
          .get();
      var winLocal = [];
      winLocal.addAll(completeLevelData.docs.map((e) => e.data()).toList());
      await SharedPref().addStringToSF(levelName.toLowerCase(), jsonEncode(winLocal));

      completedLevelLength.value =  completeLevelData.docs.length;
      return completeLevelData.docs;
    }else{
      var winLocal = await SharedPref().getStringValuesSF(levelName.toLowerCase());
      winData = await jsonDecode(winLocal);
      completedLevelLength.value = winData.length ;
      return winData;
    }
  }

  /// get celebrityLevel list from json
  Future<List> loadCelebJsonData() async {
    var jsonText = levelIndex == 0
        ? await rootBundle.loadString(StorageConstants.noobJsonData)
        : levelIndex == 1
            ? await rootBundle.loadString(StorageConstants.internJsonData)
            : levelIndex == 2
                ? await rootBundle.loadString(StorageConstants.expertJsonData)
                : levelIndex == 3
                    ? await rootBundle
                        .loadString(StorageConstants.masterJsonData)
                    : await rootBundle
                        .loadString(StorageConstants.legendJsonData);

    celebJsonData = json.decode(jsonText);

    return celebJsonData[levelIndex == 0
        ? completeLevel.length < 20
            ? FirebaseConstant.noobOne
            : completeLevel.length < 40
                ? FirebaseConstant.noobTwo
                : completeLevel.length < 60
                    ? FirebaseConstant.noobThree
                    : completeLevel.length < 80
                        ? FirebaseConstant.noobFour
                        : FirebaseConstant.noobFive
        : levelIndex == 1
            ? completeLevel.length < 20
                ? FirebaseConstant.internOne
                : completeLevel.length < 40
                    ? FirebaseConstant.internTwo
                    : completeLevel.length < 60
                        ? FirebaseConstant.internThree
                        : completeLevel.length < 80
                            ? FirebaseConstant.internFour
                            : FirebaseConstant.internFive
            : levelIndex == 2
                ? completeLevel.length < 20
                    ? FirebaseConstant.expertOne
                    : completeLevel.length < 40
                        ? FirebaseConstant.expertTwo
                        : completeLevel.length < 60
                            ? FirebaseConstant.expertThree
                            : completeLevel.length < 80
                                ? FirebaseConstant.expertFour
                                : FirebaseConstant.expertFive
                : levelIndex == 3
                    ? completeLevel.length < 20
                        ? FirebaseConstant.masterOne
                        : completeLevel.length < 40
                            ? FirebaseConstant.masterTwo
                            : completeLevel.length < 60
                                ? FirebaseConstant.masterThree
                                : completeLevel.length < 80
                                    ? FirebaseConstant.masterFour
                                    : FirebaseConstant.masterFive
                    : completeLevel.length < 20
                        ? FirebaseConstant.legendOne
                        : completeLevel.length < 40
                            ? FirebaseConstant.legendTwo
                            : completeLevel.length < 60
                                ? FirebaseConstant.legendThree
                                : completeLevel.length < 80
                                    ? FirebaseConstant.legendFour
                                    : FirebaseConstant.legendFive];
  }

  /// get celebrityLevel list from firebase
  // getCeleb() async {
  //   var celebData = levelIndex == 0
  //       ? await FirebaseFirestore.instance
  //           .collection(FirebaseConstant.gamePlay)
  //           .doc(FirebaseConstant.noob)
  //           .collection(completeLevel.length < 40
  //               ? FirebaseConstant.noobOne
  //               : completeLevel.length < 80
  //                   ? FirebaseConstant.noobTwo
  //                   : completeLevel.length < 120
  //                       ? FirebaseConstant.noobThree
  //                       : completeLevel.length < 160
  //                           ? FirebaseConstant.noobFour
  //                           : FirebaseConstant.noobFive)
  //           .get()
  //       : levelIndex == 1
  //           ? await FirebaseFirestore.instance
  //               .collection(FirebaseConstant.gamePlay)
  //               .doc(FirebaseConstant.intern)
  //               .collection(completeLevel.length < 40
  //                   ? FirebaseConstant.internOne
  //                   : completeLevel.length < 80
  //                       ? FirebaseConstant.internTwo
  //                       : completeLevel.length < 120
  //                           ? FirebaseConstant.internThree
  //                           : completeLevel.length < 160
  //                               ? FirebaseConstant.internFour
  //                               : FirebaseConstant.internFive)
  //               .get()
  //           : levelIndex == 2
  //               ? await FirebaseFirestore.instance
  //                   .collection(FirebaseConstant.gamePlay)
  //                   .doc(FirebaseConstant.expert)
  //                   .collection(completeLevel.length < 40
  //                       ? FirebaseConstant.expertOne
  //                       : completeLevel.length < 80
  //                           ? FirebaseConstant.expertTwo
  //                           : completeLevel.length < 120
  //                               ? FirebaseConstant.expertThree
  //                               : completeLevel.length < 160
  //                                   ? FirebaseConstant.expertFour
  //                                   : FirebaseConstant.expertFive)
  //                   .get()
  //               : levelIndex == 3
  //                   ? await FirebaseFirestore.instance
  //                       .collection(FirebaseConstant.gamePlay)
  //                       .doc(FirebaseConstant.master)
  //                       .collection(completeLevel.length < 40
  //                           ? FirebaseConstant.masterOne
  //                           : completeLevel.length < 80
  //                               ? FirebaseConstant.masterTwo
  //                               : completeLevel.length < 120
  //                                   ? FirebaseConstant.masterThree
  //                                   : completeLevel.length < 160
  //                                       ? FirebaseConstant.masterFour
  //                                       : FirebaseConstant.masterFive)
  //                       .get()
  //                   : await FirebaseFirestore.instance
  //                       .collection(FirebaseConstant.gamePlay)
  //                       .doc(FirebaseConstant.legend)
  //                       .collection(completeLevel.length < 40
  //                           ? FirebaseConstant.legendOne
  //                           : completeLevel.length < 80
  //                               ? FirebaseConstant.legendTwo
  //                               : completeLevel.length < 120
  //                                   ? FirebaseConstant.legendThree
  //                                   : completeLevel.length < 160
  //                                       ? FirebaseConstant.legendFour
  //                                       : FirebaseConstant.legendFive)
  //                       .get();
  //
  //   // For get data from firebase
  //   /*log("====> ${jsonEncode(celebData.docs.map((e) => e.data()).toList())}");*/
  //
  //   update();
  //   return celebData.docs;
  // }

  /// find Remain playing celebrityLevel list
  remainLevelList() async {
    List remainCelebs = [];

    if ((levelIndex == 0 && !noobExist.value) ||
        (levelIndex == 1 && !internExist.value) ||
        (levelIndex == 2 && !expertExist.value) ||
        (levelIndex == 3 && !masterExist.value) ||
        (levelIndex == 4 && !legendExist.value)) {


      for (element in celebrityData) {
        for (data in completeLevel) {

          /// remove played level from celebrity list
          remainCelebs.removeWhere((element) => element[FirebaseConstant.id] == data[FirebaseConstant.id],);

          if (!remainCelebs.contains(element)) {
            remainCelebs.add(element);
          }
          update();
        }
      }
      //// for remove last data from list after complete last level

      for (int i = 0; i < completeLevel.length; i++) {
        /// remove played level from celebrity list last level

        if (completeLevel.isNotEmpty && (remainCelebs.last[FirebaseConstant.id] == await completeLevel[i][FirebaseConstant.id])) {
          remainCelebs.removeLast();
          break;
        }
      }
    }
    return remainCelebs;
  }

  /// final ShowingCelebrity Level Complete Level Show First
  addDataOnFinalList({required bool levelName}){
    List celebData = [];
    if (!levelName) {
      remaingLevelData.shuffle();
      celebData.addAll(completeLevel);
      celebData.addAll(remaingLevelData);
    } else {
      celebrityData.shuffle();
      celebData.addAll(celebrityData);
    }

    return celebData;
  }

  finalCelebData() async {
    return levelIndex == 0 ? addDataOnFinalList(levelName: noobExist.value) :
    levelIndex == 1 ? addDataOnFinalList(levelName: internExist.value) :
    levelIndex == 2 ? addDataOnFinalList(levelName: expertExist.value) :
    levelIndex == 3 ? addDataOnFinalList(levelName: masterExist.value) :
    addDataOnFinalList(levelName: legendExist.value);
  }

}
