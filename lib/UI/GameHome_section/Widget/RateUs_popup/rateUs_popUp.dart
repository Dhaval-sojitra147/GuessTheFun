import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class RateUsDialog {
  CelebHomeController celebHomeController = Get.put(CelebHomeController());
  void rateUsDialog(context) {

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
          alignment: const Alignment(-0.2,0.8),
          child: DelayedDisplay(
            child: AlertDialog(

              contentPadding: EdgeInsets.zero,
              backgroundColor: ColorConstants.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16),),
              ),
              content: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: Container(
                  height: displayHeight(context) > 550 && displayHeight(context) < 750 ? displayHeight(context) *0.57 :displayHeight(context) * 0.53,
                  width: displayWidth(context) * 0.8,
                  decoration: BoxDecoration(
                    image: const DecorationImage(image: AssetImage(ImageConstants.rateUsPopUpBase)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: displayHeight(context) * 0.11),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppConstants.enjoyGame.tr,
                              style: TextStyleConstant.textBold26(
                                  color: ColorConstants.purpleColor.withOpacity(0.4)),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: displayWidth(context) * 0.05,vertical: displayHeight(context)*0.02),
                              child: Text(AppConstants.shareSomeTime.tr,
                                  style: TextStyleConstant.textBold26(
                                      color: ColorConstants.purpleColor.withOpacity(0.4)),
                                  textAlign: TextAlign.center),
                            ),
                            Image(
                              image: const AssetImage(ImageConstants.rateUsStar),
                              height: displayHeight(context) * 0.07,
                            ),
                            displayHeight(context) > 550 && displayHeight(context) < 750 ?SizedBox(height: displayHeight(context) *0.05):SizedBox(height: 1,),
                            GestureDetector(
                              onTap: () {
                                celebHomeController.animationController.forward();
                                Future.delayed(const Duration(milliseconds: 200), () {
                                  celebHomeController.animationController.reverse();
                                });
                                if (Platform.isAndroid || Platform.isIOS) {
                                  final appId = Platform.isAndroid
                                      ? 'com.celebquizwho.app'
                                      : 'YOUR_IOS_APP_ID';
                                  final url = Uri.parse(
                                    Platform.isAndroid
                                        ? "market://details?id=$appId"
                                        : "https://apps.apple.com/app/id$appId",
                                  );
                                  launchUrl(
                                    url,
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                              child: ScaleTransition(
                                scale: Tween<double>(
                                  begin: 1.0,
                                  end: 0.7,
                                ).animate(celebHomeController.animationController),
                                child: Container(
                                  height: displayHeight(context) * 0.08,
                                  width: displayWidth(context) * 0.45,
                                  decoration: BoxDecoration(
                                      gradient: ColorConstants.soundOnOFF,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: ColorConstants.white
                                              .withOpacity(0.95),
                                          width: 5)),
                                  child: Center(
                                      child: Text(
                                        AppConstants.rateNow.tr,
                                        style: TextStyleConstant.textBold26(
                                            color: ColorConstants.white),
                                      )),
                                ),
                              ),
                            ),

                          ],
                        ),
                        Align(
                          alignment: const Alignment(0,0.9),
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: displayHeight(context) * 0.08,
                              width: displayWidth(context) * 0.4,
                              decoration: BoxDecoration(
                                  gradient: ColorConstants.buttonGradient,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: ColorConstants.white.withOpacity(0.95),
                                      width: 5)),
                              child: Center(
                                  child: Text(
                                    AppConstants.later.tr,
                                    style: TextStyleConstant.textBold26(
                                        color: ColorConstants.white),
                                  )),
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
      transitionDuration: const Duration(milliseconds: 400),);

  }
}
