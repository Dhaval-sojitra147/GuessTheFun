import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:celebrity_quiz/UI/GameHome_section/Widget/SettingPopUP/in_app_browser.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class SettingDialog {
  SettingController settingController = Get.put(SettingController());
  CelebHomeController celebHomeController = Get.put(CelebHomeController());
  MyInAppBrowser browser = MyInAppBrowser();


  void settingDialog(context) {

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "hello",
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          alignment: Alignment(-0.6,0.8),
          child: DelayedDisplay(
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: ColorConstants.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              content: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                child: GetBuilder<SettingController>(
                    init: SettingController(),
                    builder: (controller) {
                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: displayHeight(context) > 550 && displayHeight(context) < 750 ? displayHeight(context) *0.57 :displayHeight(context) * 0.53,
                            width: displayWidth(context) * 0.8,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage(
                                      ImageConstants.settingPopUpBase)),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: displayHeight(context) * 0.1),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: displayHeight(context) *
                                                  0.05),
                                          child: GestureDetector(
                                            onTap: () async {
                                              celebHomeController
                                                  .animationController
                                                  .forward();
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 200), () {
                                                celebHomeController
                                                    .animationController
                                                    .reverse();
                                              });
                                              if (settingController
                                                  .sound.value) {
                                                settingController.sound.value =
                                                false;
                                                celebHomeController.music =
                                                false;
                                                SharedPref().setBoolToSF(StorageConstants.sound,
                                                    settingController
                                                        .sound.value);
                                              } else {
                                                settingController.sound.value =
                                                true;
                                                celebHomeController.music =
                                                true;
                                                SharedPref().setBoolToSF(StorageConstants.sound,
                                                    settingController
                                                        .sound.value);
                                              }
                                              settingController.sound.value =
                                              await SharedPref()
                                                  .getBoolValuesSF(StorageConstants.sound);
                                              _musicHandler();
                                              settingController.update();
                                            },
                                            child: ScaleTransition(
                                              scale: Tween<double>(
                                                begin: 1.0,
                                                end: 0.7,
                                              ).animate(celebHomeController
                                                  .animationController),
                                              child: Container(
                                                height: displayHeight(context) *
                                                    0.08,
                                                width: displayWidth(context) *
                                                    0.55,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(image: settingController.sound.value ==
                                                        true ? const AssetImage(ImageConstants.soundOn) : const AssetImage(ImageConstants.soundOff))
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: displayHeight(context) *
                                                  0.02,bottom: displayHeight(context)*0.04),
                                          child: GestureDetector(
                                            onTap: () async {
                                              if (settingController
                                                  .vibration.value) {
                                                settingController.vibration.value =
                                                false;
                                                SharedPref().setBoolToSF(StorageConstants.vibration,
                                                    settingController
                                                        .vibration.value);
                                              } else {
                                                settingController.vibration.value =
                                                true;
                                                Vibration.vibrate(duration: 500, amplitude: 300);
                                                SharedPref().setBoolToSF(StorageConstants.vibration,
                                                    settingController
                                                        .vibration.value);
                                              }
                                              settingController.vibration.value =
                                              await SharedPref()
                                                  .getBoolValuesSF(StorageConstants.vibration);
                                              _musicHandler();
                                              settingController.update();
                                            },
                                            child: Container(
                                              height: displayHeight(context) *
                                                  0.08,
                                              width: displayWidth(context) *
                                                  0.55,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(image: settingController.vibration.value ==
                                                      true ? const AssetImage(ImageConstants.vibrationOn) : const AssetImage(ImageConstants.vibrationOff))
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.center,
                                        //   children: [
                                        //     Text(
                                        //       AppConstants.english.tr,
                                        //       style:
                                        //           TextStyleConstant.textBold32(
                                        //               color:
                                        //                   ColorConstants.blue),
                                        //     ),
                                        //     GestureDetector(
                                        //       onTap: () {
                                        //         settingController
                                        //             .currentIndex.value = 0;
                                        //         TranslationService()
                                        //             .changeLocale("en");
                                        //
                                        //         SharedPref().setInt(
                                        //             settingController
                                        //                 .currentIndex.value);
                                        //         settingController.update();
                                        //       },
                                        //       child: Padding(
                                        //         padding: EdgeInsets.only(
                                        //             left:
                                        //                 displayHeight(context) *
                                        //                     0.03),
                                        //         child: Container(
                                        //           height:
                                        //               displayHeight(context) *
                                        //                   0.04,
                                        //           width: displayWidth(context) *
                                        //               0.09,
                                        //           decoration: BoxDecoration(
                                        //               shape: BoxShape.circle,
                                        //               color:
                                        //                   ColorConstants.white,
                                        //               border: Border.all(
                                        //                   color: ColorConstants
                                        //                       .offWhiteColor,
                                        //                   width: displayWidth(
                                        //                           context) *
                                        //                       0.02)),
                                        //           child: Padding(
                                        //             padding:
                                        //                 const EdgeInsets.all(
                                        //                     3.0),
                                        //             child: Container(
                                        //               width: displayWidth(
                                        //                       context) *
                                        //                   0.001,
                                        //               decoration: BoxDecoration(
                                        //                 shape: BoxShape.circle,
                                        //                 color: settingController
                                        //                             .currentIndex
                                        //                             .value ==
                                        //                         0
                                        //                     ? ColorConstants
                                        //                         .darkOrange
                                        //                     : ColorConstants
                                        //                         .white,
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     )
                                        //   ],
                                        // ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.center,
                                        //   children: [
                                        //     Text(
                                        //       AppConstants.hindi.tr,
                                        //       style:
                                        //           TextStyleConstant.textBold32(
                                        //               color: ColorConstants
                                        //                   .darkOrange),
                                        //     ),
                                        //     GestureDetector(
                                        //       onTap: () {
                                        //         settingController.currentIndex.value = 1;
                                        //         TranslationService()
                                        //             .changeLocale("hi");
                                        //         SharedPref().setInt(
                                        //             settingController.currentIndex.value);
                                        //         settingController.update();
                                        //       },
                                        //       child: Padding(
                                        //         padding: EdgeInsets.only(
                                        //             left: displayHeight(context) * 0.05),
                                        //         child: Container(
                                        //           height:
                                        //               displayHeight(context) * 0.04,
                                        //           width: displayWidth(context) * 0.09,
                                        //           decoration: BoxDecoration(
                                        //               shape: BoxShape.circle,
                                        //               color: ColorConstants.white,
                                        //               border: Border.all(
                                        //                   color: ColorConstants.offWhiteColor,
                                        //                   width: displayWidth(context) * 0.02)),
                                        //           child: Padding(
                                        //             padding:
                                        //                 const EdgeInsets.all(
                                        //                     3.0),
                                        //             child: Container(
                                        //               width: displayWidth(
                                        //                       context) *
                                        //                   0.001,
                                        //               decoration: BoxDecoration(
                                        //                 shape: BoxShape.circle,
                                        //                 color: settingController.currentIndex.value == 1
                                        //                     ? ColorConstants.darkOrange
                                        //                     : ColorConstants.white,
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     )
                                        //   ],
                                        // ),
                                        GestureDetector(onTap: () async{
                                          await browser.openUrlRequest(
                                              urlRequest:
                                              URLRequest(url: Uri.parse("https://guessthefun.com/terms.html")),
                                              options: InAppBrowserClassOptions(
                                                  crossPlatform: InAppBrowserOptions(
                                                    hideToolbarTop: true,
                                                  )
                                              )

                                          );
                                        },child: Text(AppConstants.terms.tr,style: TextStyleConstant.textBold24(color: ColorConstants.purpleColor.withOpacity(0.8)),),),

                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: GestureDetector(
                                      onTap: () {
                                        settingController
                                            .animationController
                                            .forward();
                                        Future.delayed(
                                            const Duration(
                                                milliseconds: 200), () {
                                          settingController
                                              .animationController
                                              .reverse();
                                        });
                                        Future.delayed(
                                          const Duration(milliseconds: 500),
                                              () => Get.back(),
                                        );
                                      },
                                      child: ScaleTransition(
                                        scale: Tween<double>(
                                          begin: 1.0,
                                          end: 0.7,
                                        ).animate(settingController
                                            .animationController),
                                        child: Container(
                                          height: displayHeight(context) *
                                              0.1,
                                          width:
                                          displayWidth(context) * 0.35,
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(image: AssetImage(ImageConstants.doneButton),fit: BoxFit.fill)),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),);

  }

  void _musicHandler() {
    if (settingController.sound.value) {
      // AudioPlayer.playMusic();
    } else {
      AudioPlayer.toggleLoop();
      AudioPlayer.stopMusic();
    }
  }
}
