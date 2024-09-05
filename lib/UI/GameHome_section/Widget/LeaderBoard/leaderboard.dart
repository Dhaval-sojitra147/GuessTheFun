import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:celebrity_quiz/UI/GameHome_section/Widget/LeaderBoard/leaderboard_controller.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class LeaderBoard extends GetView<LeaderBoardController>{
  LeaderBoard({super.key,required this.userCoin});
  String userCoin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  top: displayHeight(context) * 0.03,bottom: displayHeight(context)*0.02),
              child: Container(
                height: displayHeight(context) * 0.065,
                width: displayWidth(context) * 0.9,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(50),
                    )),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.offNamedUntil(RoutesConstants.celebHomeScreen,(route) => true,);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: displayHeight(context) *0.0063),
                          child: Image(
                            image:
                            const AssetImage(ImageConstants.backIcon),
                            height: displayHeight(context) * 0.1,
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          left: displayWidth(context) * 0.04,
                          bottom: displayHeight(context) * 0.005),
                      child: Text(
                        AppConstants.leaderBoard.tr,
                        style: TextStyleConstant.textBold22(
                            color: ColorConstants.purpleColor),

                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(displayHeight(context)*0.02),
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: displayHeight(context)*0.008),
                      child: Container(
                        height: displayHeight(context)*0.1,
                        width: displayWidth(context),
                        decoration: BoxDecoration(
                          color: ColorConstants.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: displayWidth(context)*0.03),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: displayWidth(context)*0.07,
                                backgroundColor: ColorConstants.grey.withOpacity(0.5),
                                child: CircleAvatar(
                                  radius: displayWidth(context)*0.06,
                                  backgroundColor: ColorConstants.grey,
                                  child: Text(
                                    "$index",style: TextStyleConstant.textBold22(color: ColorConstants.black.withOpacity(0.6)),
                                  ),
                                ),
                              ),
                              SizedBox(width: displayWidth(context)*0.03,),
                              Image.asset(ImageConstants.personIcon,height: displayHeight(context)*0.05,),
                              SizedBox(width: displayWidth(context)*0.03,),
                              Text("UserName",style: TextStyleConstant.textBold24(color: ColorConstants.black.withOpacity(0.5)),),
                              SizedBox(width: displayWidth(context)*0.03,),
                              Container(
                                height: displayHeight(context)*0.04,
                                width: displayWidth(context)*0.2,
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(ImageConstants.goldStar,width: displayWidth(context)*0.07),
                                    Text("${index}",style: TextStyleConstant.textBold22(color: ColorConstants.white),)
                                  ],
                                ),
                              )



                            ],
                          ),
                        ),
                      ),
                    );
                  },),
              ),
            ),
            Container(
              height: displayHeight(context)*0.15,
              width: displayWidth(context),
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(ImageConstants.qaBase),fit: BoxFit.fill)
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: displayHeight(context)*0.02,horizontal: displayWidth(context)*0.02),
                child: Container(
                  height: displayHeight(context)*0.05,
                  width: displayWidth(context),
                  decoration: BoxDecoration(
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: displayWidth(context)*0.01),
                    child: Row(
                      children: [
                        // CircleAvatar(
                        //   radius: displayWidth(context)*0.07,
                        //   backgroundColor: ColorConstants.grey.withOpacity(0.5),
                        //   child: CircleAvatar(
                        //     radius: displayWidth(context)*0.06,
                        //     backgroundColor: ColorConstants.grey,
                        //     child: Text(
                        //       "$index",style: TextStyleConstant.textBold22(color: ColorConstants.black.withOpacity(0.6)),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(width: displayWidth(context)*0.03,),
                        Image.asset(ImageConstants.personIcon,height: displayHeight(context)*0.05,),
                        SizedBox(width: displayWidth(context)*0.03,),
                        Text("Golden wins by You",style: TextStyleConstant.textBold24(color: ColorConstants.black.withOpacity(0.5)),),
                        SizedBox(width: displayWidth(context)*0.03,),
                        Container(
                          height: displayHeight(context)*0.04,
                          width: displayWidth(context)*0.2,
                          decoration: BoxDecoration(
                              color: Colors.deepPurple.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(ImageConstants.goldStar,width: displayWidth(context)*0.07),
                              Text("${userCoin}",style: TextStyleConstant.textBold22(color: ColorConstants.white),)
                            ],
                          ),
                        )



                      ],
                    ),
                  ),
                ),
              ),
            )

          ],),
      ),
    );
  }
}