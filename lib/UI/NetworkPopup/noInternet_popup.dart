import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

Widget  noInternetDialog(
    {context}) {
  NetworkController networkController = Get.put(NetworkController());

  return DelayedDisplay(
    child: AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: ColorConstants.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          200
        ),

      ),
      content: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: Container(
          height: displayHeight(context) * 0.53,
          width: displayWidth(context) * 0.8,
          decoration: BoxDecoration(
            image: const DecorationImage(image: AssetImage(ImageConstants.noInternetBase,)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: displayWidth(context)*0.05,left: displayWidth(context)*0.05,top: displayHeight(context)*0.3,bottom: displayHeight(context)*0.01),
                child: Text(AppConstants.checkInternet.tr,style: TextStyleConstant.textBold20(color: ColorConstants.purpleColor.withOpacity(0.5)),textAlign: TextAlign.center),
              ),
              GestureDetector(
                  onTap: () {
                    networkController.checkInternet();
                  },
                  child: Image.asset(
                    ImageConstants.retryButton,
                    height: displayHeight(context) * 0.11,
                  ))
            ],
          ),
        ),
      ),
    ),
  );
}