import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Scaffold(
        body: Container(
          height: displayHeight(context),
          width: displayWidth(context),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageConstants.mainLevelBg),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: displayHeight(context) * 0.05,bottom: displayHeight(context)*0.03),
                child: Container(
                  height: displayHeight(context) * 0.06,
                  width: displayWidth(context) * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(displayWidth(context)*0.1)),
                  child: Center(child: Text(AppConstants.welcome,style: TextStyleConstant.textBold28(color: ColorConstants.purpleColor.withOpacity(0.9)),)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: displayWidth(context) * 0.04,),
                child: Container(
                    height: displayHeight(context) * 0.6,
                    width: displayWidth(context),
                    decoration: BoxDecoration(
                        color: ColorConstants.white,
                        borderRadius: BorderRadius.circular(displayWidth(context)*0.1)),
                    child: Center(child: Text(AppConstants.welcomeDetail.tr,style: TextStyleConstant.textBold22(color: ColorConstants.black.withOpacity(0.6)),textAlign: TextAlign.center,))
                ),
              ),
              SizedBox(height: displayHeight(context)*0.08,),
              GestureDetector(
                  onTap: () {
                    Get.off(()=> const DisclaimerScreen());
                  },
                  child: Image(image: const AssetImage(ImageConstants.gotItButton),height: displayHeight(context)*0.11,width: displayWidth(context)*0.46,))
            ],
          ),
        ),
      ),
    );
  }

}
