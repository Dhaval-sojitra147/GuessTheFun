import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class QuitDialog {
  SettingController settingController = Get.put(SettingController());
  CelebHomeController celebHomeController = Get.put(CelebHomeController());

  void quitDialog({required context, void Function()? onTap,required AlignmentGeometry? alignmentGeometry,void Function() ? onNoTap}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "hello",
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          alignment: alignmentGeometry,
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
                child:  Container(
                  height: displayHeight(context) > 550 && displayHeight(context) < 700 ? displayHeight(context) *0.57 :displayHeight(context) * 0.53,
                  width: displayWidth(context) * 0.8,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage(
                            ImageConstants.quitBase)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: displayHeight(context) * 0.15),
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: displayHeight(context) * 0.13,
                                width: displayWidth(context) * 0.6,
                                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(ImageConstants.faceEmoji))),

                              ),
                              Text(AppConstants.quitConfirmation.tr,
                                  style: TextStyleConstant.textBold26(
                                    color: ColorConstants.purpleColor.withOpacity(0.7),
                                    shadow: const Shadow(
                                            blurRadius: 40.0,
                                            color: Colors.grey,
                                            offset: Offset(2.0, 2.0),),),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0, 0.5),
                          child: GestureDetector(
                            onTap: onNoTap ?? () {
                              settingController.animationController.forward();
                              Future.delayed(const Duration(milliseconds: 200), () {
                                settingController.animationController.reverse();
                              });
                              Future.delayed(
                                const Duration(milliseconds: 500), () => Get.back(),
                              );
                            } ,
                            child: ScaleTransition(
                              scale: Tween<double>(
                                begin: 1.0,
                                end: 0.7,
                              ).animate(settingController.animationController),
                              child: Container(
                                height: displayHeight(context) * 0.08,
                                width: displayWidth(context) * 0.46,
                                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(ImageConstants.noButton))),
                              ),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment(0,1.0),
                          child: GestureDetector(
                            onTap: onTap ?? () {
                              celebHomeController.animationController.forward();
                              Future.delayed(const Duration(milliseconds: 200), () {
                                celebHomeController.animationController.reverse();
                              });
                              Future.delayed(
                                const Duration(milliseconds: 500),
                                    () {
                                  if (Platform.isAndroid) {
                                    SystemNavigator.pop();
                                  } else if (Platform.isIOS) {
                                    exit(0);
                                  }
                                },
                              );
                            },
                            child: ScaleTransition(
                              scale: Tween<double>(
                                begin: 1.0,
                                end: 0.7,
                              ).animate(celebHomeController.animationController),
                              child: Container(
                                height: displayHeight(context) * 0.08,
                                width: displayWidth(context) * 0.37,
                                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(ImageConstants.yesButton))),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),);
  }

}
