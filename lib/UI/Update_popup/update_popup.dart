import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

Widget updateDialog(context) {

  return AlertDialog(
    contentPadding: EdgeInsets.zero,
    backgroundColor: ColorConstants.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    ),
    content: MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 0.8),
      child: Container(
        height: displayHeight(context) * 0.53,
        width: displayWidth(context) * 0.8,
        decoration: BoxDecoration(
          image: const DecorationImage(image: AssetImage(ImageConstants.updateBase)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
              onTap: () {
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
                    mode: LaunchMode
                        .externalApplication,
                  );
                }
              },
              child: Image(image: AssetImage(ImageConstants.updateButton),width: displayWidth(context)*0.4,height: displayHeight(context)*0.1,)),
        ),
      ),
    ),
  );
}